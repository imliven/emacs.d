(require 'x-package)
(require 'x-personal-taste)

(with-current-buffer (get-buffer "*scratch*")
  (end-of-buffer)
  (delete-region 1 (point))
  (insert "Happy Hacking..."))


(provide 'x-splash)
