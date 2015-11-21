;; Make PgUp/Dn move the point.
(setq scroll-error-top-bottom t)

;; Avy is a quick way to jump around your buffers.
;; https://github.com/abo-abo/avy
(package-require 'avy)
(global-set-key (kbd "C-;") 'avy-goto-word-1)
(global-set-key (kbd "C-:") 'avy-goto-char)
(with-eval-after-load "isearch"
  (define-key isearch-mode-map (kbd "C-;") 'avy-isearch))

;; Smart home key.
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line."
  (interactive "^")
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key (kbd "<home>") 'smart-beginning-of-line)
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

;; Consider CamelCase chunks as words when navigating.
(global-subword-mode 1)

;; Enhance C-x o when more than two windows are open.
(package-require 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x C-o") 'ace-swap-window)

;; Use C-x M-p to kill the buffer in the other window, revealing
;; the next buffer in the stack.
(global-set-key
 (kbd "C-x M-p")
 (lambda () (interactive)
   (save-excursion
     (other-window 1)
     (quit-window))))

;; Display incremental search stats in the modeline.
(package-require 'anzu)
(global-anzu-mode 1)

;; Anzu provides a version of `query-replace' and friends which give visual
;; feedback when composing regexps. Let's replace the regular versions.
(global-set-key (kbd "C-%") 'anzu-query-replace-at-cursor)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)



(provide 'x-navigation)
