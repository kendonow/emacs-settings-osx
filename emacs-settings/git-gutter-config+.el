;; (require 'git-gutter)
(require 'git-gutter-fringe+)
(global-git-gutter+-mode t)

;; ;; (git-gutter:linum-setup)

;; ;; If you enable git-gutter-mode for some modes

;; (global-set-key (kbd "C-x v t") 'git-gutter:toggle)
;; (global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; ;; ;; Jump to next/previous hunk
;; ;; (global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
;; ;; (global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; (require 'smart-repeat-mode)

;; (sr-define-alist  '( "\C-xvp" "\C-xvn") ' (("n"   git-gutter:previous-hunk)
;;                                                    ("p"  git-gutter:next-hunk )
;;                                                    ))

;; ;; (sr-define-alist  '( "\C-xp" "\C-xn") ' (("n"   git-gutter:previous-hunk)
;; ;;                                                    ("p"  git-gutter:next-hunk )
;; ;;                                                    ))

;; ;; Stage current hunk
;; (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; ;; Revert current hunk
;; (global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

;; ;; (global-git-gutter-mode 1)
;; (add-hook 'c-mode-common-hook 'git-gutter-mode)
;; (add-hook 'emacs-lisp-mode-hook 'git-gutter-mode)


;; (custom-set-variables
;;  '(git-gutter:modified-sign "  ") ;; two space
;;  '(git-gutter:added-sign "++")    ;; multiple character is OK
;;  '(git-gutter:deleted-sign "--"))

;; (set-face-background 'git-gutter:modified "purple") ;; background color
;; (set-face-foreground 'git-gutter:added "green")
;; (set-face-foreground 'git-gutter:deleted "red")
(global-set-key (kbd "C-x v g") 'git-gutter+-mode) ; Turn on/off in the current buffer
(global-set-key (kbd "C-x v G") 'global-git-gutter+-mode) ; Turn on/off globally
(eval-after-load 
    'git-gutter+ 
  '(progn
;;; Jump between hunks
     ;; (define-key git-gutter+-mode-map (kbd "C-x v n") 'git-gutter+-next-hunk)
     ;; (define-key git-gutter+-mode-map (kbd "C-x v p") 'git-gutter+-previous-hunk)

;;; Act on hunks
     (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk) 
     (define-key git-gutter+-mode-map (kbd "C-x v r") 'git-gutter+-revert-hunks)
     ;; Stage hunk at point.
     ;; If region is active, stage all hunk lines within the region.
     (define-key git-gutter+-mode-map (kbd "C-x v t") 'git-gutter+-stage-hunks) 
     (define-key git-gutter+-mode-map (kbd "C-x v c") 'git-gutter+-commit) 
     (define-key git-gutter+-mode-map (kbd "C-x v C") 'git-gutter+-stage-and-commit) 
     (define-key git-gutter+-mode-map (kbd "C-x v C-y") 'git-gutter+-stage-and-commit-whole-buffer) 
     (define-key git-gutter+-mode-map (kbd "C-x v U") 'git-gutter+-unstage-whole-buffer))
)


(sr-define-alist  '( "\C-xvp" "\C-xvn") ' (("n"   git-gutter+-next-hunk) 
                                                     ("p"  git-gutter+-previous-hunk ) 
)
                                                     ;; nil git-gutter+-mode-map)
 )



;; ))

(setq git-gutter-fr+-side 'right-fringe)

(provide 'git-gutter-config+ )
