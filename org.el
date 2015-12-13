(defun org-publish-my-get-base-files (project &optional exclude-regexp)
  "Return a list of all files in PROJECT.
If EXCLUDE-REGEXP is set, this will be used to filter out
matching filenames."
  (let* ((project-plist (cdr project))
     (base-dir (file-name-as-directory
            (plist-get project-plist :base-directory)))
     (dir (concat (file-name-as-directory
            (plist-get project-plist :base-directory)) "note/"))
     (include-list (plist-get project-plist :include))
     (recurse (plist-get project-plist :recursive))
     (extension (or (plist-get project-plist :base-extension) "org"))
     ;; sitemap-... variables are dynamically scoped for
     ;; org-publish-compare-directory-files:
     (org-publish-sitemap-requested
      (plist-get project-plist :auto-sitemap))
     (sitemap-filename
      (or (plist-get project-plist :sitemap-filename) "sitemap.org"))
     (org-publish-sitemap-sort-folders
      (if (plist-member project-plist :sitemap-sort-folders)
          (plist-get project-plist :sitemap-sort-folders)
        org-publish-sitemap-sort-folders))
     (org-publish-sitemap-sort-files
      (cond ((plist-member project-plist :sitemap-sort-files)
         (plist-get project-plist :sitemap-sort-files))
        ;; For backward compatibility:
        ((plist-member project-plist :sitemap-alphabetically)
         (if (plist-get project-plist :sitemap-alphabetically)
             'alphabetically nil))
        (t org-publish-sitemap-sort-files)))
     (org-publish-sitemap-ignore-case
      (if (plist-member project-plist :sitemap-ignore-case)
          (plist-get project-plist :sitemap-ignore-case)
        org-publish-sitemap-sort-ignore-case))
     (match (if (eq extension 'any) "^[^\\.]"
          (concat "^[^\\.].*\\.\\(" extension "\\)$"))))
    ;; Make sure `org-publish-sitemap-sort-folders' has an accepted
    ;; value.
    (unless (memq org-publish-sitemap-sort-folders '(first last))
      (setq org-publish-sitemap-sort-folders nil))

    (setq org-publish-temp-files nil)
    (if org-publish-sitemap-requested
    (pushnew (expand-file-name (concat base-dir sitemap-filename))
          org-publish-temp-files))
    (org-publish-get-base-files-1 dir recurse match
                  ;; FIXME distinguish exclude regexp
                  ;; for skip-file and skip-dir?
                  exclude-regexp exclude-regexp)
    (mapc (lambda (f)
        (pushnew
         (expand-file-name (concat dir f))
         org-publish-temp-files))
      include-list)
    org-publish-temp-files))

(defun org-publish-my-sitemap (project &optional sitemap-filename)
  "Create a sitemap of pages in set defined by PROJECT.
Optionally set the filename of the sitemap with SITEMAP-FILENAME.
Default for SITEMAP-FILENAME is `sitemap.org'."
  (let* ((project-plist (cdr project))
     (base-dir (file-name-as-directory
            (plist-get project-plist :base-directory)))
     (dir (concat (file-name-as-directory
           (plist-get project-plist :base-directory)) "note/"))
     (localdir (file-name-directory dir))
     (indent-str (make-string 2 ?\ ))
     (exclude-regexp (plist-get project-plist :exclude))
     (files (nreverse
         (org-publish-my-get-base-files project exclude-regexp)))
     (sitemap-filename (concat base-dir (or sitemap-filename "sitemap.org")))
     (sitemap-title (or (plist-get project-plist :sitemap-title)
              (concat "Sitemap for project " (car project))))
     (sitemap-style (or (plist-get project-plist :sitemap-style)
                'tree))
     (sitemap-sans-extension
      (plist-get project-plist :sitemap-sans-extension))
     (visiting (find-buffer-visiting sitemap-filename))
     (ifn (file-name-nondirectory sitemap-filename))
     file sitemap-buffer)
    (with-current-buffer
    (let ((org-inhibit-startup t))
      (setq sitemap-buffer
        (or visiting (find-file sitemap-filename))))
      (erase-buffer)
      (insert (concat "#+TITLE: " sitemap-title "\n\n"))
      (insert "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"./asset/main.css\" />\n\n")
      (while (setq file (pop files))
    (let ((fn (file-name-nondirectory file))
          (link (file-relative-name file base-dir))
          (oldlocal localdir))
      (when sitemap-sans-extension
        (setq link (file-name-sans-extension link)))
      ;; sitemap shouldn't list itself
      (unless (equal (file-truename sitemap-filename)
             (file-truename file))
        (if (eq sitemap-style 'list)
        (message "Generating list-style sitemap for %s" sitemap-title)
          (message "Generating tree-style sitemap for %s" sitemap-title)
          (setq localdir (concat (file-name-as-directory dir)
                     (file-name-directory link)))
          (unless (string= localdir oldlocal)
        (if (string= localdir dir)
            (setq indent-str (make-string 2 ?\ ))
          (let ((subdirs
             (split-string
              (directory-file-name
               (file-name-directory
                (file-relative-name localdir dir))) "/"))
            (subdir "")
            (old-subdirs (split-string
                      (file-relative-name oldlocal dir) "/")))
            (setq indent-str (make-string 2 ?\ ))
            (while (string= (car old-subdirs) (car subdirs))
              (setq indent-str (concat indent-str (make-string 2 ?\ )))
              (pop old-subdirs)
              (pop subdirs))
            (dolist (d subdirs)
              (setq subdir (concat subdir d "/"))
              ; (insert (concat indent-str " + " d "\n")) TODO set to year
              (setq indent-str (make-string
                    (+ (length indent-str) 2) ?\ )))))))
        ;; This is common to 'flat and 'tree
        (let ((entry
           (org-publish-format-file-entry
            org-publish-sitemap-file-entry-format file project-plist))
          (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
          (cond ((string-match-p regexp entry)
             (string-match regexp entry)
             (insert (concat indent-str " + " (match-string 1 entry)
                     "[[file:" link "]["
                     (match-string 2 entry)
                     "]]" (match-string 3 entry) "\n")))
            (t
             (insert (concat indent-str " + [[file:" link "]["
                     entry
                     "]]\n"))))))))
      (save-buffer))
    (or visiting (kill-buffer sitemap-buffer))))


(setq org-html-postamble t)

(setq org-html-postamble-format
      '(("en" "<div class=\"postamble\">%d</div>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-2858592-2', 'auto');
  ga('send', 'pageview');

</script>
")))

(setq org-html-preamble "<div class=\"preamble\">
<div id=\"header\"><a href=\"/\">Liven.im</a></div>
</div>")

(setq org-html-head-extra "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1\"/>
")
