(require 'x-package)
(require 'x-personal-taste)

(require 'term)

;; Get rid of the training wheels, if you're ready for it.
(when (not x-personal-taste/training-wheels)
  (dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
    (when (fboundp mode) (funcall mode -1))))

;; Configure the light colour scheme.
(defun x-appearance/light ()
  (interactive)
  (load-theme 'leuven)

  (set-face-attribute 'mode-line nil
                      :foreground "#cccccc"
                      :background "#000000"
                      :box nil
                      :weight 'bold)
  (set-face-attribute 'mode-line-buffer-id nil
                      :foreground "white"
                      :weight 'bold)
  (set-face-foreground 'which-func "#3cb64a")
  (set-face-attribute 'linum nil :height 0.7)
  (set-face-attribute 'linum-highlight-face nil :foreground nil :background "#ddd" :height 0.7)

  (set-face-foreground 'term-color-black "#ffffff")
  (set-face-foreground 'term-color-red "#f5666d")
  (set-face-foreground 'term-color-green "#3cb64a")
  (set-face-foreground 'term-color-yellow "#ce5c00")
  (set-face-foreground 'term-color-blue "#00578e")
  (set-face-foreground 'term-color-magenta "#d020f0")
  (set-face-foreground 'term-color-cyan "#6799cc")
  (set-face-foreground 'term-color-white "#000000")

  (run-hooks 'x-appearance/hook)
  (run-hooks 'x-appearance/light-hook))

;; Configure the dark colour scheme.
(defun x-appearance/dark ()
  (interactive)
  (package-require 'material-theme)
  (load-theme 'material)

;  (set-face-background 'default "#000")

;  (set-face-background 'region "#223355")
;  (set-face-background 'fringe "#000")
;  (set-face-attribute
;   'linum nil
;   :foreground "#678" :background "#000" :height 0.9)
;  (set-face-attribute
;   'linum-highlight-face nil
;   :foreground "#96989c" :background "#263238" :height 0.9)
;  (set-face-foreground 'which-func "#7f9f7f")

  (set-face-foreground 'term-color-black "#3f3f3f")
  (set-face-foreground 'term-color-red "#cc9393")
  (set-face-foreground 'term-color-green "#7f9f7f")
  (set-face-foreground 'term-color-yellow "#f0dfaf")
  (set-face-foreground 'term-color-blue "#8cd0d3")
  (set-face-foreground 'term-color-magenta "#dc8cc3")
  (set-face-foreground 'term-color-cyan "#93e0e3")
  (set-face-foreground 'term-color-white "#dcdccc")

  (run-hooks 'x-appearance/hook)
  (run-hooks 'x-appearance/dark-hook))

;; Setup hooks to re-run after all modules have loaded, allowing
;; other modules to tweak the theme without having to wait
;; until they're loaded to switch to it.
(add-hook
 'x/modules-loaded-hook
 (lambda ()
   (run-hooks 'x-appearance/hook)
   (cond
    ((equal x-personal-taste/style 'dark)
     (run-hooks 'x-appearance/dark-hook))
    ((equal x-personal-taste/style 'light)
     (run-hooks 'x-appearance/light-hook)))))

;; Maximise the Emacs frame if that's how you like it.
(if (equal x-personal-taste/window-state 'maximised)
    (set-frame-parameter nil 'fullscreen 'maximized))

;; Don't defer screen updates when performing operations.
(setq redisplay-dont-pause t)

;; When not in a terminal, configure a few window system specific things.
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

;; Show line numbers in buffers.
(global-linum-mode t)
(setq linum-format (if (not window-system) "%4d " "%4d"))

;; Highlight the line number of the current line.
(package-require 'hlinum)
(hlinum-activate)

;; Show column numbers in modeline.
(setq column-number-mode t)

;; Show current function in modeline.
(which-function-mode)

;; Ensure linum-mode is disabled in certain major modes.
(setq linum-disabled-modes
      '(term-mode slime-repl-mode magit-status-mode help-mode nrepl-mode
        mu4e-main-mode mu4e-headers-mode mu4e-view-mode
        mu4e-compose-mode))
(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes))
    (linum-mode 1)))

;; Highlight matching braces.
(show-paren-mode 1)

;; Engage Nyan Cat!
;;(package-require 'nyan-mode)
;;(nyan-mode 1)
;;(setq nyan-bar-length 16
;;      nyan-wavy-trail t)

;; Unclutter the modeline
(package-require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "ethan-wspace" '(diminish 'ethan-wspace-mode))
(eval-after-load "eldoc" '(diminish 'eldoc-mode))
(eval-after-load "rainbow-mode" '(diminish 'rainbow-mode))
(eval-after-load "paredit" '(diminish 'paredit-mode))
(eval-after-load "autopair" '(diminish 'autopair-mode))
(eval-after-load "abbrev" '(diminish 'abbrev-mode))
(eval-after-load "company" '(diminish 'company-mode))
(eval-after-load "js2-highlight-vars" '(diminish 'js2-highlight-vars-mode))
(eval-after-load "projectile" '(diminish 'projectile-mode))
(eval-after-load "mmm-mode" '(diminish 'mmm-mode))
(eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
(eval-after-load "skewer-mode" '(diminish 'skewer-mode))
(eval-after-load "auto-indent-mode" '(diminish 'auto-indent-minor-mode))
(eval-after-load "highlight-parentheses" '(diminish 'highlight-parentheses-mode))
;; (eval-after-load "subword" '(diminish 'subword-mode))
(eval-after-load "anzu" '(diminish 'anzu-mode))
(eval-after-load "cider" '(diminish 'cider-mode))
(eval-after-load "smartparens" '(diminish 'smartparens-mode))
(eval-after-load "git-gutter" '(diminish 'git-gutter-mode))
(eval-after-load "volatile-highlights" '(diminish 'volatile-highlights-mode))

(eval-after-load "js2-mode"
  '(defadvice js2-mode (after js2-rename-modeline activate)
     (setq mode-name "JS+")))
(eval-after-load "clojure-mode"
  '(defadvice clojure-mode (after clj-rename-modeline activate)
     (setq mode-name "Clj")))
(eval-after-load "typescript"
  '(defadvice typescript-mode (after typescript-rename-modeline activate)
     (setq mode-name "TS")))
(eval-after-load "nxhtml-mode"
  '(defadvice nxhtml-mode (after nxhtml-rename-modeline activate)
     (setq mode-name "HTML")))
(eval-after-load "js"
  '(defadvice js-mode (after js-rename-modeline activate)
     (setq mode-name "JS")))
(defadvice emacs-lisp-mode (after elisp-rename-modeline activate)
  (setq mode-name "ELisp"))

;; Handle ANSI colours in compile buffer output.
;; From https://gist.github.com/jwiegley/8ae7145ba5ce64250a05
(defun compilation-ansi-color-process-output ()
  (ansi-color-process-output nil)
  (set (make-local-variable 'comint-last-output-start)
       (point-marker)))
(add-hook 'compilation-filter-hook #'compilation-ansi-color-process-output)

;; Install the colour scheme according to personal taste.
(defun x-appearance/apply-style ()
  (interactive)
  (cond
   ((equal x-personal-taste/style 'dark)
    (x-appearance/dark))
   ((equal x-personal-taste/style 'light)
    (x-appearance/light))))

(x-appearance/apply-style)



(provide 'x-appearance)
