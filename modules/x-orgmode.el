(require 'x-package)

;; Stop org-mode from highjacking shift-cursor keys.
(setq org-replace-disputed-keys t)

;; Always use visual-line-mode in org-mode, and wrap it at column 80.
(add-hook
 'org-mode-hook
 (lambda ()
   (visual-line-mode 1)
   (set-visual-wrap-column 80)))

;; Fancy bullet rendering.
(package-require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Insert links from clipboard.
(package-require 'org-cliplink)
(with-eval-after-load "org"
  (define-key org-mode-map (kbd "C-c M-l") 'org-cliplink))



(provide 'x-orgmode)
