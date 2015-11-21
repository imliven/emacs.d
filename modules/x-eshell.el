(require 'x-lib)

;; Define a keybinding to get to your eshell quickly.
(global-set-key (kbd "C-c e") 'eshell)

;; Visual commands are commands which require a proper terminal.
;; eshell will run them in a term buffer when you invoke them.
(setq eshell-visual-commands
      '("less" "tmux" "htop" "top" "bash" "zsh" "fish"))
(setq eshell-visual-subcommands
      '(("git" "log" "l" "diff" "show")))

;; Suggest alternatives for mistyped commands.
;; (package-require 'eshell-did-you-mean)
;; (eshell-did-you-mean-setup)

;; Define a pretty prompt.
(package-require 'eshell-git-prompt)
(eshell-git-prompt-use-theme 'robbyrussell)

(setq eshell-cmpl-cycle-completions nil)

;; Add clear buffer functions
(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
      '(lambda()
          (local-set-key (kbd "C-l") 'eshell-clear-buffer)))


(provide 'x-eshell)
