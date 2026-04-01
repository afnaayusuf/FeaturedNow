# MERIDIAN — COMPLETE FUNCTIONAL BUILD PROMPT
# Based on: 5-screen HTML base (Ledger, Folio, Vault, Convene ×2)
# For: Stitch / any AI builder — full rebuild from this base
# Version: Final

---

## WHAT THIS APP IS

Meridian is a verified academic platform for students. Not a social
network. Not a portfolio site. A structured system where every account
is a real enrolled student, every post is domain-classified before it
publishes, and every feature solves a specific problem that currently
has no good solution for students in tier-2 and tier-3 colleges.

The five screens in the uploaded HTML are a structural starting point.
The visual direction — navy primary, white cards, pill tabs, frosted
glass nav — is correct and should be kept. What needs to change is the
functional layer: what each element does, what it says, and what is
missing.

This document tells you exactly how to build the complete app from
that base.

---

## DESIGN SYSTEM — LOCKED, DO NOT CHANGE

Font: Plus Jakarta Sans (already imported across all 5 pages — keep it)
Weights in use: 400 / 500 / 600 / 700 / 800 / Black (900 via font-black)

Color tokens (already defined in tailwind.config — use these consistently):
primary: #002444 — navy. Used on: nav text, card titles, CTA buttons
primary-container: #1A3A5C — slightly lighter navy. Used on: featured
  card backgrounds, avatar fills, strong accent
on-primary: #ffffff — white text on navy
on-primary-container: #87A4CC — muted blue-white. Used on: subtext
  on dark navy backgrounds
surface: #f8f9fa — the screen background. Slightly off-white, not pure
surface-container-low: #f3f4f5 — card backgrounds that sit on surface
surface-container-lowest: #ffffff — pure white. Used for elevated cards
secondary-container: #d0e9d4 — light green. Used on: verified seal
  badges and positive confirmation states
on-secondary-container: #546a59 — dark green text on the above
tertiary-container: #692003 — dark rust. Used on: urgent/critical labels
on-tertiary-container: #ef8661 — orange text on the above
error: #ba1a1a — used only for hard deadlines and error states
outline: #73777f — border and muted icon color
outline-variant: #c3c6cf — very light border on white cards

Border radius:
Cards and main containers: rounded-lg (0.5rem = 8px)
Buttons and pills: rounded-full (9999px) for pill tabs and chips
  rounded-xl (1.5rem = 24px) for action buttons like Register
Inner components: rounded (0.5rem default)

Shadow: shadow-sm on cards (resting), shadow-md on hover. This is the
Zomato-school card physics — light at rest, slightly heavier on hover.

Navigation: frosted glass top bar (bg-white/70 backdrop-blur-md) that
stays fixed. This is working correctly in all 5 pages. Keep it.

Bottom nav: fixed at bottom, white bg, border-t. Active item gets a
light bg-slate-100 rounded-xl pill. Keep this pattern.

---

## THE 5 EXISTING SCREENS — WHAT EACH ONE IS AND WHAT TO FIX

---

### PAGE 1 — LEDGER (Home Feed)

WHAT IT IS:
The first screen a student sees every time they open the app. It shows
academic posts from the Nodes (discipline communities) the student has
joined, along with Convene events and Vault materials mixed in. The
feed is not ranked by engagement — it is sorted by recency, with posts
that have received a Guide's Seal elevated to the top.

WHAT IS CURRENTLY BUILT:
Top bar: MERIDIAN wordmark left, notifications bell right. Correct.
Filter tabs: pill row with All / Computer Science / Humanities /
Bio-Engineering / Quantum. Scrollable horizontal row. Layout correct.
Featured card: navy-primary-container background showing a pinned post
with a "Featured Node" badge, title, abstract, author avatar, and a
"Read Full Access" button. Layout correct.
Feed: 3 article cards. Card 1 has a NODE_0x442 label + VERIFIED SEAL
badge + 2 file attachments + Review / Parallel / Bookmark actions.
Card 2 has NODE_0x789 + same actions. Card 3 has a CRITICAL NODE label
+ "142 CITATIONS" count + orange left border accent.
Bottom nav: Ledger / Nodes / Publish / Vault / Folio. Correct.
FAB (+) button: floating above bottom nav. Currently duplicates Publish.

WHAT NEEDS TO CHANGE, ELEMENT BY ELEMENT:

FILTER TABS — change the labels.
Current: All / Computer Science / Humanities / Bio-Engineering / Quantum
Correct: For You / Following / [Node names the student joined]
  / Convenes / Vault
The filter tabs represent the student's own Nodes, not global academic
categories. A student filtering by "Gradient" (an AI Node) sees only
posts from that Node. "For You" is the mixed default. "Following" shows
posts from specific Scholars the student explicitly follows.

FEATURED CARD — change the badge and button text.
Current badge: "Featured Node" — this means nothing specific.
Correct badge: two elements. Left: a small pill reading "SEALED" in
secondary-container green. Right: "✦ by Dr. [Guide name]" in a gold
or amber tone. The featured card is featured because a verified Guide
issued a Seal on it — that is the reason it is elevated, and that
reason should be visible.
Current button: "Read Full Access" — sounds like a paywall.
Correct button: "Open post" — simple, no implied restriction.
Add below the title: two score pills showing Clarity score and Depth
score with a review count. Example: "Clarity 4.7 · Depth 4.9 · 14
reviews." These scores come from peer reviews written by other Scholars
in the same Node. They are always visible on high-scoring posts.

