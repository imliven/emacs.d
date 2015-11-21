(require 'x-package)
(require 'x-lib)
(require 'x-json)

;; If npm is installed, add its local prefix to the executable
;; search path, which helps Emacs find linters etc.
;; This isn't Windows compatible, but then neither is npm, really.
(-when-let (npm-prefix (x/exec-if-exec "npm" "config get prefix"))
  (setenv "PATH" (concat npm-prefix "/bin:" (getenv "PATH"))))

;; Use web-mode for all JS files.
(package-require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))

(setq web-mode-content-types-alist
      '(("jsx" . "\\.jsx$")))

;; Stop web-mode from using block comments in comment-dwim.
(setq web-mode-comment-formats
      (-map-when (lambda (i) (equal (car i) "javascript"))
                 (lambda (i) '("javascript" . "//"))
                 web-mode-comment-formats))

;; Use Tern for smarter JS.
(package-require 'tern)
(add-hook 'web-mode-hook (lambda () (tern-mode t)))

;; Locate the Tern binary by querying the system search path, which
;; should now include the local npm prefix.
(setq tern-command (list (or (x/resolve-exec "tern") "tern")))

;; Setup Tern as an autocomplete source.
(with-eval-after-load "company"
  (package-require 'company-tern)
  (require 'company-tern)
  (add-to-list 'company-backends 'company-tern))

;; Let Flycheck know that we're using web-mode for JS.
(with-eval-after-load "flycheck"
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (setq flycheck-javascript-eslint-executable (or (x/resolve-exec "eslint") "eslint")))



(provide 'x-js-web-mode)
