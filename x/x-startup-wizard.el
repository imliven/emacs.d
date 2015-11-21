(require 'x-personal-taste)

(defun x-startup-wizard/get-window-state ()
  (x-popup-dialog
   t '("Normal or maximised window?"
       ("Normal" . normal)
       ("Maximised" . maximised))))

(defun x-startup-wizard/get-style ()
  (x-popup-dialog
   t '("Light or dark background?"
       ("Light" . light)
       ("Dark" . dark))))

(defun x-startup-wizard/get-splash ()
  (x-popup-dialog
   t '("What is your favourite animal?

We will put it on your splash screen for you, a fresh picture
every day, because your Emacs loves you.

This won't work if you're running Emacs in a terminal. Sorry.
Don't do that unless you really have to."
       ("Puppies" . emergency-puppy)
       ("The noble otter" . daily-otter)
       ("I hate animals" . nil))))

(defun x-startup-wizard/get-paredit ()
  (x-popup-dialog
   t '("Do you want to enable Paredit style editing for
the Emacs Lisp mode?

This will add a slight learning curve to your Elisp
journey, but trust me, it will be worth it."
       ("OK, let's paredit" . t)
       ("Not right now" . nil))))

(defun x-startup-wizard/get-training-wheels ()
  (x-popup-dialog
   t '("Would you like to get rid of the toolbar,
menu bar and scrollbar?

This is how adult emacsen roll, but you
might want to get comfortable with being
emacs before you assume your final form.

This is OK too; no pressure yet."
       ("I'm ready" . nil)
       ("Wait, I'm scared" . t))))

(defun x-startup-wizard ()
  (interactive)

  (x-popup-dialog
   t '("Welcome to the Church of Emacs, my child!

This is the first time you've run it, so let's
start off by asking you some basic questions
about how you like to emacs.

If you change your mind about any of these
decisions, you can re-run this wizard with
`M-x x-startup-wizard` (that is Alt+X
x-startup-wizard <enter> to non-native
speakers)."
       ("I am ready to emacs" . t)) t)

  (customize-save-variable
   'x-personal-taste/window-state
   (x-startup-wizard/get-window-state))

  (customize-save-variable
   'x-personal-taste/style
   (x-startup-wizard/get-style))

  (customize-save-variable
   'x-personal-taste/splash
   (x-startup-wizard/get-splash))

  (customize-save-variable
   'x-personal-taste/paredit
   (x-startup-wizard/get-paredit))

  (customize-save-variable
   'x-personal-taste/training-wheels
   (x-startup-wizard/get-training-wheels))

  (customize-save-variable 'x-personal-taste/run-wizard nil)
  (setq x/wizard-did-run t)
  (x/select-modules))

(when x-personal-taste/run-wizard
  (x-startup-wizard))



(provide 'x-startup-wizard)
