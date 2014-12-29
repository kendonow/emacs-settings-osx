

(unless (fboundp 'ctrl-ggtags-global--map) 
  (define-prefix-command 'ctrl-ggtags-global--map) 
  (global-set-key "\C-xg" ctrl-ggtags-global--map))





;; ;;--------------------------------------------------------------------------------
;; (global-set-key (kbd "C-x C-1") 'delete-other-windows)
;; (global-set-key (kbd "C-x C-2") 'split-window-below)
;; (global-set-key (kbd "C-x C-3") 'split-window-right)
;; (global-set-key (kbd "C-x C-0") 'delete-window)



;; (global-set-key (kbd "C-x C-o") 'ace-window)



;; (global-set-key  (kbd "C-z C-o") 'other-frame)
;; (global-set-key  (kbd "C-z C-2") 'make-frame-command)
;; (global-set-key  (kbd "C-z C-1") 'delete-other-frames)
;; (global-set-key  (kbd "C-z C-0") 'delete-frame)

;; (global-set-key (kbd "C-c C-;"    ) 'comment-region-extend)
;; (global-set-key (kbd "C-c C-'"    ) 'uncomment-region-extend)

(global-set-key (kbd "C-x s"    ) 'save-buffer)
(global-set-key (kbd "C-x C-s"    ) 'save-buffer)



;;(define-key god-local-mode-map (kbd "z") 'repeat)
;; (define-key god-local-mode-map (kbd "i") 'god-local-mode)
;; (global-set-key (kbd "C-x g"    ) 'god-local-mode)
(global-set-key (kbd "C-x g G") 'god-mode-all)
(global-set-key (kbd "C-x g g") 'god-local-mode)
(define-key god-local-mode-map (kbd "i") 'god-local-mode)
;; (global-set-key (kbd "ESC") 'god-local-mode)

;; (god-mode-all )
;; (global-set-key (kbd "C-i"    ) #'(lambda ()
;;                                     ( god-local-mode 1))
                                    
;; )

;; (sr-define-alist  '( "\C-c\C-b"  ) 
;;                             '(("b" recent-jump-backward    ) 
;;                               ;; ("\C-b" recent-jump-backward    )
;;                               ("f"   recent-jump-forward) 
;;                               ("v"  ace-jump-mode-pop-mark) 
;;                               ("u"  ace-jump-mode-pop-mark)))

;; (sr-define-alist '("\C-x\C-a" "\C-x\C-e"  ) 
;;                            '(
;;                              ("\C-a" beginning-of-buffer)
                             
;;                              ;; ("a" beginning-of-buffer)
;;                              ("\C-e" end-of-buffer)
                             
;;                              ;; ("e" end-of-buffer) 
;;                              ("\C-p" backward-paragraph) 
;;                              ("\C-n" forward-paragraph)) )

;; (global-set-key (kbd "C-x C-b") 'helm-buffers-list-and-dir)



(provide '08-god-mode-key)
