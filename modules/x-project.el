(require 'x-package)

;; Install Projectile and activate it for all things.
;; Learn about Projectile: http://batsov.com/projectile/
(package-require 'projectile)
(projectile-global-mode)

;; Use C-c C-f to find a file anywhere in the current project.
(global-set-key (kbd "C-c C-f") 'projectile-find-file)



(provide 'x-project)
