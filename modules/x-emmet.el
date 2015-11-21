(require 'x-package)

(package-require 'emmet-mode)

(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.


(provide 'x-emmet)
