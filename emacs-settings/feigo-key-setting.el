

;(define-key global-map "\C-cf" ' semantic-analyze-proto-impl-toggle)
;; (global-set-key (kbd "C-,")     'Control-X-prefix)
(global-set-key [f1]  'Control-X-prefix)

;; (define-key global-map "\C-cd" ' my-insert-date)


;(define-key global-map "\C-ch" ' hide-unmatching-lines )
;(define-key global-map "\C-c\M-h" ' hide-matching-lines)
;(define-key global-map "\C-cH" ' hide-show-all-invisible)

;
;(global-set-key (kbd "C-c h h"  ) 'hide-unmatching-lines)
;(global-set-key (kbd "C-c h m"  ) 'hide-matching-lines)
;(global-set-key (kbd "C-c h s"  ) 'hide-show-all-invisible)
;;
;

(defun shellgtags ()
  (interactive)
  (shell-command "/usr/local/bin/gtags")
)

(require 'feigo-function)

(global-set-key (kbd "C-c C-'") 'my-cc-mode-comment-dwim)
(global-set-key (kbd "C-c '") 'my-cc-mode-comment-dwim)

(global-set-key (kbd "<M-delete>") 'kill-word)



;; (global-set-key (kbd "M-g")        'goto-line )





;(require 'highlight-symbol-setting)

;(global-set-key (kbd "C-x e")        'highlight-symbol-at-point-v2 )









(defun multi-eshell-switch-to-next-live-shell-repeat ()
  (interactive)
  (feigo-repeat-command 'multi-eshell-switch-to-next-live-shell)
)


(define-prefix-command 'ctrl-d-map)

(define-key ctl-x-map   "d" ctrl-d-map)

(define-key ctrl-d-map "u"     ' cua-mode )
;; (define-key ctrl-d-map "k"     ' kill-all-buffers-except-current )
(define-key ctrl-d-map "l"     ' hl-line-mode )
(define-key ctrl-d-map "v"     ' visual-line-mode )
(define-key ctrl-d-map "c"     ' desktop-clear )
(define-key ctrl-d-map "e"     ' multi-eshell )
(define-key ctrl-d-map "n"     ' multi-eshell-switch-to-next-live-shell-repeat)
;(define-key ctrl-d-map "\M-e"     ' revert-buffer )
(define-key ctrl-d-map "r"     ' revert-buffer )
(define-key ctrl-d-map "b"     ' eval-buffer )
;(define-key ctrl-d-map "E"     ' eval-buffer )

(define-key ctrl-d-map "t"     ' toggle-truncate-lines)
(define-key ctrl-d-map "d"     ' dired )
(define-key ctrl-d-map "D"     ' ido-dired )

(define-key ctrl-d-map "g"     ' grep-find )
;; (define-key ctrl-d-map "o"     ' org-mode )
;; (define-key ctrl-d-map "j"     ' feigo-study-en-mode )
(define-key ctrl-d-map "m"     ' my-insert-date)
(define-key ctrl-d-map "o"     ' my-show-date-time)
;; (define-key ctrl-d-map "h"     ' maximize-frame)
;; (define-key ctrl-d-map "o"     ' my-show-date-time)

;; (define-key  ctrl-d-map  "a"    ' find-name-dired          )
;; (define-key  ctrl-d-map  "i"    ' find-lisp-find-dired          )

;; (define-key  ctrl-d-map  "a"    ' align-regexp          )
;; (define-key  ctrl-d-map  "\C-a" ' align-regexp-repeated )

;; (define-key ctrl-d-map "i"     'toggle-line-spacing )


;(define-key ctrl-d-map "sl"    ' slime )
(define-key ctrl-d-map "s"    ' scroll-lock-mode )

(define-key ctrl-d-map "w"     (lambda ( ) (interactive ) (feigo-repeat-command 'rotate-windows)))
(define-key ctrl-d-map "W"    (lambda ( ) (interactive ) (feigo-repeat-command 'rotate-windows-reverse)))



;;==================================================

(global-set-key "\C-c\C-m" 'execute-extended-command)


(global-set-key (kbd "C-x M-s") 'save-some-buffers)

;; (global-set-key (kbd "C-x M-d") 'ido-dired)





;; (define-prefix-command 'ctrl-xgtags-map)

;; (define-key ctl-x-map   "g" ctrl-xgtags-map)


;; (define-key ctrl-xgtags-map "d" 'xgtags-find-tag)
;; (define-key ctrl-xgtags-map "c" 'xgtags-find-rtag)
;; (define-key ctrl-xgtags-map "s" 'xgtags-find-symbol)
;; (define-key ctrl-xgtags-map "g" 'xgtags-find-with-grep)
;; (define-key ctrl-xgtags-map "i" 'xgtags-find-with-idutils)
;; (define-key ctrl-xgtags-map "u" 'xgtags-pop-stack)
;; (define-key ctrl-xgtags-map "x" 'xgtags-switch-to-buffer)
;; (define-key ctrl-xgtags-map "\C-x" 'xgtags-switch-to-buffer-other-window)
;; (define-key ctrl-xgtags-map "r" 'xgtags-query-replace-regexp)

;; (define-key ctrl-xgtags-map "g" 'xgtags-generate-gtags-files )
;; (define-key ctrl-xgtags-map "u" 'xgtags-select-tag-return-window )
;; (define-key ctrl-xgtags-map "o" 'xgtags-select-tag-other-window )
;; (define-key ctrl-xgtags-map "f" 'xgtags-find-rtag-no-prompt )
;; (define-key ctrl-xgtags-map "j" 'xgtags-select-next-tag-line )
;; (define-key ctrl-xgtags-map "k" 'xgtags-select-prev-tag-line )
;; (define-key ctrl-xgtags-map "n" 'xgtags-select-next-tag-line-show )
;; (define-key ctrl-xgtags-map "p" 'xgtags-select-prev-tag-line-show )
;; (define-key ctrl-xgtags-map "N" 'xgtags-select-next-file )
;; (define-key ctrl-xgtags-map "P" 'xgtags-select-prev-file )


;; (define-key ctrl-xgtags-map "v" 'xgtags-visit-rootdir)

(require 'buffer-move)
;
;(global-set-key (kbd "C-x w <left>"  ) ' buf-move-keybinding  ) 
;(global-set-key (kbd "C-x w w"  ) ' buf-move-keybinding  ) 
;(global-set-key (kbd "C-x w <right>" ) ' buf-move-keybinding  ) 
;(global-set-key (kbd "C-x w <down>"  ) ' buf-move-keybinding  ) 
 ;(global-set-key (kbd "C-x w <up>"    ) ' buf-move-keybinding  ) 
;

;(global-set-key (kbd "C-x o"  ) ' other-buffer-keybinding  ) 


(global-unset-key "\C-xf")

;; (global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\C-x\C-b" 'ibuffer-other-window)

(global-set-key "\C-xK" 'kill-other-window-buffer)
;; (global-set-key "\C-x\M-k" 'kill-all-buffers-except-current)


(require 'buffer-extension)

(define-key global-map "\C-xdf"    ' copy-buffer-filename-as-kill     )
(define-key global-map "\C-xd\C-f" ' copy-buffer-directory-as-kill    )
(define-key global-map "\C-xd\M-f" ' copy-buffer-fullfilename-as-kill )


;; (global-set-key "\C-xo" 
;;  (lambda ( ) (interactive ) (feigo-repeat-command 'other-window)))


;; (global-set-key "\C-x," 
;;  (lambda ( ) (interactive ) (feigo-repeat-command 'previous-buffer)))


;; (global-set-key "\C-x." 
;;  (lambda ( ) (interactive ) (feigo-repeat-command 'next-buffer)))






; (if (symbolp hs-minor-mode) 

(load-library "hideshow")
(defun hs-minor-mode-rebind ()
  (hs-minor-mode 1)

  (define-key hs-minor-mode-map "\C-c5h"	      'hs-hide-block)
  (define-key hs-minor-mode-map "\C-c5s"	      'hs-show-block)
  (define-key hs-minor-mode-map "\C-c5\M-h"    'hs-hide-all)
  (define-key hs-minor-mode-map "\C-c5\M-s"    'hs-show-all)
  (define-key hs-minor-mode-map "\C-c5l"	      'hs-hide-level)
  (define-key hs-minor-mode-map "\C-c5t"	      'hs-toggle-hiding)
  )
(add-hook 'c++-mode-hook               ; other modes similarly
          (lambda () (hs-minor-mode-rebind)))



(define-key Buffer-menu-mode-map "\C-g" 'quit-window)

(add-hook 'help-mode-hook
(lambda () 
  (define-key help-mode-map "\C-g" 'quit-window)
  )
)


;
(require 'misc-cmds)


(define-key visual-line-mode-map "\C-a" 'beginning-of-visual-line+)
(define-key visual-line-mode-map "\C-e" 'end-of-visual-line+)


(substitute-key-definition       'recenter 'recenter-top-bottom global-map)
(substitute-key-definition       'move-beginning-of-line 'beginning-of-line+ global-map)
(substitute-key-definition       'move-end-of-line 'end-of-line+ global-map)





(define-prefix-command 'ctrlx-f-map)

(define-key ctl-x-map   "f" ctrlx-f-map)

(define-key ctrlx-f-map "r"     'rgrep )
(define-key ctrlx-f-map "f"     'grep-find )
(define-key ctrlx-f-map "o"     'find-grep-dired )
(define-key ctrlx-f-map "m"     'moccur-grep-find )


 (define-key  ctrlx-f-map  "d"    ' find-name-dired          )
 (define-key  ctrlx-f-map  "l"    ' find-lisp-find-dired          )

;; (define-key ctrlx-f-map "a"     'anything-do-grep )

;; (define-key ctrlx-f-map "\C-a"     'ack )
;; (define-key ctrlx-f-map "a"     'ack-same )

;; (define-key ctrlx-f-map "a"     'ack)               
;; (define-key ctrlx-f-map "s"     'ack-same)          
;; (define-key ctrlx-f-map "f"     'ack-find-file)     
;; (define-key ctrlx-f-map "d"     'ack-find-file-same)

;; (setq ack-and-a-half-prompt-for-directory t)

;; (global-set-key (kbd "C-x a a") 'ack)
;; (global-set-key (kbd "C-x a s") 'ack-same)
;; (global-set-key (kbd "C-x a f") 'ack-find-file)
;; (global-set-key (kbd "C-x a d") 'ack-find-file-same)



;; (global-set-key (kbd "C-x <left>"  )  (lambda ( ) (interactive ) (feigo-repeat-command 'previous-buffer)))
;; (global-set-key (kbd "C-x <right>"  )  (lambda ( ) (interactive ) (feigo-repeat-command 'next-buffer)))

;(define-key ctrlx-g-map "a"     'anything-grep )

                                        ;(global-set-key "\C-e" 'end-of-line+)
                                        ;(global-set-key "\C-a" 'beginning-of-line+)



;; (define-key global-map [?\M-r] 'move-to-window-line-top-bottom)





(defun my-next-beginning-fun (&optional arg)
  (interactive "P")
  (let ((bounds (bounds-of-thing-at-point 'defun)))
    (if bounds
        (end-of-defun )
      )
    )
  (end-of-defun arg )

  (beginning-of-defun )
    
  ;;   (if bounds
  ;;   (goto-char (car bounds))  )
    ;; )
)

(defun my-prev-end-fun (&optional arg)
  (interactive "P")
  (let ((bounds (bounds-of-thing-at-point 'defun)))
    (if bounds
        (beginning-of-defun )
      )
    )
  (beginning-of-defun arg )

  (end-of-defun )


  ;; (let ((bounds (bounds-of-thing-at-point 'defun)))
  ;;   (unless bounds
  ;;     (beginning-of-defun)
  ;;     )
  ;;   ;; (if bounds
  ;;   ;; (goto-char (cdr bounds))  )
  ;;   )
  ;; (end-of-defun arg)
  ;; (beginning-of-defun )
)




;; (global-set-key (kbd "M-n") 'forward-paragraph)
;; (global-set-key (kbd "M-p") 'backward-paragraph)

;;      (define-key c-mode-base-map (kbd "M-o") 'eassist-switch-h-cpp)
;;      (define-key c-mode-base-map (kbd "M-m") 'eassist-list-methods))




;; (defun my-lisp-mode-common-key-hook ()
;;   (define-key c-mode-base-map (kbd "M-e") 'my-prev-end-fun)
;;   (define-key c-mode-base-map (kbd "M-a") 'my-next-beginning-fun)
;;   )

;; ;; (add-hook 'c-mode-common-hook 'my-c-mode-common-key-hook)
;;  (add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-common-key-hook)






(provide 'feigo-key-setting)
