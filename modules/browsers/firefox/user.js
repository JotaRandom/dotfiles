// user.js - Firefox optimizado para ThinkPad L420 (1366x768, RAM limitada)
// Ruta: ~/.mozilla/firefox/PROFILE_ID/user.js
// IMPORTANTE: Reiniciar Firefox después de modificar

// ============================================================
// UI COMPACTA - Estilo Firefox 4.0
// ============================================================

// Habilitar userChrome.css (CRÍTICO para estilo Firefox 4.0)
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Modo compacto (UI más pequeña para 1366x768)
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);  // 0=normal, 1=compact, 2=touch

// Tabs en titlebar OFF (estilo Firefox 4.0)
user_pref("browser.tabs.drawInTitlebar", false);

// Proton UI OFF (más compacto)
user_pref("browser.proton.enabled", false);

// ============================================================
// PERFORMANCE & RAM (ThinkPad L420)
// ============================================================

// Procesos reducidos para RAM limitada
user_pref("dom.ipc.processCount", 2);  // Default: 8
user_pref("dom.ipc.processCount.webIsolated", 1);

// Content process limit
user_pref("dom.ipc.processPrelaunch.enabled", false);

// Cache en disco reducido
user_pref("browser.cache.disk.enable", true);
user_pref("browser.cache.disk.capacity", 51200);  // 50MB vs 250MB default

// Memory cache
user_pref("browser.cache.memory.enable", true);
user_pref("browser.cache.memory.capacity", 32768);  // 32MB

// Session restore menos agresivo
user_pref("browser.sessionstore.interval", 30000);  // 30s vs 15s

// ============================================================
// GPU & RENDERING (Intel HD Graphics)
// ============================================================

// Hardware acceleration
user_pref("gfx.webrender.all", true);
user_pref("layers.acceleration.force-enabled", true);

// WebGL enabled
user_pref("webgl.disabled", false);

// Smooth scrolling OFF (performance)
user_pref("general.smoothScroll", false);

// ============================================================
// PRIVACY & TELEMETRY OFF
// ============================================================

// Telemetry deshabilitada
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// Pocket OFF
user_pref("extensions.pocket.enabled", false);

// Tracking protection
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

// Activity Stream (new tab) reducido
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// ============================================================
// UI OPTIMIZATIONS
// ============================================================

// Autoplay OFF (performance)
user_pref("media.autoplay.default", 5);  // Block audio and video

// Reader mode
user_pref("reader.parse-on-load.enabled", true);

// Picture-in-Picture
user_pref("media.videocontrols.picture-in-picture.enabled", true);

// Font rendering
user_pref("gfx.font_rendering.cleartype_params.rendering_mode", 5);

// ============================================================
// FIREFOX 4.0 STYLE PREP
// ============================================================

// Menubar visible (Firefox 4.0 style)
user_pref("browser.tabs.inTitlebar", 0);

// Status bar (via extensions)
user_pref("browser.display.show_image_placeholders", false);

// Bookmarks toolbar solo icons
user_pref("browser.toolbars.bookmarks.visibility", "newtab");

// ============================================================
// NOTAS
// ============================================================
// userChrome.css aplicará el estilo visual Firefox 4.0 completo
// (tabs cuadrados, botón Firefox naranja, UI compacta)
