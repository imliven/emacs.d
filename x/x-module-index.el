
(setq
 x/available-modules
 '((x-appearance "how Emacs looks" :recommended)
   (x-fonts "adjust font size on the fly" :recommended)
   (x-general "basic editor settings" :recommended)
   (x-osx "osx key binding" :recommended)
   (x-splash "enhance your scratch buffer" :recommended)
   (x-ido "improved file selector etc" :recommended)
   (x-navigation "moving around better" :recommended)
   (x-editing "editing improvements (multiple cursors etc)" :recommended)
   (x-complete "auto completion" :recommended)
   (x-snippets "snippet management" :recommended)
   (x-codestyle "code formatting, whitespace management" :recommended)
   (x-dired "enhanced file manager" :recommended)
   (x-project "manage projects with Projectile" :recommended)
   (x-flycheck "run linters automatically with Flycheck" :recommended)
   (x-git "Git tools" :recommended)
   (x-orgmode "your personal everything manager" :recommended)
   (x-help "ways to get more help" :recommended)
;; (x-elisp "Emacs Lisp" :recommended)
   (x-helm "advanced selection and narrowing" :optional)
   (x-eshell "the native Emacs shell" :optional)
;; (x-unicode "enhanced Unicode support (warning: slows startup)" :optional)
;; (x-refactor "easy access to refactoring tools" :optional)
   (x-html "HTML, CSS and friends" :optional)
   (x-markdown "Markdown support" :optional)
   (x-javascript "JavaScript language support" :optional)
   (x-js-web-mode "alternative JS support using web-mode" :optional)
   (x-coffeescript "CoffeeScript language support" :optional)
   (x-emmet "Zencoding support" :optional)
;; (x-purescript "PureScript language support" :optional)
;; (x-clojure "Clojure language support" :optional)
;; (x-erlang "Erlang language support" :optional)
;; (x-elixir "Elixir language support" :optional)
;; (x-haskell "Haskell language support" :optional)
;; (x-flow "the Flow type checker for JS" :optional)
;; (x-youdao "Youdao dictionary" :optional)
   ))

(require 'cl)
(defcustom x/modules (mapcar #'car
                                (remove-if-not
                                 (lambda (i) (equal :recommended (caddr i)))
                                 x/available-modules))
  "Your choice of X Emacs modules.")

(defun x/load-modules ()
  (interactive)
  (dolist (module x/modules) (require module nil t))
  (run-hooks 'x/modules-loaded-hook))

(provide 'x-module-index)
