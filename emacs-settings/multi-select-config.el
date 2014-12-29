(require 'multi-select)




(autoload 'multi-select-mode "multi-select" nil t)
(multi-select-mode t)


;(define-prefix-command 'my-mutli-select-key-map)
;(define-key ctl-x-map   "t" my-multi-select-key-map)
;;
;;(defvar my-mutli-select-key-map nil
;;  "The multi-select- keymap.")
;;(if my-mutli-select-key-map
;;    nil
;;  (setq my-mutli-select-key-map (make-sparse-keymap))
;;
;;  (define-key my-multi-select-key-map "\C-xta" 'multi-select-mark-region)
;;  (define-key my-multi-select-key-map "\C-xtd" 'multi-select-unmark-region)
;;  (define-key my-multi-select-key-map "\C-xte" 'multi-select-eval-on-selections)
;;  (define-key my-multi-select-key-map "\C-xtg" 'multi-select-cancel-all)
;;  (define-key my-multi-select-key-map "\C-xtk" 'multi-select-kill-selections)
;;  (define-key my-multi-select-key-map "\C-xtm" 'multi-select-toggle-auto-merge)
;;  (define-key my-multi-select-key-map "\C-xtq" 'multi-select-mode) ; toggles it off
;;  (define-key my-multi-select-key-map "\C-xtr" 'multi-select-mark-by-regexp)
;;  (define-key my-multi-select-key-map "\C-xtw" 'multi-select-wrap-selections)
;;  (define-key my-multi-select-key-map "\C-xtx" 'multi-select-execute-command)
;;  (define-key my-multi-select-key-map "\C-xtu" 'multi-select-undo-selection)
;;
;;  )
;;
;;


(define-prefix-command 'my-multi-select-keymap)
(global-set-key "\C-cm" 'my-multi-select-keymap)

;(define-key ctl-c-m-map "w" 'delete-trailing-writespace)
(define-key my-multi-select-keymap "a" 'multi-select-mark-region)
;(define-key my-multi-select-keymap "d" 'multi-select-unmark-region)
(define-key my-multi-select-keymap "e" 'multi-select-eval-on-selections)
(define-key my-multi-select-keymap "g" 'multi-select-cancel-all)
(define-key my-multi-select-keymap "k" 'multi-select-kill-selections)
(define-key my-multi-select-keymap "m" 'multi-select-toggle-auto-merge)
(define-key my-multi-select-keymap "q" 'multi-select-mode) ; toggles it off
(define-key my-multi-select-keymap "r" 'multi-select-mark-by-regexp)
(define-key my-multi-select-keymap "w" 'multi-select-wrap-selections)
(define-key my-multi-select-keymap "x" 'multi-select-execute-command)
(define-key my-multi-select-keymap "u" 'multi-select-undo-selection)
(define-key my-multi-select-keymap "\M-w" 'multi-select-kill-ring-save)





(provide 'multi-select-config)

