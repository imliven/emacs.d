(require 'x-package)

;; Install Markdown support.
(package-require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))



(provide 'x-markdown)
