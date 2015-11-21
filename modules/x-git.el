(require 'x-package)

;; Invoke Magit by typing C-x g, and you can thank me later.
;; See http://magit.github.io/ for instructions.
(package-require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; Use M-x gist-buffer or M-x gist-region to create a gist
;; directly from the current buffer or selection.
(package-require 'gist)

;; Mark uncommitted changes in the fringe.
(package-require 'git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode t)



(provide 'x-git)
