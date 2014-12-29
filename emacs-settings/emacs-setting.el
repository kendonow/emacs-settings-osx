
;;(ansi-color-for-comint-mode-on)
;;(global-unset-key (kbd "C-z"))
;;
(when (eq system-type 'darwin) 
  (setq mac-option-modifier 'meta)
                                        
  )

;(require 'common-setting)

;(require 'easy-bookmark) 
;(add-to-list 'load-path "~/emacs-setting/bookmark-plus/")
;
;(require 'bookmark+)

;(require 'custom-auto-complete)

;;(when (or (string-match "24.2.1" (emacs-version))  )
;;;(unless (or (string-match "24.2.1" (emacs-version))  )
;;  (setq mac-command-modifier 'control)
;;
;;  (add-to-list 'load-path "~/emacs-setting/ecb-snap/")
;;
;;;  (require 'cedet-setting-24)
;;
;;  (require 'ecb-setting)
;;
;;
;;  (desktop-save-mode 1)
;;
;;  (setq desktop-path '("~/.emacs.d/"))
;;  (setq desktop-dirname "~/.emacs.d/")
;;
;;  )

;(setq tab-width 4 indent-tabs-mode nil)
;(require 'doc-view)
;(require 'multi-eshell)

;(require 'color-theme)
                                        
;(color-theme-dark-laptop)

;(require 'parenthesis)

;(require 'crosshairs)
                                        
;(require 'hexrgb)

;(require 're-builder+)

;(require 'anything-config)                     
;(require 'go-to-char) 

;(require 'savehist-20+)

;(savehist-mode t)


;(require 'unbound)
                                        
;(require 'recent-jump-settings)

;(require 'shell-command)
;
;(require 'shell-command-extension)
;(put 'narrow-to-region 'disabled nil)
;

;(require 'isearch-extension)

;(require 'lazy-search-extension)

;;(defun ns-toggle-full-screen-32 () 
;;  (interactive) 
;;  (shell-command "emacs_fullscreen.exe --topmost")
;;  )
;;
;;
;;(if (eq system-type 'windows-nt) 
;;    (global-set-key  [C-f12] 'ns-toggle-full-screen-32)
;;  (global-set-key  [C-f12] 'ns-toggle-fullscreen)
;;  )
;;
;(require 'thing-edit-key-config)

;(require 'one-key-config)

;(require 'color-moccur-setting)

;;(when (or (string-match "24.2.1" (emacs-version))  )
;;
;;)
;;(split-window-right)
;;
;(require 'feigo-key-setting)

;(put 'scroll-left 'disabled nil)

;;(require 'multi-select-config)
;;
;;(require 'folding)
;;
;;(load "folding" 'nomessage 'noerror)
;;
;;(require 'vb-mode-setting)
;;
;;(require 'iedit)
;;(require 'auto-highlight-symbol)
;;(global-auto-highlight-symbol-mode t)
;;
;;(require 'macros+)
;;
;(require 'maxframe)
;(maximize-frame)
;
;
;(require  'rect-replace)
;
;(show-paren-mode t)
;
;(setq show-paren-style 'expression) 
;
;(require 'grep-edit-set)
;(require 'hi-lock)
;
;(require 'hide-lines)
;                                        
;(require 'feigo-alias)
;



;(add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
;(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
;(require 'slime)
;(slime-setup)



(provide 'emacs-setting)