CARD NODE TAGS — change the format.
Current: NODE_0x442, NODE_0x789 — hex-style placeholder strings.
Correct: readable Node names like "Gradient", "Bare Metal", "Softer",
"Dark Current". Each Node tag also has a small colored dot to the left
of the text, matching that Node's domain color. CS/AI nodes use a blue
dot. Hardware/EE nodes use a green dot. Biology nodes use a red dot.
Humanities nodes use a purple dot. This color system is consistent
across every screen.

CARD VERIFIED SEAL BADGE — keep structure, update meaning.
Current: "VERIFIED SEAL" in a secondary-container green pill.
Correct: "✦ Sealed" — shorter, and uses the ✦ symbol which is the
platform's consistent verification mark. The ✦ symbol appears on:
Guide-sealed posts, verified Scholar accounts, and verified Guide
accounts. Seeing ✦ anywhere on Meridian means something was manually
verified by a credentialed person.

CARD "142 CITATIONS" — remove entirely.
This metric does not exist in Meridian. Replace the entire Card 3
special treatment (the CRITICAL NODE label and citation count) with
the same peer review score pills used on other cards: Clarity, Depth,
review count. There is no separate "critical" tier of posts. Posts rise
in visibility when they have high peer review scores and Seals — not
when an admin labels them critical.

CARD ACTIONS ROW — keep Review, Parallel, Bookmark. Add one change.
The Review button should have the secondary-container green color on its
text when the user hasn't reviewed this post yet — it is an invitation
to act, not just a label. After the user has written a review, it
changes to "Reviewed ✓" in green. This is the key state change.
The Parallel button opens a bottom sheet explaining what Parallel means
and asking the student to submit a brief contribution request.
Bookmark is a toggle — filled icon when saved, outlined when not.

QUICK STATS ROW — add this, it does not exist in the current build.
Insert between the filter tabs and the featured card. Three equal-width
white cards in a horizontal row. Card 1: number of Nodes joined with
"N new posts" below. Card 2: number of pending reviews — posts in the
student's Nodes that other students have tagged them to review. Card 3:
Inquiry quota status — "1/1 used this week" and when it resets. If the
quota is full, the number in card 3 is shown in the error color.
These three cards tell the student their current platform status at a
glance before they start scrolling. This is one of the most important
additions to the screen — it makes the platform feel like a dashboard
the student is accountable to, not just a feed they scroll.

FAB BUTTON — remove it.
The floating (+) button above the bottom nav duplicates the Publish item
in the bottom nav. Remove the FAB. The Publish button in the bottom nav
should be styled as the elevated center button — slightly larger icon,
raised above the nav bar baseline — making it the obvious primary action.

---

### PAGE 2 — FOLIO (Student Profile)

WHAT IT IS:
The student's permanent academic record. A public URL that functions as
their portfolio. Every Ledger post they've published, every Vault file
they've contributed, every Convene they've participated in, and every
Seal they've received lives here. When a student applies for a research
program or internship, this is the URL they share.

WHAT IS CURRENTLY BUILT:
Profile header: rectangular photo with verified badge overlay. Name,
institution, department. Two chips: "Distinction" and "Verified Human".
Two buttons: "Request Access" and a Share icon.
Metrics grid: 4 cells — Ledger Posts (142), Seals Received (38), Impact
Score (9.4), Co-Authors (12).
Institutional Seals: horizontal scroll of 4 achievement cards —
Research Fellow / Gold Medalist / Summa Cum Laude / Integrity Seal.
Two-column bento layout: left has About text and links, right has
Ledger History showing 3 posts with like counts and share counts.

WHAT NEEDS TO CHANGE, ELEMENT BY ELEMENT:

PROFILE HEADER CHIPS — change both.
Current: "Distinction" and "Verified Human"
Correct chip 1: the student's primary domain — example "Computer
Science" or "Embedded Systems" — so a viewer immediately knows what
this person works in.
Correct chip 2: "Scholar ✦" — indicating this is a verified current
student. The ✦ mark is the only verification signal needed. "Verified
Human" is redundant since all accounts are verified.

HEADER BUTTONS — change "Request Access".
Current: "Request Access" — implies the Folio is gated.
Correct: "Share Folio" as the primary button (fills in navy). When
tapped, the device share sheet opens with the student's public URL:
meridian.app/folio/[username]. This is the moment of external use —
the student sharing their record with someone outside the platform.
Keep the share icon button as the secondary action. Rename it to
"Copy link" with a link icon.

