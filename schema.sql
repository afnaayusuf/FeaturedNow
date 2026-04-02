-- ============================================================
-- RAINFONT — Complete Database Schema
-- Run this entire file in your Supabase SQL Editor (one shot)
-- ============================================================

-- ── Extensions ───────────────────────────────────────────────
create extension if not exists "uuid-ossp";

-- ── Enums ────────────────────────────────────────────────────
create type intent_type as enum ('hypothesis', 'milestone', 'directive', 'consensus', 'inquiry');
create type post_status as enum ('live', 'retracted', 'pending_review');
create type node_domain as enum ('cs', 'ee', 'bio', 'hum', 'mech', 'math', 'phys', 'env');
create type signoff_status as enum ('pending', 'signed', 'declined');
create type convene_outcome as enum ('winner', 'finalist', 'participant');

-- ── profiles ─────────────────────────────────────────────────
-- One row per user. Created automatically on signup via trigger.
create table profiles (
  id            uuid primary key references auth.users(id) on delete cascade,
  full_name     text not null,
  institution   text not null,
  year          text,                        -- '1st yr', '2nd yr', 'PhD', 'Guide', etc.
  domain        node_domain,
  orcid         text,
  bio           text,
  is_guide      boolean default false,       -- Guides can post Directives, issue Seals
  is_verified   boolean default false,       -- institution email verified
  avatar_url    text,
  folio_slug    text unique,                 -- rainfont.app/folio/:slug
  inquiry_quota_used   int default 0,
  inquiry_quota_resets timestamptz default (now() + interval '7 days'),
  created_at    timestamptz default now()
);

-- Auto-create profile on auth.users insert
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
  insert into public.profiles (id, full_name, institution, folio_slug)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'full_name', 'Scholar'),
    coalesce(new.raw_user_meta_data->>'institution', ''),
    coalesce(new.raw_user_meta_data->>'folio_slug', new.id::text)
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ── nodes ────────────────────────────────────────────────────
create table nodes (
  id          uuid primary key default uuid_generate_v4(),
  name        text not null unique,          -- 'Gradient', 'Bare Metal', etc.
  domain      node_domain not null,
  color       text default '#3b82f6',        -- tailwind color for the dot
  charter     text,                          -- founding charter text
  created_at  timestamptz default now()
);

-- seed the existing nodes
insert into nodes (name, domain, color) values
  ('Gradient',     'cs',   '#3b82f6'),
  ('Bare Metal',   'ee',   '#22c55e'),
  ('Softer',       'hum',  '#a855f7'),
  ('Dark Current', 'cs',   '#f97316'),
  ('Bio-Sys',      'bio',  '#ef4444'),
  ('Signal Chain', 'ee',   '#06b6d4'),
  ('Neural Fold',  'cs',   '#8b5cf6'),
  ('Null Space',   'math', '#64748b');

-- ── node_members ─────────────────────────────────────────────
create table node_members (
  user_id    uuid references profiles(id) on delete cascade,
  node_id    uuid references nodes(id) on delete cascade,
  joined_at  timestamptz default now(),
  primary key (user_id, node_id)
);

-- ── posts ────────────────────────────────────────────────────
create table posts (
  id              uuid primary key default uuid_generate_v4(),
  author_id       uuid references profiles(id) on delete cascade,
  node_id         uuid references nodes(id),
  title           text not null,
  abstract        text,
  body            text not null,
  intent          intent_type not null,
  status          post_status default 'live',
  is_parallel     boolean default false,      -- open for cross-institution contrib
  vault_artifact  text,                       -- path in Supabase Storage
  vault_filename  text,
  ai_domain_conf  int,                        -- 0-100, classifier confidence
  guide_sealed    boolean default false,
  guide_sealed_by uuid references profiles(id),
  guide_sealed_at timestamptz,
  retraction_reason text,
  retracted_at    timestamptz,
  created_at      timestamptz default now(),
  updated_at      timestamptz default now()
);

-- ── addenda ──────────────────────────────────────────────────
create table addenda (
  id         uuid primary key default uuid_generate_v4(),
  post_id    uuid references posts(id) on delete cascade,
  author_id  uuid references profiles(id) on delete cascade,
  body       text not null,
  created_at timestamptz default now()
);

-- ── signoffs ─────────────────────────────────────────────────
-- Parallel consensus sign-offs required per intent type
create table signoffs (
  id          uuid primary key default uuid_generate_v4(),
  post_id     uuid references posts(id) on delete cascade,
  signee_id   uuid references profiles(id) on delete cascade,
  status      signoff_status default 'pending',
  signed_at   timestamptz,
  created_at  timestamptz default now(),
  unique (post_id, signee_id)
);

-- ── reviews ──────────────────────────────────────────────────
create table reviews (
  id           uuid primary key default uuid_generate_v4(),
  post_id      uuid references posts(id) on delete cascade,
  reviewer_id  uuid references profiles(id) on delete cascade,
  clarity      smallint check (clarity between 1 and 5),
  depth        smallint check (depth between 1 and 5),
  body         text not null,                 -- minimum 40 words enforced client-side
  created_at   timestamptz default now(),
  unique (post_id, reviewer_id)              -- one review per person per post
);

-- ── inquiry_responses ────────────────────────────────────────
create table inquiry_responses (
  id           uuid primary key default uuid_generate_v4(),
  post_id      uuid references posts(id) on delete cascade,
  responder_id uuid references profiles(id) on delete cascade,
  response_type text check (response_type in ('support', 'challenge', 'extend')),
  body         text not null,
  created_at   timestamptz default now()
);

