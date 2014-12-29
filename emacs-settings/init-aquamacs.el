(message "load init-aquamacs.el")

(require '00-load-path)

(set-face-attribute 'default nil :height 160)

(require 'fg-anything)
(require 'smart-kill-mode)
(require '06-key-setting)
;; (require '01-common-setting)
;; (require '02-base-setting-aquamacs)







;; (when  (eq system-type 'darwin) 

;;   (when (or  (string-match "24.3.1" (emacs-version)) (string-match "24.2.1" (emacs-version)) )

;;     (set-frame-font "-apple-WenQuanYi_Micro_Hei_Mono-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;;     )
;;   )



;;                                         ;
;; (defun scroll-margin-hook()
;;   (make-local-variable 'scroll-margin)
;;   ;;  (setq scroll-step 0)
;;   (setq scroll-margin 0)
;;   (message "scroll-margin =0")
;;   )
;; (add-hook 'eshell-mode-hook 'scroll-margin-hook)
;;                                         ;
;;                                         ;
;;                                         ;
;; (setq split-height-threshold nil)
;; (setq split-width-threshold 80)



;; (setq org-src-fontify-natively t)


;; (put 'dired-find-alternate-file 'disabled nil)

 ;; (require '03-extend)
;; (require '04-org-extend)

;; (require '05-extend)
 ;; (require '06-key-setting)
;;  (require '04-c-mode-setting)

(message "load init-aquamacs.el endg")

(provide 'init-aquamacs)