METRICS GRID — change two of the four metrics.
Keep: Ledger Posts (142) — this is a direct count of published work.
Keep: Seals Received (38) — this is the most important credibility
signal on the platform, it should always be visible.
Change: "Impact Score 9.4" — this number is arbitrary and gameable.
Students will optimize for a score instead of doing good work. Replace
with "Reviews Written" — how many peer reviews this Scholar has
contributed. This shows academic engagement, not a computed score.
Change: "Co-Authors 12" — too vague and could include minor contributions.
Replace with "Nodes Active" — how many discipline communities this
student is a functioning member of. This shows breadth of academic
engagement.

INSTITUTIONAL SEALS SECTION — keep structure, update purpose.
This horizontal scroll of achievement cards is one of the best design
decisions in the current build. Keep it. But the Seals here should be
Guide-issued Seals (endorsements from verified professionals on specific
Ledger posts) — not generic achievement badges like "Summa Cum Laude".
Each Seal card should show: Guide's avatar (small, 28px), Guide's name
and institution, and the title of the Ledger post they Sealed, truncated
to 1 line. Tapping a Seal card opens the full Ledger post with the
Guide's endorsement text visible below it. This turns the Seals section
into a specific, verifiable track record — not a badge collection.

LEDGER HISTORY SECTION — change the stats shown on each item.
Current: each post shows a heart (like) count and a share count.
Correct: each post shows peer review scores. Format: "Clarity 4.7 ·
Depth 4.9 · 12 reviews." In green text. Replace like and share counts
with these quality metrics everywhere they appear. This is the central
anti-social-media decision of the platform.

MISSING: VAULT CONTRIBUTIONS TAB
Add a tab row below the profile header: "Published" / "Vault" / "Convenes"
The current Ledger History section becomes the Published tab.
Vault tab shows: all files this student has uploaded or forked, with
filename, subject, version number, and fork count ("14 forks" in navy
if forked by others).
Convenes tab shows: every event the student participated in, with an
outcome label — "Winner" in a gold/amber background, "Finalist" in navy,
"Participant" in gray. The outcome label is the most prominent element
in each row. Over time this tab becomes a competitive record that no
LinkedIn profile can replicate.

MISSING: SHARE FOLIO ROW
Add a persistent strip fixed at the bottom of the screen (just above
the bottom nav): the student's public URL in truncated gray text on the
left, "Share →" button on the right. This should always be visible when
the student is looking at their own Folio — it reminds them that this
is a shareable record, not a private profile.

NETWORK NODES SECTION — rename and rebuild.
Current: "Network Nodes" shows overlapping avatar circles with a "+42"
count. This looks like a follower/following section and violates the
no-follower-count rule.
Correct: rename to "Active Nodes" and show the student's joined Nodes
as a set of small named chips instead of avatar clusters. Each chip
shows the Node's colored dot and its name. Tapping a chip navigates to
that Node's feed. This is factually accurate (which discipline communities
does this person belong to?) and useful to a profile viewer.

---

### PAGE 3 — VAULT (Knowledge Library)

WHAT IT IS:
A permanent, searchable, attributed library of academic study materials.
Lecture notes, past papers, lab manuals, datasets, code repositories,
presentations. Every file has a verified contributor, a subject tag,
a version number, and a fork count. Students can fork any file — forking
creates a copy attributed to the forking student while preserving credit
to the original contributor. Files appear on the contributor's Folio.

WHAT IS CURRENTLY BUILT:
Header: "Knowledge Vault" title with "Manage your decentralised
intelligence infrastructure" subtitle. Two metric chips: "1,284 GB
Total Volumes" and "42.9k Verified Citations".
Search bar and three tabs: Library / Citations / Offline.
Main grid: 8-column left showing "Active Repositories" as a 2×2 grid
of folder cards (Neural_Arch_2024, Quantum_Entanglement_Refs,
Bio_Tech_Ethics_v2, plus a dashed "Initialize New Node" add card).
4-column right sidebar showing "Recent Saves" as a list of files.

WHAT NEEDS TO CHANGE, ELEMENT BY ELEMENT:

SCREEN HEADER — rewrite.
Current: "Knowledge Vault" / "Manage your decentralised intelligence
infrastructure."
Correct: "Vault" as the screen title (shorter, cleaner). Below it:
"Your academic library — shared, attributed, permanent." This is plain
language that a first-year student understands. No jargon about
decentralised infrastructure.

METRICS — replace.
Current: "1,284 GB Total Volumes" and "42.9k Verified Citations" — both
feel like enterprise infrastructure metrics.
Correct: "N files saved" (how many Vault files this student has
bookmarked or downloaded) and "N contributed" (how many files this
student has uploaded or forked). These are personal metrics about the
student's own Vault activity, not platform-wide stats.