-- ── vault_files ──────────────────────────────────────────────
create table vault_files (
  id           uuid primary key default uuid_generate_v4(),
  uploader_id  uuid references profiles(id) on delete cascade,
  node_id      uuid references nodes(id),
  post_id      uuid references posts(id),     -- null = standalone vault upload
  filename     text not null,
  storage_path text not null,                 -- path in Supabase Storage bucket
  file_size    bigint,
  mime_type    text,
  version      text default 'v1.0',
  tags         text[],
  fork_count   int default 0,
  forked_from  uuid references vault_files(id),
  created_at   timestamptz default now()
);

-- ── convenes ─────────────────────────────────────────────────
create table convenes (
  id           uuid primary key default uuid_generate_v4(),
  node_id      uuid references nodes(id),
  title        text not null,
  description  text,
  location     text,
  starts_at    timestamptz,
  ends_at      timestamptz,
  organiser_id uuid references profiles(id),
  max_seats    int,
  created_at   timestamptz default now()
);

-- ── convene_registrations ────────────────────────────────────
create table convene_registrations (
  user_id     uuid references profiles(id) on delete cascade,
  convene_id  uuid references convenes(id) on delete cascade,
  outcome     convene_outcome,
  registered_at timestamptz default now(),
  primary key (user_id, convene_id)
);

-- ── notifications ────────────────────────────────────────────
create table notifications (
  id          uuid primary key default uuid_generate_v4(),
  user_id     uuid references profiles(id) on delete cascade,
  type        text not null,   -- 'review', 'seal', 'parallel', 'signoff', 'inquiry_response'
  title       text not null,
  subtitle    text,
  read        boolean default false,
  related_post_id uuid references posts(id),
  created_at  timestamptz default now()
);

-- ── credibility_stack view ───────────────────────────────────
-- Pre-computed per user — used on Folio page
create or replace view credibility_stack as
select
  p.id as user_id,
  count(distinct po.id)                                          as total_posts,
  count(distinct po.id) filter (where po.intent = 'hypothesis') as hypothesis_count,
  count(distinct po.id) filter (where po.intent = 'milestone')  as milestone_count,
  count(distinct po.id) filter (where po.intent = 'directive')  as directive_count,
  count(distinct po.id) filter (where po.intent = 'consensus')  as consensus_count,
  count(distinct po.id) filter (where po.intent = 'inquiry')    as inquiry_count,
  count(distinct po.id) filter (where po.vault_artifact is not null) as vault_tethered,
  count(distinct so.id) filter (where so.signee_id = p.id and so.status = 'signed') as signoffs_given,
  count(distinct so2.post_id) filter (where so2.signee_id = p.id and so2.status = 'signed') as named_signatory_count,
  count(distinct re.id)                                          as reviews_written,
  count(distinct po.id) filter (where po.guide_sealed = true)   as seals_received
from profiles p
left join posts po on po.author_id = p.id and po.status = 'live'
left join signoffs so on so.signee_id = p.id
left join signoffs so2 on so2.signee_id = p.id and so2.status = 'signed'
left join reviews re on re.reviewer_id = p.id
group by p.id;

-- ── Row Level Security ───────────────────────────────────────
alter table profiles             enable row level security;
alter table posts                enable row level security;
alter table addenda              enable row level security;
alter table signoffs             enable row level security;
alter table reviews              enable row level security;
alter table inquiry_responses    enable row level security;
alter table vault_files          enable row level security;
alter table notifications        enable row level security;
alter table node_members         enable row level security;
alter table convene_registrations enable row level security;

-- profiles: anyone can read, only owner can write
create policy "profiles_read_all"   on profiles for select using (true);
create policy "profiles_write_own"  on profiles for update using (auth.uid() = id);

-- posts: anyone can read live posts, only author can insert/update
create policy "posts_read_live"     on posts for select using (status = 'live' or auth.uid() = author_id);
create policy "posts_insert_own"    on posts for insert with check (auth.uid() = author_id);
create policy "posts_update_own"    on posts for update using (auth.uid() = author_id);

-- addenda: anyone reads, author inserts
create policy "addenda_read_all"    on addenda for select using (true);
create policy "addenda_insert_own"  on addenda for insert with check (auth.uid() = author_id);

-- reviews: anyone reads, any auth user inserts
create policy "reviews_read_all"    on reviews for select using (true);
create policy "reviews_insert_auth" on reviews for insert with check (auth.uid() = reviewer_id);

-- signoffs: anyone reads, any auth user inserts/updates their own
create policy "signoffs_read_all"   on signoffs for select using (true);
create policy "signoffs_own"        on signoffs for all using (auth.uid() = signee_id);

-- inquiry_responses: anyone reads, auth users insert
create policy "inq_resp_read_all"   on inquiry_responses for select using (true);
create policy "inq_resp_insert"     on inquiry_responses for insert with check (auth.uid() = responder_id);

-- vault_files: anyone reads, uploader inserts
create policy "vault_read_all"      on vault_files for select using (true);
create policy "vault_insert_own"    on vault_files for insert with check (auth.uid() = uploader_id);

-- notifications: only the recipient
create policy "notif_own"           on notifications for all using (auth.uid() = user_id);

-- node_members: anyone reads, auth users manage own
create policy "node_members_read"   on node_members for select using (true);
create policy "node_members_own"    on node_members for all using (auth.uid() = user_id);

-- convene_registrations
create policy "convene_reg_read"    on convene_registrations for select using (true);
create policy "convene_reg_own"     on convene_registrations for all using (auth.uid() = user_id);

-- ── Storage bucket ───────────────────────────────────────────
-- Run this separately in the Supabase dashboard if the SQL editor doesn't support it,
-- or use the Storage UI to create a public bucket named 'vault'
-- insert into storage.buckets (id, name, public) values ('vault', 'vault', false);
