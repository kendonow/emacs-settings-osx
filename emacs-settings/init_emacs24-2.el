


(require '00-load-path)
(require 'cl-lib)


(require '01-common-setting)
(require '02-base-setting)
(require '04-c-mode-setting)

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
(require '04-org-extend)

(require '05-extend)
(require '06-key-setting)

;; (global-set-key (kbd "C-x b") 'ibuffer-other-window)

;; (require 'key-helm)
(require 'fg-anything)

;; (color-theme-matrix)

(require 'color-theme-solarized)
(color-theme-solarized-dark)


(provide 'init_emacs24-2)
