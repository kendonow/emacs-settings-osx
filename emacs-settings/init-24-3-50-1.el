
;; (setq debug-on-quit t)

;; (require '00-load-path)
(let ((default-directory "~/emacs-setting/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'fixpath)

(require 'help-fns+)
(require 'help-mode+)


(require '01-common-setting)
(message "01-common-setting")

(require '02-base-setting)
(message "02-base-setting")
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



;; (setq org-src-fontify-natively t)


(put 'dired-find-alternate-file 'disabled nil)

;; (require '03-extend)

;; (message "03-extend")

;; (require '05-extend)
(require '06-key-setting)
;; (message "06-key-setting")

;; (global-set-key (kbd "C-x b") 'ibuffer-other-window)

(add-hook 'ibuffer-load-hook 
          (lambda()
            (define-key ibuffer-mode-map "\C-g" 'ibuffer-quit)
            ))

(require 'key-helm)
(message "key-helm")

;; (require '04-c-mode-setting)
;; (message "04-c-mode-setting")

;; (require '07-extend)

;; (require '08-org-emphasis)

;; (require '08-org-setting)

(require 'markdown-mode-config)

;; (require '08-extend)
(toggle-fullscreen)
;; (require 'maxframe)
;; (maximize-frame)

(require 'emms-config)
(message "emms-config")

;; (require 'color-theme)
(require 'color-theme-solarized)
(require 'color-theme-twilight)
(require 'color-theme-molokai)
(color-theme-molokai)
;; (color-theme-solarized-dark)
;
(require 'dired-setting)

(provide 'init-24-3-50-1)
