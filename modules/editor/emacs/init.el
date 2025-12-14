;; init.el - Emacs optimizado para ThinkPad L420 (1366x768)

;; ===== PERFORMANCE =====
;; Aumentar garbage collection threshold
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; ===== UI OPTIMIZADA PARA 1366x768 =====
;; Deshabilitar elementos UI innecesarios (ganar espacio)
(menu-bar-mode -1)        ; Sin menu bar
(tool-bar-mode -1)        ; Sin toolbar (~40px ganados)
(scroll-bar-mode -1)      ; Sin scrollbar (~15px ganados)

;; Fuente pequeña para pantalla pequeña
(set-face-attribute 'default nil :height 90)  ; 9pt

;; Números de línea compactos
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; ===== PERFORMANCE GPU LIMITADA =====
;; Sin animaciones/smooth scrolling
(setq scroll-conservatively 1)
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

;; ===== CONFIGURACIÓN BÁSICA =====
;; No crear archivos backup (~)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; UTF-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Resaltar paréntesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Auto-revert buffers
(global-auto-revert-mode 1)

;; Indentación
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; ===== TEMA =====
(load-theme 'wombat t)  ; Tema oscuro built-in

;; ===== SPLITS OPTIMIZADOS =====
;; Splits horizontales abajo, verticales a la derecha
(setq split-height-threshold nil)
(setq split-width-threshold 160)

;; ===== KEYBINDINGS ESTILO NANO =====
;; Ctrl+O = Guardar (WriteOut como nano)
(global-set-key (kbd "C-o") 'save-buffer)

;; Ctrl+X ya está usado en emacs, usar Ctrl+Q para salir
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal)

;; Ctrl+K = Cortar línea (Kut - ya es default en emacs)
;; (kill-line es el default de Ctrl+K en emacs)

;; Ctrl+U = Deshacer en nano, pero en emacs es universal-argument
;; Usar Ctrl+Y para pegar (yank - default emacs)
(global-set-key (kbd "C-y") 'yank)

;; Ctrl+W = Buscar (Where is como nano)
(global-set-key (kbd "C-w") 'isearch-forward)

;; Ctrl+\ = Buscar y reemplazar
(global-set-key (kbd "C-\\") 'query-replace)

;; Ctrl+G = Ayuda (Get help)
(global-set-key (kbd "C-g") 'help-command)

;; Ctrl+Z = Deshacer (más común que Ctrl+U)
(global-set-key (kbd "C-z") 'undo)

;; Ctrl+S = Guardar (adicional, más común)
(global-set-key (kbd "C-s") 'save-buffer)

;; ===== MODELINE COMPACTO =====
(setq-default mode-line-format
  '("%e" mode-line-front-space
    mode-line-buffer-identification " "
    mode-line-position
    (vc-mode vc-mode)
    " " mode-line-modes mode-line-end-spaces))

;; ===== FINAL =====
(message "Emacs optimizado para ThinkPad L420 (1366x768) cargado")
