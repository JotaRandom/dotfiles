(setq user-full-name "Pablo Lezaeta")
(setq user-mail-address "prflr88@gmail.com")

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(set-language-environment "UTF-8")

(provide 'init)
