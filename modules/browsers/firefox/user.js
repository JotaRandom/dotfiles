// user.js – Preferencias de Firefox con apariencia retro
// Ruta: ~/.mozilla/firefox/PROFILE_ID/user.js
// Nota: fusionar con existing user.js si ya existe

// ============================================================
// UI / Interfaz - Apariencia Retro
// ============================================================

// Habilitar userChrome.css personalizado (REQUERIDO para que funcione userChrome.css)
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Densidad de UI - Compact o Normal (no "Touch" que es muy grande)
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);  // 0=normal, 1=compact, 2=touch

// Tema por defecto (si no usas CSS personalizado)
// user_pref("extensions.activeTheme", "firefox-compact-dark@mozilla.org");

// ============================================================
// Seguridad - Privacidad
// ============================================================

// Desactivar telemetría y reporte de errores
user_pref("datareporting.policy.dataSubmissionPolicyAcceptedVersion", 2);
user_pref("datareporting.policy.dataSubmissionPolicyNotifiedTime", "1");
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.archive.enabled", false);

// Privacidad: modo de rastreo mejorado
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

// Deshabilitar publicidad de Firefox (sugerencias de la página de inicio)
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// Privacidad: no enviar referrer a sitios externos
user_pref("network.http.referer.XOriginPolicy", 2);

// ============================================================
// Rendimiento
// ============================================================

// Número de procesos (multi-process) - 0 = automático
user_pref("dom.ipc.processCount", 0);

// Habilitar WebGL para mejor rendimiento gráfico
user_pref("webgl.disabled", false);

// ============================================================
// Apariencia - Configuraciones retro adicionales
// ============================================================

// Mostrar siempre la barra de dirección (sin contraerse)
user_pref("browser.urlbar.update1", true);

// Tamaño de fuente por defecto (un poco más pequeño para apariencia retro)
user_pref("font.size.variable.x-western", 12);
user_pref("font.size.monospace.x-western", 12);

// Deshabilitar animaciones suaves (más retro, más rápido)
user_pref("general.smoothScroll", false);

// Estilo de barra de herramientas
user_pref("browser.tabs.drawInTitlebar", false);

// ============================================================
// Notas finales
// ============================================================

// Más configuraciones disponibles en about:config
// Las preferencias aquí son básicas; ajusta según tu preferencia personal
// userChrome.css proporciona la mayoría de la personalización visual retro

