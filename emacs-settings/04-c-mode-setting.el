



(defun my-c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  ;; other customizations can go here
  (setq c++-tab-always-indent t) 
  (setq c-basic-offset 4) ;; Default is 2
  (setq c-indent-level 4) ;; Default is 2
  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)) 
  (setq tab-width 4) 
  (setq indent-tabs-mode t)             ; use spaces only if nil
  (require 'member-functions) 
  (setq mf--source-file-extension "cpp") 
  ;; (define-key c-mode-base-map (kbd "C-c ;"    ) 'comment-region-extend) 
  ;; (define-key c-mode-base-map (kbd "C-c '"    ) 'uncomment-region-extend)

  )



(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)




;; (add-to-list 'load-path "~/emacs-setting/cscope/")
 
;; (require 'xcscope_extend)
;; (require 'electric)
;; (electric-pair-mode 1)

;; ()

                                        ;(require 'jump-dls)

(setq show-paren-mode t) 
(setq show-paren-style 'parenthesis)
                                        ;(color-theme-sitaramv-nt)
                                        ;(color-theme-gnome2)



(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))


                                        ;(setq auto-mode-alist
                                        ;      (cons '("\\.rc$" . c++-mode)
                                        ;	    auto-mode-alist))
                                        ;
(setq auto-mode-alist (cons '("\\.inl$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ini$" . c++-mode) auto-mode-alist))



(setq auto-mode-alist (cons '("\\.odl$" . c++-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.idl$" . c++-mode) auto-mode-alist))





                                        ;
                                        ;(when (and  (string-match "24.3.50" (emacs-version)) )


;; (require 'cedet-buildin)



;; (require 'cedet-buildin-mini)



;; (require 'hidesearch)
;; ;; (global-set-key (kbd "C-c e") 'hidesearch)
;; ;; (global-set-key (kbd "C-c E") 'show-all-invisible)
;; (global-set-key (kbd "C-c o") 'switch-cc-to-h)
;; ;;


;; (require 'xgtags-extension)
;; (require 'key-xgtags)
;; (require 'ggtags-key)


;(add-to-list 'load-path "~/emacs-setting/ggtags-master/")

(require 'ggtags-config)

(require 'gtags-z)


;; (require 'cedet-setting-1-1)

                                        ;

(require 'generic-x)


(require 'feigo-c-mode)

;; (require 'feigo-c-highlight)


(defun etags-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ") 
  (eshell-command (format "find %s -type f -name \"*.[ch]\"  -o -name \"*.cpp\" | etags -"
                          dir-name)))

;; (require 'etags-u)

;; (add-hook 'c-mode-hook
;;   '(lambda()
;;      (etags-u-mode t)))



;; (require 'auto-complete-etags)
;; (add-to-list 'ac-sources 'ac-source-etags)

;; ;; If you want this to show documentation, also add the following:
;; ;; (setq ac-etags-use-document t)

;; ;;; function to be called when entering c-mode.
;; (defun my-c-mode-common-hook-func ()
;;   (interactive)
;;   "Function to be called when entering into c-mode."
;;   (when (and (require 'auto-complete nil t) (require 'auto-complete-config nil t))
;;     (auto-complete-mode t)
;;     (make-local-variable 'ac-sources)
;;     (setq ac-auto-start 2)
;;     (setq ac-sources '(ac-source-words-in-same-mode-buffers
;;                        ac-source-dictionary))
;;     (when (require 'auto-complete-etags nil t)
;;       (add-to-list 'ac-sources 'ac-source-etags)
;;       (setq ac-etags-use-document t))))

;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook-func)


                                        ; (setq tags-table-list '("~/Qt5.2.0/5.2.0/Src/TAGS" "~/qt_project/sci_draw/TAGS"))
                                        ; (require 'helm-etags+)



;; (require 'ggtags)

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;               (ggtags-mode 1))))


;; (require 'init-gtags)



(setq tags-table-list '(
                        ;; "/Volumes/mac_hd/qt_project/sci_draw/TAGS"
                        "~/Qt5.2.0/5.2.0/Src/TAGS"))



(require 'gdb-bp-session)
(require 'gdb-select-window)




;; (custom-set-variables
;;   '(ac-etags-requires 1))

;; (eval-after-load "etags"
;;   '(progn
;;       (ac-etags-setup)))

;; (add-hook 'c-mode-common-hook 'ac-etags-ac-setup)
;; (add-hook 'ruby-mode-common-hook 'ac-etags-ac-setup)

;; add
;; (require 'custom-auto-complete)


;; (require '04-cedet1-1-setting)
;; (require 'custom-auto-completeplus)
;; (require 'custom-auto-complete)

;; ;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(require 'qt-pro)
(add-to-list 'auto-mode-alist '("\\.pr[io]$" . qt-pro-mode))
;(add-to-list 'load-path "~/emacs-setting/auto-complete/")


;; (require 'company-config )

(require 'fg-auto-complete-config)
;; ;; (setq acg/global-environment-dbpath '("~/Qt5.2.0/5.2.0/Src"))
;; (setq acg/global-environment-dbpath nil)

;; (require 'ac-helm)  
;; (global-set-key (kbd "M-'") 'ac-complete-with-helm)
;; (define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)


;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


(require 'jump-c-to-method)


(provide '04-c-mode-setting)
