(package-require 'helm)
(require 'helm-config)
(require 'helm)

;; Activate Helm.
(helm-mode 1)

;; Replace common selectors with Helm versions.
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-g") 'helm-do-grep)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x c g") 'helm-google-suggest)

;; A binding for using Helm to pick files using Projectile,
;; and override the normal grep with a Projectile based grep.
(with-eval-after-load "x-project"
  (package-require 'helm-projectile)
  (global-set-key (kbd "C-c C-f") 'helm-projectile-find-file-dwim)
  (global-set-key (kbd "C-x C-g") 'helm-projectile-grep))

;; Enrich isearch with Helm using the `C-S-s' binding.
;; swiper-helm behaves subtly different from isearch, so let's not
;; override the default binding.
(package-require 'swiper-helm)
(global-set-key (kbd "C-S-s") 'swiper-helm)

;; Tell Helm to resize the selector as needed.
(helm-autoresize-mode 1)

;; Make Helm look nice.
(setq-default helm-display-header-line nil
              helm-autoresize-min-height 10
              helm-autoresize-max-height 35
              helm-split-window-in-side-p t

              helm-M-x-fuzzy-match t
              helm-buffers-fuzzy-matching t
              helm-recentf-fuzzy-match t
              helm-apropos-fuzzy-match t)

(set-face-attribute 'helm-source-header nil :height 0.75)

(provide 'x-helm)
