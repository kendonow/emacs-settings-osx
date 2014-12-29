

(require 'xcscope_hist_wash)

;; (require 'key-next-prev)

;; (define-non-global-lexical  "\C-csn" '( (?n   cscope-next-symbol ) 
;;                                     (?p   cscope-prev-symbol )      ) cscope:map)



;; (defvar smart-xcscope-flag nil)
;; (defvar xcsocpe-smart-keymap nil)

;; (defun close-xcscope-mode ( )
;;   (interactive)
;;   (smart-key-cscope-mode -1) 
;;   (push last-command-event unread-command-events)
;;   ;; (message "smart   toggle off")
;; )

;; (if xcsocpe-smart-keymap
;;     nil
;;   (setq xcsocpe-smart-keymap (make-keymap))
;;   (set-char-table-range (nth 1 xcsocpe-smart-keymap) t 'close-xcscope-mode)

;;   (suppress-keymap xcsocpe-smart-keymap)

;;   (define-key xcsocpe-smart-keymap "p"    'cscope-prev-symbol     )
;;   (define-key xcsocpe-smart-keymap "n"    'cscope-next-symbol     )

;; )

;; (define-minor-mode smart-key-cscope-mode
;;                    ""
;;   nil
;;   ;; The indicator for the mode line.
;;   " key-cscope"
;;   ;; The minor mode keymap
;;   xcsocpe-smart-keymap
;;    :global nil
;;    ;; :after-hook (if smart-xcscope-flag
;;    ;;                 (message "smart  mode toggle on")
;;    ;;              (message "smart  mode toggle off"))
;; )


;; (define-key cscope:map "\C-csp" 
;;   (lambda ( ) (interactive ) (smart-key-cscope-mode 1)))

;; (define-key cscope:map "\C-csn" 
;;   (lambda ( ) (interactive ) (smart-key-cscope-mode 1)))