FOLDER CARDS — reframe.
Current: folder names like "Neural_Arch_2024", "Quantum_Entanglement_Refs",
"Bio_Tech_Ethics_v2" — these read like GitHub repositories for a
research lab.
Correct: The Vault is not a personal repository manager. It is a
community knowledge library. The main content area should show files
from other students (uploaded to the student's Nodes), not personal
folders. Replace the 2×2 folder grid with a 2-column file card grid.

FILE CARD (replacing the folder card):
Each file card: white background, rounded-lg, shadow-sm.
Top: file type icon (PDF icon, dataset icon, etc.) in a 40px square
with domain-colored background. Top-right corner: a star bookmark icon.
Below icon: filename in font-bold text-primary, 2 lines max.
Below filename: contributor name in small text, with ✦ if verified,
plus their institution.
Below contributor: subject tags as small pills (e.g. "DSP" "FFT").
Bottom: "↗ N forks" in primary color if forks > 0. Version number in
outline gray. Last updated timestamp.

Tapping a file card opens a bottom sheet with: file preview (first page
of PDF if applicable), full metadata, the fork chain showing attribution
lineage, and two full-width buttons: "Fork this file" (primary navy fill)
and "Download for offline" (outline style).

TABS — keep Library / Citations / Offline, but clarify what each shows.
Library tab: all files from the student's Nodes, browseable, searchable.
Default sort: most forked this month first.
Citations tab: replaces the current "Citations" which had no implementation.
This tab shows all Ledger posts where the student's Vault files were
referenced. Every time another Scholar links to a file you uploaded,
it appears here. This is a usage-tracking feature — it tells a student
that their study notes were actually used by 24 people at other colleges.
Offline tab: files the student has downloaded for offline access. Shows
a storage meter at the top ("124 MB of 500 MB used") and a list of all
offline files with their sizes and download dates. A green dot marks
files that are accessible right now without internet.

SIDEBAR — rebuild from "Recent Saves" to "From Your Nodes".
Current: a static list of 4 files (whitepaper_final.pdf, node_metrics,
consensus_patch.sh, diagram_architecture.png) — these look like personal
saved files and don't demonstrate the knowledge-sharing purpose.
Correct: "New in your Nodes" sidebar showing the 4 most recently uploaded
Vault files across all Nodes the student has joined. Each item: file type
icon + filename + contributor + Node name + "New" badge if uploaded in
last 24 hours. This turns the sidebar into a live stream of what is being
shared in the student's academic communities.

UPLOAD BUTTON — clarify the FAB.
The current build has a FAB (+) with no label. On the Vault screen, this
FAB should clearly initiate a file upload. On mobile, the FAB should say
"Upload" with a cloud-upload icon so the action is unambiguous.

---

### PAGES 4 AND 5 — CONVENE (Events Browser)

NOTE: Pages 4 and 5 are identical files. This appears to be a duplication
in the submission. Both should be treated as one Convene screen. The fifth
screen slot should be used for the Compose (Publish) screen or the Nodes
browser — both of which are missing from the current set.

WHAT IT IS:
The event hub. Hackathons, research competitions, symposiums, workshops,
inter-college challenges. The platform's unique advantage here is that
registration is instant — student identity is already verified, so they
don't fill a Google Form. They tap once and they're registered. Results
are permanently saved to their Folio.

WHAT IS CURRENTLY BUILT:
Header: "Discovery Engine" eyebrow + "Convene for high-stakes research"
as the hero title. Filter chips: All Events / Hackathons / Symposiums
/ Workshops. "Refine Feed" button on desktop.
Featured carousel: 3 horizontally scrollable image cards with event
photos, badge labels (Featured / High Demand / New), location, date,
and title overlaid on a dark gradient.
Chronological list: events grouped by month (May / June) with sticky
month headers. Each event row: image left (1/4 width on desktop),
domain tag + title + description + 3-column metadata grid (date,
location, team status) + attendee count + Register button.
Desktop: left sidebar with icon-only navigation icons.

WHAT NEEDS TO CHANGE, ELEMENT BY ELEMENT:

HERO COPY — change.
Current: "Convene for high-stakes research." — intimidating for a
first-year student.
Correct: "Convene — find your next challenge." — inclusive. The word
"challenge" covers everything from a local college hackathon to a
major research competition. No student should feel this screen is not
for them.

REGISTER BUTTON — add the platform's core advantage to the label.
Current: "Register" — could be any platform.
Correct: "Register — Verified ✦" — communicates in the button itself
that the student's identity is pre-verified. They don't fill a form.
This is a feature and should be stated where the student acts on it.

REGISTERED STATE — add this missing state.
The current build has no concept of post-registration state. Once a
student taps "Register — Verified ✦", the entire bottom action row of
that event card transforms. The button disappears. In its place:
Left side: "Registered ✓" in secondary-container green text with a
green filled checkmark icon.
Right side: "View team →" as a text link in primary navy. Tapping this
opens the team formation board within the event.
This state change must be visible on every return visit to the Convene
screen so the student always knows which events they've registered for.

DEADLINE BADGE — add dynamic coloring.
Currently: the carousel cards have static badges (Featured / High Demand
/ New). These don't communicate urgency.
Correct: every event card in the chronological list should have a
deadline badge in the top-right corner of the card (or domain tag row).
Color rules: if closing in less than 3 days — error color background
(urgent). If closing in 3–7 days — tertiary-container warm amber (caution).
If closing in more than 7 days — surface-container gray (informational).
The text inside: "Xd left" — example "2d left" or "14d left."

ELIGIBILITY — make it visible on the card, not just inside the detail.
Currently: the 3-column metadata grid shows date, location, team status.
Change the third column from "Team Status" to "Eligibility" — showing
who can join: "Open to all" or "1st–3rd year" or "Research scholars only."
A student should know if they can enter from the card, not after tapping
into the detail view. "Limited Spots" in the error color (as currently
shown) is correct — keep that.

TEAM FORMATION BOARD — add this to the Convene detail view.
When a student opens a specific event (tapping through to the full
detail screen), after the problem statement and judging criteria,
add a section called "Looking for teammates." This shows a list of
registered students who joined solo and are looking for a team,
filterable by domain and institution. Each person shows: avatar (initials
circle) + name + institution + domain tags + an "Invite" button.
This section is only visible to students who have already registered
for that Convene. It solves a real and painful problem: hackathon
participants who can't find teammates after registering.

CAROUSEL CARDS — add deadline context.
Current: the 3 featured cards just show image + badge + location/date
+ title. No urgency signal.
Correct: add a small deadline badge in the top-right of each carousel
card ("6d left" in red if urgent, or event type tag if not urgent). The
student should immediately understand which featured events need their
attention now.

---

## THE MISSING SCREEN — COMPOSE / PUBLISH

Pages 4 and 5 are duplicates. One of those slots should be the Compose
screen. Here is the complete spec for it.

WHAT IT IS:
The screen where a student publishes a Ledger post. This is the most
important flow in the app — it is the moment a student contributes to
their permanent academic record. The form is structured and requires
specific information. An AI classifier runs on the title and abstract
before publish and shows the student their detected domain. If the
classifier is not confident, the post is held for review — not rejected.

TOP BAR:
Left: "Cancel" in gray text (goes back without saving)
Center: "Publish to Ledger" in primary navy bold text, uppercase
Right: an info icon button that explains the publishing process in a
bottom sheet when tapped

STEP PROGRESS:
Three dots connected by a line. Filled dot = current step. Navy filled
with checkmark = completed. Gray outline = upcoming. Right-aligned below:
"Step 1 of 3 · Post details" in small surface-variant gray text.

STEP 1 — POST DETAILS (all fields visible, scrollable):

Field: Title
Label: "Title of your work" in semibold 14px.
Input: 52px height, rounded-xl, outline-variant border that turns primary
on focus. Placeholder: "What did you build, find, or prove?"
Character counter right-aligned below: "24 / 120" — turns error red
at 110 characters.
Helper text: "Be specific. 'LoRa mesh for rural health monitoring' is
better than 'My IoT project.'"

Field: Domain (dropdown)
Label: "Domain" in semibold 14px.
Select dropdown: 52px height, same border and radius as title input.
Once a domain is selected, the Node picker appears below it immediately.
The Node picker only appears after domain is selected — this staged
reveal keeps the form from looking overwhelming.

Field: Node (appears after domain selection)
Horizontal scroll of Node chips. The student's already-joined Nodes
appear first with a slightly darker background. Other Nodes in the
selected domain follow. Tap to select. Selected chip: primary navy
background, on-primary white text.

Field: Abstract
Label: "Abstract" in semibold 14px.
Multiline input: 120px height minimum, same border radius.
Placeholder: "Describe what you did, how you did it, and why it matters
— in 3 sentences."
Character counter below.

AI DOMAIN DETECTION STRIP (appears 1.5 seconds after the student stops
typing in the abstract):
A compact strip appears below the abstract input, slides up with a
200ms animation. Left: a sparkle icon (16px). Center: "Domain detected:
[domain name] — [subdomain]" in semibold 13px. Right: a thin confidence
fill bar, 60px wide, showing the classifier's confidence percentage.
If confidence is above 70%: the strip background is secondary-container
light green. The domain detected text is in on-secondary-container.
If confidence is 40–70%: the strip background is tertiary-fixed warm
amber. Text: "Uncertain classification — your post will be reviewed
before publishing." in on-tertiary-fixed-variant.
If confidence is below 40%: no strip. The submit button stays active
but a note appears: "Domain unclear — a reviewer will classify this."
This strip is one of the most important UX moments in the app. It
teaches students to write clearer abstracts over time. The classifier
is a teacher, not a gatekeeper.

Field: Body (rich text)
Label: "Full content" in semibold 14px.
Rich text editor with a formatting toolbar that appears above the
keyboard when the field is focused. Toolbar icons (36px tap targets each):
Bold / Italic / Code block / Numbered list / Bullet list / Math (LaTeX)
Minimum 200 characters. Character count shown.

Field: Attachment (optional)
Label: "Attachment (optional)" in semibold 14px.
Dashed border upload area: tap to browse or paste a URL.
Supports: PDF upload, GitHub repository URL, dataset URL.
After attaching: shows file icon + filename + size + a remove (×) link.
Only one attachment allowed per post.

Field: Open for Parallel? (toggle, off by default)
A labeled toggle switch. When on: a brief note appears below — "Students
from other institutions can request to contribute. Your post will show
↔ Parallel." When off: nothing extra.

BOTTOM CTA (fixed at bottom of screen, above keyboard when keyboard
is open):
"Publish to Ledger →" — full width, primary navy background, on-primary
white text, font-bold, 52px height, rounded-xl, 20px horizontal margin.
When tapped: the button text cycles through "Classifying domain..." then
"Publishing..." with a small loading spinner, then the screen transitions
to a success state.

SUCCESS STATE:
Full screen with primary-container navy background.
Center: an animated circle that draws itself (300ms), then a checkmark
inside it (200ms). Total animation 500ms.
Below: "Published to Ledger" in large on-primary white text.
Below: "Node / [Node name] · Domain verified [N]%" in smaller
on-primary-container muted text.
Two buttons stacked: "View my post" (white background, primary navy text)
and "Back to Ledger" (outline — white border, white text).

---

## THE MISSING SCREEN — NODES BROWSER

This screen is also absent from the 5 HTML pages but is referenced in
the bottom navigation on every page. Build it as the destination when
the "Nodes" nav item is tapped.

WHAT IT IS:
Where students discover and join discipline-based communities. Each Node
has a Charter (a founding scope document defining what belongs in it).
Students must join a Node before posting to it. Every Node is domain-
specific and moderated by its Charter — posts outside the Charter's
scope are held for review.

SCREEN STRUCTURE (top to bottom):

Search bar: full width, just below the top bar. Searches all Nodes by
name, domain, Charter keywords. Same style as Vault search.

My Nodes section: horizontal scroll of compact cards showing the student's
joined Nodes. Each card: Node name in bold + colored domain dot + small
"N new" badge if there are unread posts + a green dot in top-right corner
if a Guide is actively mentoring this Node.

Discover section: vertical list of Nodes the student has not joined.
Each Node card: a 48px square icon with domain color background on the
left. Right: Node name in font-bold + domain label in on-surface-variant
+ first sentence of Charter in small gray text (1-line clamp) + "N
members · N posts this month" in a row. Far right: "Join" button in
outline style (primary border, primary text). When joined, the button
changes to "Joined ✓" with green text, no border.

Node detail screen (tapping a card): full screen. Shows the complete
Charter at the top — expandable, collapses to 2 lines with "Read full
Charter" link by default. Below: that Node's Ledger feed filtered to
this Node only. Sealed posts appear first (pinned style, with the Seal
badge), then recent posts. A floating "Post to Node" button appears in
the bottom right.

---

## COMPLETE FEATURE LIST — FUNCTIONAL SPEC

---

### 1. LEDGER FEED
What it does: shows a curated stream of academic posts from the student's
Nodes, with Sealed posts elevated. Mixed with Convene event cards and
Vault file cards at intervals.

How it works:
— Posts are ranked by: Seals received first, then recency. No engagement
  metric (no likes, no shares) affects ranking.
— The "For You" tab shows the above mixed feed.
— Individual Node tabs filter to only that Node's posts.
— "Following" shows posts from Scholars the student follows.
— "Convenes" and "Vault" tabs filter to those content types only.
— Pulling down refreshes the feed (standard pull-to-refresh).
— Skeleton loading states appear while posts load — no spinners.

Every post card in the feed contains:
Node chip with colored dot (top left) + bookmark toggle (top right).
Seal badge if applicable: "✦ Sealed · [Guide name]"
Parallel badge if applicable: "↔ Parallel · N institutions"
Post title in bold (2-line max clamp).
Abstract (2-line clamp with ellipsis — enforces tight abstracts).
Attachment pill if file exists: icon + filename + size.
Peer review score pills: "Clarity [N]" and "Depth [N]" with total
  review count. Scores in on-secondary-container green.
Author row: 28px avatar + name with ✦ if verified + institution + year.
Action row: Review button (ghost style) + Parallel button (text link)
  + timestamp right-aligned.

No likes. No share counts. No follower counts. Ever.

---

### 2. FOLIO (Student Profile)
What it does: shows a student's complete academic output as a permanent,
public, shareable record.

How it works:
— Every Scholar has a public Folio URL at meridian.app/folio/[username]
— The URL is shareable outside the app — no account required to view.
— Four metrics at the top: Ledger posts / Seals received / Reviews written
  / Nodes active. These are the only numbers on the profile.
— The Seals section shows Guide endorsements on specific posts, not
  generic badges.
— Three tabs: Published (Ledger posts, oldest first) / Vault (files
  uploaded or forked) / Convenes (events participated in with outcomes).
— The student's own Folio has an "Edit" button on the bio section and
  "Share Folio" + "Copy link" buttons in the header.
— Viewing another Scholar's Folio: "Save contact" button (adds to
  directory) and "Share" button.
