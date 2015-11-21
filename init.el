
;; Do an Emacs version check
(when (or (< emacs-major-version 24)
          (and (= emacs-major-version 24) (< emacs-minor-version 4)))
  (x-popup-dialog
   t `(,(format "Sorry, you need GNU Emacs version 24.4 or higher
to run X Emacs.
Your installed Emacs reports:
%s" (emacs-version))
       ("OK :(" . t)))
  (save-buffers-kill-emacs t))


;; Initialise the package system first of all.
(package-initialize)

;; Skip the default splash screen.
(setq inhibit-startup-message t)

;; Figure out the current hostname.
(setq hostname (replace-regexp-in-string "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" (with-output-to-string (call-process "hostname" nil standard-output))))

;; Add is mac const.
(defconst *is-a-mac* (eq system-type 'darwin))

;; Figure out the path to our .emacs.d by getting the path part of the
;; current file (`init.el`).
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) (file-chase-links load-file-name))))

;; We need to tell Emacs where to find X Emacs's library packages.
(add-to-list 'load-path (concat dotfiles-dir "x"))

;; We'll keep the various parts of our configuration in the `modules` subfolder
;; of our .emacs.d. We'll need to add that to the system load path so Emacs can
;; find our modules when we ask for them.
(add-to-list 'load-path (concat dotfiles-dir "modules"))

;; Define where we want to keep `loaddefs.el` (our autoload declarations) and
;; `custom.el` (our user settings file).
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; Load the user settings from `custom.el`.
(load custom-file 'noerror)

;; Load the X Emacs fundamentals.
(require 'x-lib)
(require 'x-package)
(require 'x-module-index)
(require 'x-module-selector)
(require 'x-update)
(require 'x-personal-taste)
(require 'x-startup-wizard)


;; Load the enabled modules.
(when (not (boundp 'x/wizard-did-run)) (x/load-modules))

;; Load the user's config, if it exists.
(load (concat dotfiles-dir "user.el") 'noerror)
