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

;; ===== KEYBINDINGS =====
;; Más como editores modernos
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-z") 'undo)

;; ===== MODELINE COMPACTO =====
(setq-default mode-line-format
  '("%e" mode-line-front-space
    mode-line-buffer-identification " "
    mode-line-position
    (vc-mode vc-mode)
    " " mode-line-modes mode-line-end-spaces))

;; ===== FINAL =====
(message "Emacs optimizado para ThinkPad L420 (1366x768) cargado")
