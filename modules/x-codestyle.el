(require 'x-package)

;; Tab indentation is a disease; a cancer of this planet.
;; Turn it off and let's never talk about this default again.
(set-default 'indent-tabs-mode nil)

;; The fact that we have to do this is also quite embarrassing.
(setq sentence-end-double-space nil)

;; Always indent after a newline.
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Strict whitespace with ethan-wspace: highlight bad habits,
;; and automatically clean up your code when saving.
;; Use C-c c to instantly clean up your file.
;; Read more about ethan-wspace: https://github.com/glasserc/ethan-wspace
(package-require 'ethan-wspace)
(setq mode-require-final-newline nil)
(setq require-final-newline nil)
(global-ethan-wspace-mode 1)
(global-set-key (kbd "C-c c") 'ethan-wspace-clean-all)

;; Set default indentation for various languages (add your own!)
(setq-default tab-width 4)
;; Javascript
(setq-default js2-basic-offset 2)
;; JSON
(setq-default js-indent-level 2)
;; Coffeescript
(setq coffee-tab-width 2)
;; Typescript
(setq typescript-indent-level 2
      typescript-expr-indent-offset 2)
;; Python
(setq-default py-indent-offset 2)
;; XML
(setq-default nxml-child-indent 2)
;; C
(setq-default c-basic-offset 2)
;; CSS
(setq css-indent-offset 2)
;; HTML etc with web-mode
(setq-default web-mode-markup-indent-offset 2
              web-mode-css-indent-offset 2
              web-mode-code-indent-offset 2
              web-mode-style-padding 2
              web-mode-script-padding 2)

;; Set the default formatting styles for various C based modes.
;; Particularly, change the default style from GNU to Java.
;; rms, I love you, but your formatting style makes my eyes bleed.
(setq c-default-style
      '((awk-mode . "awk")
        (other . "java")))



(provide 'x-codestyle)
