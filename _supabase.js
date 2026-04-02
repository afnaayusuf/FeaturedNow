// Rainfont — shared Supabase client
// Import this in every page via: <script type="module" src="_supabase.js"></script>
// Or include inline via the CDN pattern below

const SUPABASE_URL = 'https://fialnacztirjsnbxwbmk.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_HaboOwr9ZOFGcKpHK5cCjQ_By0uh4rF';

// When using via CDN (no bundler), access as window._sb
// Each page imports Supabase from CDN and calls createClient with these values.
window.SUPA_URL = SUPABASE_URL;
window.SUPA_KEY = SUPABASE_ANON_KEY;
