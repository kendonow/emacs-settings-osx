

(setq  mac-command-modifier 'control)



(require 'recentf-ext)



(ansi-color-for-comint-mode-on)


(setq tab-width 4 indent-tabs-mode nil)
(require 'multi-eshell)




;(color-theme-galen)

;(set-default-font "9x15")

(set-face-attribute 'default nil :height 160)
;; (set-face-attribute 'default nil :height 120)

(set-fontset-font
    (frame-parameter nil 'font)
    'han
    (font-spec :family "Hiragino Sans GB" ))


;(set-frame-font "微软雅黑-12")
;(set-frame-font "WenQuanYi Zen Hei")
;(set-frame-font "文泉驿等宽微米黑")
;(set-default-font "文泉驿等宽微米黑")


;(set-fontset-font "fontset-default" 'unicode '("WenQuanYi Zen Hei" . "unicode-ttf"))

;; ---- ;; (set-fontset-font "fontset-default" 'unicode '("文泉驿等宽微米黑" . "unicode-ttf"))

;(load-theme 'tango)	

;(set-frame-font "wqy-microhei");/文泉驿微米黑")

;; -adobe-courier-medium-r-normal--12-120-75-75-m-70-iso10646-1,
 ;; (set-frame-font "-adobe-courier-medium-r-normal--12-120-75-75-m-70-iso10646-1")

(require 'parenthesis)



;(require 're-builder+)


;(require 'anything-config)                     

;(require 'savehist-20+)

;(savehist-mode t)

                                        
(require 'recent-jump-settings)

(require 'shell-command)

(require 'shell-command-extension)
(put 'narrow-to-region 'disabled nil)

;; (require 'goto-chg)


;; (require 'isearch-extension)

;; (require 'lazy-search-extension)





;(require 'thing-edit-key-config)

;; (require 'color-moccur-setting)

;(split-window-right)

(require 'feigo-key-setting)

(put 'scroll-left 'disabled nil)



;(require 'multi-select-config)



;(require 'folding)

;(load "folding" 'nomessage 'noerror)


;; (require 'vb-mode-setting)

;; (require 'iedit)



;(show-paren-mode t)
(setq show-paren-style 'expression) 
;; (require 'grep-edit-set)

;; (require 'hi-lock)

(require 'hide-lines)
                                        
(require 'feigo-alias)

(require 'json-mode)




(setq vc-handled-backends nil)


(require 'smart-kill-mode)






;; (require 'mon-color-occur)
;; (require 'mon-rectangle-utils)


;; (require 'feigo-hightsymbol-mode)

;(setq browse-kill-ring-quit-action 'bury-buffer)
(setq browse-kill-ring-quit-action 'save-and-restore)

(setq scroll-margin 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
;(add-to-list 'load-path "~/emacs-setting/tree/")
;;
;(eval-after-load "tree-widget"
;  '(if (boundp 'tree-widget-themes-load-path)
;       (add-to-list 'tree-widget-themes-load-path "~/emacs-setting/tree/")))
;;
;(autoload 'imenu-tree "imenu-tree" "Imenu tree" t)
;;(autoload 'tags-tree "tags-tree" "TAGS tree" t)
;
;(require 'column-marker)

;(require 'sourcepair)
;(define-key global-map "\C-co" 'sourcepair-load)

(setq split-height-threshold nil)


;; (require 'feigo-tab-key-config)

;(require 'crosshairs)


;; (require 'linum-mode-scale)

(require 'feigo-study-en-mode)






;(require 'bm-ext)



(message "feigo-key-setting")

(require 'xah-comment)

;; (require 'emms-config)

;; (add-to-list 'load-path "~/emacs-setting/dict_app/")
(require 'dictionary)

;; (require 'dot-mode)
;; (add-hook 'find-file-hooks 'dot-mode-on)

(setq sml/theme 'light)
(require 'smart-mode-line)
(sml/setup)

;; (require 'fast-lock)
;; (global-font-lock-mode t)
;; (setq font-lock-maximum-decoration t
;; 	  font-lock-maximum-size nil)
;; (setq font-lock-support-mode 'fast-lock-mode ; lazy-lock-mode
;;       fast-lock-cache-directories '("~/.emacs-flc"))

(provide '02-base-setting)