— No follow button. No connection request. No messaging from Folio.
  All Scholar-to-Scholar interaction happens through Parallel (on a post)
  or through the Ledger. Guide-to-Scholar interaction happens through
  the Inquiry system.

---

### 3. VAULT (Knowledge Library)
What it does: structured file sharing with version control, attribution,
and offline access.

How it works:
— Every file upload requires: title, subject (dropdown from ~500 academic
  subjects), institution (auto-filled), department, semester/year of
  the content (not the upload year — the year the content is relevant
  to), brief description (50–200 characters), and the file.
— After upload, the file gets a permanent Vault ID, appears on the
  contributor's Folio, and is indexed for search.
— Forking: any student can fork any file. Forking creates a copy
  attributed to the forking student, with the original contributor's
  attribution preserved. The fork chain is displayed on the file detail
  view — a visual lineage of who improved what.
— Search: searches title, subject, institution, contributor name,
  department, semester simultaneously. Results are instant (Typesense).
— Offline: students can download files. Downloaded files are accessible
  without internet. Storage limit: 500MB per student. A meter shows usage.
— Citations tab: shows all Ledger posts that linked to the student's
  Vault files — usage tracking, not citation in the academic-paper sense.

---

### 4. CONVENE (Events Browser)
What it does: shows academic events the student can participate in, with
instant verified registration.

