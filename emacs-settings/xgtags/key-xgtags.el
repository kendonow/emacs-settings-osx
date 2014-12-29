
;; (require 'xgtags-

(require 'gtags-update)

(require 'xgtags-extension)

(setq xgtags-overwrite-global-bindings nil)

(add-hook 'c-mode-common-hook
          (lambda ()
            (xgtags-mode 1)))


;; (global-set-key (kbd "C-x a")  'xgtags-mode-map)
;; (define-key xgtags-mode-map "\C-xa" xgtags-mode-map)

;; (setq xgtags-mode-map nil)
(defalias 'xgtags-create-xgtags-files 'xgtags-generate-gtags-files)

;; (define-key xgtags-mode-map  "\C-xag" 'xgtags-generate-gtags-files)
(define-key xgtags-mode-map  "\C-xac" 'xgtags-create-xgtags-files)
(define-key xgtags-mode-map  "\C-xav" 'xgtags-visit-rootdir-ex)
(define-key xgtags-mode-map  "\C-xau" 'xgtags-select-tag-return-window)
(define-key xgtags-mode-map  "\C-xab" 'xgtags-switch-to-buffer)
(define-key xgtags-mode-map  "\C-xaB" 'xgtags-switch-to-buffer-other-window)

(define-key xgtags-mode-map  "\C-xag" 'xgtags-find-with-grep)
(define-key xgtags-mode-map  "\C-xae" 'xgtags-find-pattern)
(define-key xgtags-mode-map  "\C-xah" 'xgtags-find-tag-from-here)
(define-key xgtags-mode-map  "\C-xau" 'xgtags-pop-stack)
(define-key xgtags-mode-map  "\C-xar" 'xgtags-find-rtag-no-prompt)
(define-key xgtags-mode-map  "\C-xaR" 'xgtags-find-rtag)



;; (defun xgtags-repeat-command (command)
;;   "Repeat COMMAND."
;;   ;; (let ((repeat-message-function  'ignore))
;;   (let ()
;;     (setq last-repeatable-command  command)
;;     (repeat nil)))




(define-prefix-command 'ctrl-g-map)
(define-key ctl-x-map   "g" ctrl-g-map)
;; (define-key ctrl-g-map "g"     'ggtags-find-tag )

(define-key ctrl-g-map  "c" 'xgtags-create-xgtags-files)
(define-key ctrl-g-map  "v" 'xgtags-visit-rootdir-ex)
(define-key ctrl-g-map  "u" 'xgtags-select-tag-return-window)
(define-key ctrl-g-map  "b" 'xgtags-switch-to-buffer)
(define-key ctrl-g-map  "B" 'xgtags-switch-to-buffer-other-window)

(define-key ctrl-g-map  "g" 'xgtags-find-with-grep)
(define-key ctrl-g-map  "e" 'xgtags-find-pattern)
(define-key ctrl-g-map  "s" 'xgtags-find-symbol)
(define-key ctrl-g-map  "h" 'xgtags-find-tag-from-here)
(define-key ctrl-g-map  "u" 'xgtags-pop-stack)
(define-key ctrl-g-map  "r" 'xgtags-find-rtag-no-prompt)
(define-key ctrl-g-map  "R" 'xgtags-find-rtag)
(define-key ctrl-g-map "d" 'xgtags-find-tag)








;; (require 'key-next-prev)
;; (define-non-global-lexical-3  '("\C-xgn" "\C-xgp") '(
;;        (?n  xgtags-select-next-tag 1)
;;        (?p  xgtags-select-prev-tag 1)) xgtags-mode-map

;; )


;; (define-key xgtags-mode-map "\C-xap" 
;;   (lambda ( ) (interactive ) (xgtags-repeat-command 'xgtags-select-prev-tag)))

;; (define-key xgtags-mode-map "\C-xan" 
;;   (lambda ( ) (interactive ) (xgtags-repeat-command 'xgtags-select-next-tag)))



(define-key xgtags-select-mode-map "p" 'xgtags-select-prev-tag-line-show)
(define-key xgtags-select-mode-map "n" 'xgtags-select-next-tag-line-show)




(define-key xgtags-select-mode-map "g" 'xgtags-generate-gtags-files)

(define-key xgtags-select-mode-map "k"  'xgtags-select-next-tag)
(define-key xgtags-select-mode-map "j"  'xgtags-select-prev-tag)

(define-key xgtags-select-mode-map "\M-p" 'xgtags-select-prev-file)
(define-key xgtags-select-mode-map "\M-n" 'xgtags-select-next-file)

(setq xgtags-overwrite-global-bindings nil)


(provide 'key-xgtags)
