// Rainfont — auth guard + session utilities
// Add to every app page:
//   <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
//   <script src="_auth.js"></script>
//
// Then call: initAuth(onReady) where onReady(session, profile) is your page callback.

(function () {
  const SUPA_URL = 'https://fialnacztirjsnbxwbmk.supabase.co';
  const SUPA_KEY = 'sb_publishable_HaboOwr9ZOFGcKpHK5cCjQ_By0uh4rF';

  window._sb = supabase.createClient(SUPA_URL, SUPA_KEY);

  // ── Guard: redirect to login if not authenticated ──
  window.initAuth = async function (onReady) {
    const { data: { session } } = await window._sb.auth.getSession();

    if (!session) {
      window.location.href = 'login.html';
      return;
    }

    // Fetch full profile (gracefully handles missing table or row)
    let profile = null;
    try {
      const { data } = await window._sb.from('profiles')
        .select('*')
        .eq('id', session.user.id)
        .single();
      profile = data;
    } catch (_) {}

    // Inject name + institution into standard UI slots
    _fillUserUI(session, profile);

    if (typeof onReady === 'function') onReady(session, profile || {});
  };

  // ── Sign out ──
  window.signOut = async function () {
    await window._sb.auth.signOut();
    window.location.href = 'login.html';
  };

  // ── Fill standard UI elements ──
  function _fillUserUI(session, profile) {
    // Fall back to auth metadata if profile row is missing
    const meta = session.user.user_metadata || {};
    const name = (profile && profile.full_name) || meta.full_name || session.user.email || '';
    const inst = (profile && profile.institution) || meta.institution || '';
    const year = (profile && profile.year) || meta.year || '';

    const initials = _initials(name);

    // Avatar initials — any element with data-user-initials
    document.querySelectorAll('[data-user-initials]').forEach(el => el.textContent = initials);

    // Full name — data-user-name
    document.querySelectorAll('[data-user-name]').forEach(el => el.textContent = name);

    // Institution + year — data-user-meta
    document.querySelectorAll('[data-user-meta]').forEach(el => {
      el.textContent = [inst, year].filter(Boolean).join(' · ');
    });

    // Guide badge — show/hide data-guide-only elements
    if (!profile.is_guide) {
      document.querySelectorAll('[data-guide-only]').forEach(el => el.style.display = 'none');
    }

    // Inquiry quota
    const quotaEl = document.getElementById('inquiry-quota-display');
    if (quotaEl) {
      const used = profile.inquiry_quota_used || 0;
      quotaEl.textContent = `${used} / 1 used`;
    }
  }

  function _initials(name) {
    if (!name) return '?';
    const parts = name.trim().split(/\s+/);
    if (parts.length === 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  // ── Utility: get current user profile (cached in session) ──
  window.getCurrentProfile = async function () {
    const { data: { session } } = await window._sb.auth.getSession();
    if (!session) return null;
    const { data } = await window._sb.from('profiles').select('*').eq('id', session.user.id).single();
    return data;
  };

})();
