(require 'x-package)

;; The s.el package contains a lot of functions useful in snippets.
(package-require 's)
(require 's)

;; Install yasnippet and make it available globally.
;; Read about it here: http://capitaomorte.github.io/yasnippet/
(package-require 'yasnippet)
(require 'yasnippet)
(yas-global-mode 1)

(provide 'x-snippets)
