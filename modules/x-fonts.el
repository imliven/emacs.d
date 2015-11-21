(require 'x-lib)

(defun x-fonts/spec-to-list (spec)
  (s-split "-" spec))

(defun x-fonts/list-to-spec (spec)
  (s-join "-" spec))

(defun x-fonts/update-font-spec-size (spec increment)
  (x-fonts/list-to-spec
   (-update-at 7 (lambda (i) (number-to-string
                              (+ (string-to-number i) increment)))
               (x-fonts/spec-to-list spec))))

(defun x-fonts/update-font-size (increment)
  (set-frame-font
   (x-fonts/update-font-spec-size (frame-parameter nil 'font) increment)))

(global-set-key (kbd "C-M--") (lambda () (interactive)
                                (x-fonts/update-font-size -1)))
(global-set-key (kbd "C-M-=") (lambda () (interactive)
                                (x-fonts/update-font-size 1)))

;; Setting English Font
(set-face-attribute 'default nil :font "Menlo 16")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "Hiragino Sans GB"
                                       :size 16)))

(provide 'x-fonts)