How it works:
— Events are created by verified institutions (on the Institution tier)
  or by verified Guides.
— Every event has: title, domain, hosting institution, timeline
  (registration closes, submission deadline, results), team size range,
  eligibility filters, problem statement, judging criteria.
— Student registration: one tap. Identity already on Meridian, no form.
  The platform passes verified identity to the host. A confirmation
  shows in the student's Folio under Convenes and in their notifications.
— After registration: the event card shows "Registered ✓" and a "View
  team" link. The team formation board inside the event shows other
  solo registrants looking for teammates.
— After results: outcome labels (Winner / Finalist / Participant) are
  permanently applied to each participant's Folio Convenes tab. The
  host institution publishes results on the platform.

---

### 5. PEER REVIEW
What it does: structured quality assessment of Ledger posts by other
Scholars in the same Node.

How it works:
— Triggered by "Review" button on any Ledger post card.
— Opens as a bottom sheet sliding up from the bottom of the screen.
— Sheet shows: post title + Node + author at the top.
— Two rating inputs: "Clarity (1–5)" and "Technical depth (1–5)". Each
  is a 5-star tap selector. Stars fill in on-primary navy when selected.
  Stars animate on tap — scale 1.0 → 1.25 → 1.0 in 80ms.
— A written comment field: minimum 40 words. The submit button is grayed
  out until both ratings are set AND 40 words are written. The character
  counter shows "0 / 40 minimum" and turns on-secondary-container green
  when the threshold is reached.
