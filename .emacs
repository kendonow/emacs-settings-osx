;;Set the default file path
;(setenv "HOME" 'load-path "emacs-settings-osx/")
;(setenv "PATH" (concat "emacs-settings-osx/" path-separator (getenv "PATH")))


;(setq eshell-path-env (append eshell-path-env '("/Library/Frameworks/Python.framework/Versions/2.7/bin")))
(add-to-list 'load-path "~/emacs-settings-osx/emacs-settings/")

(let ((default-directory "~/emacs-settings-osx/emacs-settings/"))
  (normal-top-level-add-subdirs-to-load-path))
(require 'fixpath)



(when (or (string-match "24.3.50.1" (emacs-version)) 
          (string-match "24.3.91.1" (emacs-version))) 
  (progn
    (require 'init-24-3-50-1))) 
(unless (string-match "Aquamacs" (emacs-version))
  (when (and  (string-match "24.3.1" (emacs-version)))
    (require 'init_emacs24-3)) 
  (when (or  (string-match "24.4.1" (emacs-version)) 
             ;; (string-match "25.0.50.1" (emacs-version))
             )

    ;; (require 'init-emacs-macport-24.4.1))
    (require 'init_emacs24-4)
)

  ;; (when (and  (string-match "24.2" (emacs-version)) )
  ;;   (require 'init_emacs24-2)
  ;; )
  )
(unless (string-match "Aquamacs" (emacs-version))
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(blink-cursor-mode nil) 
   '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmark-bak/qt511_bmk") 
   '(column-number-mode t) 
   '(comment-style (quote indent)) 
   '(custom-safe-themes (quote ("004b7ec6992be700b493de958c37aa5f28a220ca5d627601a208b9dabe7619ab"
                                "c74eb024ff373df31361c7ca1b2591e9a805c79a0107b5f2821a5d62cfc70698"
                                default))) 
   '(dired-listing-switches "-alh") 
   '(ediff-split-window-function (quote split-window-horizontally)) 
   '(generic-extras-enable-list (quote (alias-generic-mode apache-conf-generic-mode
                                                           apache-log-generic-mode bat-generic-mode
                                                           etc-fstab-generic-mode
                                                           etc-modules-conf-generic-mode
                                                           etc-passwd-generic-mode
                                                           etc-services-generic-mode
                                                           etc-sudoers-generic-mode
                                                           fvwm-generic-mode hosts-generic-mode
                                                           inetd-conf-generic-mode
                                                           java-manifest-generic-mode
                                                           java-properties-generic-mode
                                                           javascript-generic-mode
                                                           mailagent-rules-generic-mode
                                                           mailrc-generic-mode
                                                           named-boot-generic-mode
                                                           named-database-generic-mode
                                                           prototype-generic-mode rc-generic-mode
                                                           reg-generic-mode
                                                           resolve-conf-generic-mode
                                                           samba-generic-mode show-tabs-generic-mode
                                                           vrml-generic-mode x-resource-generic-mode
                                                           xmodmap-generic-mode))) 
   '(safe-local-variable-values (quote ((c-file-offsets (innamespace . 0) 
                                                        (inline-open . 0) 
                                                        (case-label . +)) 
                                        (emacs-lisp-docstring-fill-column . t) 
                                        (autocompile . t) 
                                        (linkd-mode . t)))) 
   '(semantic-default-submodes (quote (global-semantic-decoration-mode
                                       global-semantic-highlight-func-mode
                                       global-semantic-idle-scheduler-mode
                                       global-semantic-idle-summary-mode
                                       global-semantic-show-parser-state-mode
                                       global-semantic-stickyfunc-mode global-semanticdb-minor-mode
                                       global-semantic-highlight-edits-mode
                                       global-semantic-idle-breadcrumbs-mode
                                       global-semantic-idle-completions-mode
                                       global-semantic-idle-local-symbol-highlight-mode
                                       global-semantic-mru-bookmark-mode
                                       global-semantic-show-unmatched-syntax-mode))) 
   '(semantic-idle-scheduler-idle-time 3) 
   '(show-paren-mode t) 
   '(sr-attributes-display-mask (quote (nil nil t nil nil nil))) 
   '(tool-bar-mode nil))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(show-paren-match ((t (:background "darkgreen" 
                                       :bold t 
                                       :italic nil 
                                       :underline nil 
                                       :box nil)))))
)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-sources (quote (ac-source-yasnippet ac-source-semantic ac-source-imenu ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
 '(blink-cursor-mode nil)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmark-bak/qtBookmark")
 '(column-number-mode t)
 '(comment-style (quote indent))
 '(custom-safe-themes (quote ("9fd20670758db15cc4d0b4442a74543888d2e445646b25f2755c65dcd6f1504b" "004b7ec6992be700b493de958c37aa5f28a220ca5d627601a208b9dabe7619ab" "c74eb024ff373df31361c7ca1b2591e9a805c79a0107b5f2821a5d62cfc70698" default)))
 '(dired-listing-switches "-alh")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(generic-extras-enable-list (quote (alias-generic-mode apache-conf-generic-mode apache-log-generic-mode bat-generic-mode etc-fstab-generic-mode etc-modules-conf-generic-mode etc-passwd-generic-mode etc-services-generic-mode etc-sudoers-generic-mode fvwm-generic-mode hosts-generic-mode inetd-conf-generic-mode java-manifest-generic-mode java-properties-generic-mode javascript-generic-mode mailagent-rules-generic-mode mailrc-generic-mode named-boot-generic-mode named-database-generic-mode prototype-generic-mode rc-generic-mode reg-generic-mode resolve-conf-generic-mode samba-generic-mode show-tabs-generic-mode vrml-generic-mode x-resource-generic-mode xmodmap-generic-mode)))
 '(org-agenda-files (quote ("~/qt_project/mmi/doc/02_模块列表.org")))
 '(safe-local-variable-values (quote ((emacs-lisp-docstring-fill-column . 75) (c-file-offsets (innamespace . 0) (inline-open . 0) (case-label . +)) (emacs-lisp-docstring-fill-column . t) (autocompile . t) (linkd-mode . t))))
 '(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-highlight-func-mode global-semantic-idle-scheduler-mode global-semantic-idle-summary-mode global-semantic-show-parser-state-mode global-semantic-stickyfunc-mode global-semanticdb-minor-mode global-semantic-highlight-edits-mode global-semantic-idle-breadcrumbs-mode global-semantic-idle-completions-mode global-semantic-idle-local-symbol-highlight-mode global-semantic-mru-bookmark-mode global-semantic-show-unmatched-syntax-mode)))
 '(semantic-idle-scheduler-idle-time 3)
 '(show-paren-mode t)
 '(sr-attributes-display-mask (quote (nil nil t nil nil nil)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completions-common-part ((t (:inherit default :foreground "red"))))
 '(diredp-compressed-file-suffix ((t (:foreground "#7b68ee"))))
 '(diredp-ignored-file-name ((t (:foreground "#aaaaaa"))))
 '(mode-line ((t (:foreground "red" :background "blue4"))))
 '(mode-line-highlight ((t nil)))
 '(mode-line-inactive ((t (:background "gray24" :foreground "green"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#22ff6c"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow1"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "Magenta3"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "Brown"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#22ff6c" :background "#443344"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "yellow1" :background "#443344"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "Magenta3" :background "#443344"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#8b7500" :background "#443344"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "green" :background "red"))))
 '(show-paren-match ((((class color) (background light)) (:background "azure2"))))
 '(which-func ((t (:foreground "green")))))
(put 'set-goal-column 'disabled nil)

;;Add gtags
;(require 'gtags-z)
;(global-unset-key (kbd "C-Z"))
;(require 'gtags-update)
;(require 'company)
;(add-to-list 'company-backends 'company-gtags)
;(add-hook 'c-mode-hook '(lambda () (company-mode)))
;(setq company-idle-delay nil)
