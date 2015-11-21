(require 'x-package)
(require 'x-lib)
(require 'x-json)

;; If npm is installed, add its local prefix to the executable
;; search path, which helps Emacs find linters etc.
;; This isn't Windows compatible, but then neither is npm, really.
(-when-let (npm-prefix (x/exec-if-exec "npm" "config get prefix"))
  (setenv "PATH" (concat npm-prefix "/bin:" (getenv "PATH"))))

;; Install js2-mode, which improves on Emacs's default JS mode
;; tremendously.
(package-require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . js2-mode))

;; Configure js2-mode good.
(setq-default
 js2-mode-indent-ignore-first-tab t
 js2-strict-inconsistent-return-warning nil
 js2-global-externs
 '("module" "require" "__dirname" "process" "console" "JSON" "$" "_"))
 ;; js2-show-parse-errors nil
 ;; js2-strict-var-hides-function-arg-warning nil
 ;; js2-strict-missing-semi-warning nil
 ;; js2-strict-trailing-comma-warning nil
 ;; js2-strict-cond-assign-warning nil
 ;; js2-strict-var-redeclaration-warning nil

;; Use Tern for smarter JS.
(package-require 'tern)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

;; Locate the Tern binary by querying the system search path, which
;; should now include the local npm prefix.
(setq tern-command (list (or (x/resolve-exec "tern") "tern")))

;; Setup Tern as an autocomplete source.
(with-eval-after-load "company"
  (package-require 'company-tern)
  (require 'company-tern)
  (add-to-list 'company-backends 'company-tern))

;; Leverage js2-mode to get some refactoring support through js2-refactor.
(package-require 'js2-refactor)
(add-hook 'js2-mode-hook
          (lambda ()
            (js2r-add-keybindings-with-prefix "C-c C-m")))



(provide 'x-javascript)
