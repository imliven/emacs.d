(defgroup x-emacs nil
  "Your personal taste in X Emacs."
  :prefix "x-personal-taste/")

(defcustom x-personal-taste/run-wizard t
  "Should we run the X Emacs startup wizard on the next startup?"
  :group 'x-emacs
  :type '(choice (const :tag "Yes" t)
                 (const :tag "No" nil)))

(defcustom x-personal-taste/window-state 'normal
  "Should Emacs maximise its frame on startup, or leave it alone?"
  :group 'x-emacs
  :type '(choice (const :tag "Normal" normal)
                 (const :tag "Maximise" maximised)))

(defcustom x-personal-taste/style 'light
  "Light or dark colour scheme?"
  :group 'x-emacs
  :type '(choice (const :tag "Light" light)
                 (const :tag "Dark" dark)))

(defcustom x-personal-taste/splash nil
  "What sort of image to load into the initial scratch buffer."
  :group 'x-emacs
  :type '(choice (const :tag "Emergency Puppy" emergency-puppy)
                 (const :tag "Daily Otter" daily-otter)
                 (const :tag "Nothing" nil)))

(defcustom x-personal-taste/paredit nil
  "Do you want Paredit in Emacs Lisp buffers?"
  :group 'x-emacs
  :type '(choice (const :tag "Yes, please" t)
                 (const :tag "I'm not ready for that" nil)))

(defcustom x-personal-taste/training-wheels nil
  "Would you prefer an Emacs experience without the clutter of the menu bar,
toolbar and scrollbar?"
  :group 'x-emacs
  :type '(choice (const :tag "Yes, please" t)
                 (const :tag "I'm not ready for that" nil)))



(provide 'x-personal-taste)
