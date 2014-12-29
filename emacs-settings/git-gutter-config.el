;; (require 'git-gutter)
(require 'git-gutter-fringe)
(global-git-gutter-mode t)
(setq git-gutter-fr:side 'right-fringe)

;; (git-gutter:linum-setup)

;; If you enable git-gutter-mode for some modes

(global-set-key (kbd "C-x v t") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; ;; Jump to next/previous hunk
;; (global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
;; (global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

(require 'smart-repeat-mode)

(sr-define-alist  '( "\C-xvp" "\C-xvn") ' (("n"   git-gutter:previous-hunk) 
                                                   ("p"  git-gutter:next-hunk )
                                                   ))

;; (sr-define-alist  '( "\C-xp" "\C-xn") ' (("n"   git-gutter:previous-hunk) 
;;                                                    ("p"  git-gutter:next-hunk )
;;                                                    ))

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

;; (global-git-gutter-mode 1)
(add-hook 'c-mode-common-hook 'git-gutter-mode)
(add-hook 'emacs-lisp-mode-hook 'git-gutter-mode)


(custom-set-variables
 '(git-gutter:modified-sign "  ") ;; two space
 '(git-gutter:added-sign "++")    ;; multiple character is OK
 '(git-gutter:deleted-sign "--"))

(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(provide 'git-gutter-config )
