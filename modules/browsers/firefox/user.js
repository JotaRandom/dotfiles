// user.js – Preferencias de Firefox para seguridad y rendimiento
// Ruta: ~/.mozilla/firefox/PROFILE_ID/user.js
// Nota: fusionar con existing user.js si ya existe

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

// Deshabilitar publicidad de Firefox
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// ============================================================
// Rendimiento
// ============================================================

// Número de procesos (multi-process) - 0 = automático
user_pref("dom.ipc.processCount", 0);

// Habilitar WebGL para mejor rendimiento gráfico
user_pref("webgl.disabled", false);

// ============================================================
// UI / Interfaz
// ============================================================

// Ejemplo: mostrar barra de direcciones siempre
user_pref("browser.urlbar.update1", true);

// Más configs disponibles en about:config
