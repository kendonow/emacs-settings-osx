
;; (setq debug-on-quit t)

;; (require '00-load-path)
;; (let ((default-directory "~/emacs-setting/"))
;;   (normal-top-level-add-subdirs-to-load-path))

(require 'fixpath)

(require 'help-fns+)
(require 'help-mode+)

(require '01-common-setting)
(message "01-common-setting")

(require '02-base-setting)
(message "02-base-setting")







(when  (eq system-type 'darwin) 

  (when (or  (string-match "24.3.1" (emacs-version)) (string-match "24.2.1" (emacs-version)) )

    ;; (set-frame-font "-apple-WenQuanYi_Micro_Hei_Mono-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
    )
  )



                                        ;
(defun scroll-margin-hook()
  (make-local-variable 'scroll-margin)
  ;;  (setq scroll-step 0)
  (setq scroll-margin 0)
  (message "scroll-margin =0")
  )
(add-hook 'eshell-mode-hook 'scroll-margin-hook)
                                        ;
                                        ;
                                        ;
(setq split-height-threshold nil)
(setq split-width-threshold 80)



(setq org-src-fontify-natively t)


(put 'dired-find-alternate-file 'disabled nil)

(require '03-extend)

(message "03-extend")

(require '05-extend)
(require '06-key-setting)
(message "06-key-setting")

;; (global-set-key (kbd "C-x b") 'ibuffer-other-window)

(add-hook 'ibuffer-load-hook 
          (lambda()
            (define-key ibuffer-mode-map "\C-g" 'ibuffer-quit)
            ))

(require 'key-helm)
(message "key-helm")

(require '04-c-mode-setting)
(message "04-c-mode-setting")

(require '07-extend)




(require 'markdown-mode-config)

(require '08-extend)


;; (require '08-org-emphasis)
;; (require '08-org-setting)


;; (let ( (default-directory "~/"))
;;   (require 'init-w3m))

;; (require 'maxframe)
;; (maximize-frame)



(require 'color-theme)

;; (require 'color-theme-solarized)

;; (color-theme-solarized-dark)
;; (color-theme-solarized-dark)
(require 'paren)
(set-face-foreground 'show-paren-match "red")
(set-face-background 'show-paren-match "lime green")
(show-paren-mode t)
(setq show-paren-style 'parenthesis)

(color-theme-dark-laptop)
;; (color-theme-deep-blue)

;; (require 'multi-term)

;; (setq multi-term-program "/bin/bash")
;; (require '08-yas-config)
(toggle-fullscreen)

;; (require 'molokai-theme-kit)



(provide 'init_emacs24-3)