— Below the comment field: "Your review will show your name, institution,
  and year. Reviews are not anonymous." in small gray text.
— After submitting: the sheet shows a success state with a checkmark and
  "Review published. [Author name] has been notified." then auto-closes.
— Reviews accumulate on the post. The Clarity and Depth scores on the
  post card are running averages of all submitted reviews.
— A Scholar cannot review their own post. Cannot review a post they are
  listed as Parallel co-author on. Can only review posts in Nodes they
  are a member of.

---

### 6. INQUIRY (Scholar-to-Guide messaging)
What it does: structured, rate-limited, context-required messaging from
a verified Scholar to a verified Guide.

How it works:
— Triggered by: "Inquire" button on a Guide's callout card in the Ledger
  feed, or "Inquire" button on a Guide's Folio, or "Inquire" button in
  the Guides tab of a Node.
— Opens as a bottom sheet.
— Top of sheet: Guide's avatar + name with ✦ + role + institution + how
  many Inquiries they've responded to this month (transparency signal).
— Quota display: a thin progress bar showing "Inquiry quota: N of 1 used
  this week." If quota is full, the sheet shows only the quota status and
  a "Reset in Xd Xh" countdown. No form is shown.
— Three required fields:
  Field 1: "What are you working on?" — multiline, 100 words max.
  Minimum 30 words before the submit button activates.
  Field 2: "What have you already tried?" — multiline, 100 words max.
  Minimum 30 words. This is the most important field — it signals effort.
  Field 3: "What specifically are you asking for?" — multiline, 50 words
  max. Minimum 15 words. One specific ask, not open-ended requests.
— Submit button: "Send Inquiry →" — disabled in gray until all three
  minimum thresholds are met. When they are met, transitions to primary
  navy with a smooth 200ms color animation — the button earning its active
  state teaches the student that the form is now complete.
— Rate limit: one Inquiry per Guide per week. Maximum 3 active Inquiries
  to different Guides simultaneously.
— Guide response: Guides see a dedicated Inquiry inbox. Each Inquiry shows
  all three fields. Options: Reply (free text) / Decline (with optional
  reason) / Archive (no notification to student).
— Auto-archive: if a Guide hasn't responded in 14 days, the Inquiry auto-
  archives and the student's quota is restored.

---

### 7. NOTIFICATIONS
What it does: alerts the student to actions that need their attention.

Notification types (only these — nothing else):
1. Guide replied to your Inquiry — links to the Inquiry thread.
2. Your Ledger post received a peer review — links to the post, shows
   the review scores as a preview in the notification itself.
3. A Guide issued a Seal on your post — shown with a gold ✦ left accent
   stripe on the notification card, links to the sealed post.
4. Your post was held for review — shows the reason and a link to edit
   the post if needed.
5. Convene you registered for: submission deadline approaching — shown
   with error-color left accent stripe when within 48 hours.
6. Convene results published — links to the results with the outcome label
   already shown (Winner / Finalist / Participant) in the notification.
7. Parallel request — someone wants to join your Parallel post, links to
   the request with a brief description of their proposed contribution.
