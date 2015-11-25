(require 'x-package)

;; which-key prompts you with available options when you type a partial
;; command sequence. Try it out: hit C-x and just wait for two seconds.
(package-require 'which-key)
(which-key-mode)

;; Hit C-h C-k to have which-key show you all top level key bindings.
(global-set-key (kbd "C-h C-k") 'which-key-show-top-level)

;; Set the delay before which-key appears.
(setq-default which-key-idle-delay 2.0)

;; which-key will truncate special keys by default, eg. SPC turns into
;; an orange D. Turn this off to avoid confusion.
(setq-default which-key-special-keys nil)

;; Display help infomation in the minibuffer
(which-key-setup-minibuffer)


;; Get an instant cheat sheet for your current major mode
;; with C-h C-m.
(package-require 'discover-my-major)
(global-set-key (kbd "C-h C-m") 'discover-my-major)



(provide 'x-help)
