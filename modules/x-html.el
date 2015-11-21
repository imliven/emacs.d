(require 'x-package)
(require 'x-editing)

;; web-mode is a special mode for HTML which copes with embedded JS/CSS,
;; JSX, various templating systems, etc.
;; Learn about web-mode: http://web-mode.org/
(package-require 'web-mode)

;; We'd like to use web-mode for HTML, instead of the default html-mode.
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Let's add some extensions from the web-mode docs too.
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; css
(add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))


;; Highlight the element under the cursor.
(setq-default web-mode-enable-current-element-highlight t)

;; Key for renaming tags
(with-eval-after-load "web-mode"
  (define-key web-mode-map (kbd "C-c C-r") 'mc/mark-sgml-tag-pair))

;; Colourise colour names in certain modes.
(package-require 'rainbow-mode)
(dolist (mode '(css-mode less-css-mode html-mode web-mode))
  (add-hook (intern (concat (symbol-name mode) "-hook"))
            (lambda () (rainbow-mode))))



(provide 'x-html)