8. Parallel accepted — your request to contribute was accepted, links to
   the shared post.
9. New Vault file in your Node — aggregated once daily: "4 new files in
   Node / Gradient." Single notification, not per-file.

No promotional notifications. No "you haven't posted in a while."
No algorithmic re-engagement. No "X people viewed your Folio."

Screen structure: a vertical list of notification items. Each item: 72px
height. Left: small avatar (32px) for person-related notifications, or
a domain icon for system notifications. Right of avatar: primary text
in font-semibold 14px (1-line clamp) + secondary text in on-surface-
variant 13px (1-line clamp) + timestamp far right in small gray text.
Unread items: light primary-fixed/20 background tint + a 6px primary
dot on the far left edge. Read items: plain surface background.
Seal notifications: gold/amber left border stripe (3px) to make them
visually prominent — these are the most important notifications on the
platform.
Deadline notifications: error-color left border stripe (3px).

---

## COLOR USAGE RULES — ENFORCED ACROSS ALL SCREENS

PRIMARY NAVY (#002444 / #1A3A5C):
Used on: nav text, card titles, primary CTA buttons, active nav items,
the wordmark "MERIDIAN", post titles, Folio name. This is the dominant
color of the platform — it sets the tone as serious and trustworthy.

SECONDARY-CONTAINER GREEN (#d0e9d4 / on: #546a59):
Used ONLY on: Seal badges, "Registered ✓" confirmed states, "Reviewed ✓"
completed states, score pills showing quality. Green = confirmed, done,
endorsed. Never used for decoration.

TERTIARY-CONTAINER AMBER/RUST (#692003 / on: #ef8661):
Used ONLY on: urgent warnings, "almost full" registration states, posts
with uncertain AI classification. Never used as a general accent.

ERROR (#ba1a1a):
Used ONLY on: hard deadlines (less than 3 days), quota-full states,
validation errors in forms. Hard rule: error color on fewer than 3
elements visible at any time.

GOLD/AMBER ACCENT (custom, not in current token set — add it):
Hex: #C9922A — used ONLY on the ✦ Meridian verification mark. This
appears on: Guide names, Scholar names (after verification), Seal badges,
the gold ring on verified avatars. The ✦ mark should always be in this
specific amber-gold color. It is the scarcest color on the platform —
seeing it means something was verified by a person, not an algorithm.

SURFACE (#f8f9fa): screen backgrounds only. Never on interactive elements.
WHITE (#ffffff): card surfaces only. The separation between white cards
and the slightly off-white screen background creates depth without shadows.

---

## INTERACTION RULES — APPLIED TO EVERY INTERACTIVE ELEMENT

Card press: scale down to 0.97, 120ms ease. Returns to 1.0 on release,
180ms. This is the Zomato-school physical card feel. All cards do this.

Button press: scale to 0.96, background darkens slightly, 100ms.
All buttons do this. The active:scale-95 class already in the HTML is
correct — keep it consistently.

Tab switch: the active pill background animates to the new position with
a 200ms ease transition. Not a hard jump.

Star ratings (in peer review): each star scales 1.0 → 1.25 → 1.0 on
tap, 80ms total. Stars to the left of the tapped star fill simultaneously.

Bottom sheet entry: slides up from the bottom in 300ms with a
cubic-bezier(0.32, 0.72, 0, 1) easing — the same easing used by iOS
native sheets. The backdrop dims to rgba(0,0,0,0.4).

Bottom sheet dismiss: drag down (any downward velocity), or tap the
dimmed backdrop. No close button needed.

Success animations: circle draws in 300ms, checkmark draws in 200ms.
Only used after: publishing a post, sending an Inquiry, submitting a
review, registering for a Convene.

Skeleton loading: all card content is replaced by gray shimmer rectangles
in the exact shape of the content (title-sized rectangle, abstract-sized
rectangle, author row rectangles). No spinners on main content. Spinners
only on button loading states.

---

## WHAT THIS APP NEVER DOES
(Violations of these rules mean a feature was built wrong)

Never shows a like count anywhere on any screen.
Never shows a follower count or following count.
Never shows a share count on a post.
Never sends a re-engagement notification.
Never uses an engagement metric to rank content in any feed.
Never shows an advertisement.
Never uses the error color for anything except deadlines and form errors.
Never uses the gold ✦ color for decoration — only for verified marks.
Never allows a Guide to pay for visibility or placement.
Never creates a modal overlay for navigation (use bottom sheets instead).
Never auto-plays video or audio.
Never uses pure white (#ffffff) as a screen background — always surface
(#f8f9fa) for screen backgrounds, white only for card surfaces.

---

## THE NORTH STAR — ONE QUESTION FOR EVERY DECISION

"If a second-year engineering student in Tirūrangādi, Kerala with a 4G
connection opened this screen for the first time, would they understand
what to do, feel their academic work belongs here, and come back
tomorrow?"

If no to any part: simplify, clarify, or remove.
If yes: ship it.

The HTML files are the front end that I had done and its not complete and not even close to what I thought I need you to help me out with what you sutdy from the readme, nd then make the thml pages functional with all the features, and add more in if you feel and make correction to ones if you feel