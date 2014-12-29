(blink-cursor-mode -3) 
(setq inhibit-startup-message t) 
(setq-default kill-whole-line t) 
(setq inhibit-startup-message t) 
(setq c-basic-offset 4)

(setq default-tab-width 4) 
(setq-default indent-tabs-mode  nil)



(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil)

(setq auto-save-default nil)
(delete-selection-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
(tooltip-mode -1)



(setq user-full-name "feigo.zj")
(global-auto-revert-mode 1)


(set-language-environment "chinese-gbk")
(set-terminal-coding-system 'chinese-gbk)
(set-keyboard-coding-system 'chinese-gbk)
(set-clipboard-coding-system 'chinese-gbk)
(set-buffer-file-coding-system 'chinese-gbk)
(set-selection-coding-system 'chinese-gbk)

(modify-coding-system-alist 'process "*" 'chinese-gbk)



(setq-default cursor-type 'box) 

;高亮当前行
(global-hl-line-mode t)

(setq browse-kill-ring-quit-action 'save-and-restore)

(setq scroll-margin 1)

(setq vc-handled-backends nil)


;inhibit  message for C-x C-l and C-x C-u 
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


(setq-default kill-whole-line t)
(setq kill-ring-max 200) 

(setq x-select-enable-clipboard t)


(setq default-truncate-lines t)

;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)




;////////////////////////////////////////
(require 'linum)
(setq linum-format "%3d ")

(add-hook 'find-file-hooks (lambda () (linum-mode 1)))



;////////////////////////////////////////
(require 'rect-mark)
(require 'rect-extension)
(require 'rect-replace)


;////////////////////////////////////////
(require 'ido)
(ido-mode t)



;////////////////////////////////////////
(defun my-c-mode-common-hook ()
 ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
 (c-set-offset 'substatement-open 0)
 ;; other customizations can go here

 (setq c++-tab-always-indent t)
 (setq c-basic-offset 4)                  ;; Default is 2
 (setq c-indent-level 4)                  ;; Default is 2

 (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
 (setq tab-width 4)
 (setq indent-tabs-mode t)  ; use spaces only if nil
 )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;;打开括号匹配显示模式
(setq show-paren-mode t) 
(setq show-paren-style 'parenthesis)

;标题栏显示文件路径
(setq frame-title-format
 '("%S" (buffer-file-name "%f"
 (dired-directory dired-directory "%b"))))



;(require 'xcscope-no-update)
;(add-to-list 'load-path "~/emacs-setting/cscope/")

(require 'xcscope_extend)



(require 'smart-kill-mode)


(require 'recentf-ext)


;(require 'iedit)

;; (require 'easy-bookmark) 

(if (eq system-type 'windows-nt) 

 (progn 
            ;(add-to-list 'load-path "d:/tools/emacs-setting/anything-config/")
            ;(add-to-list 'load-path "d:/tools/emacs-setting/anything-config/extensions")
            ;(add-to-list 'load-path "d:/tools/emacs-setting/anything-config/contrib")
           )

    (progn 
            ;(add-to-list 'load-path "~/emacs-setting/anything-config/")
            ;(add-to-list 'load-path "~/emacs-setting/anything-config/extensions")
            ;(add-to-list 'load-path "~/emacs-setting/anything-config/contrib")
           )

  )


(require 'anything-config)

(require 'key-anything-config)

(require 'feigo-key-setting)
(require 'feigo-tab-key-config)
(require 'color-moccur-setting)

(require 'color-theme)
;(color-theme-dark-laptop)

(if (string-match "Aquamacs" (emacs-version)) 
  (color-theme-jsc-light2)
  (color-theme-clarity)
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

(require 'recent-jump-settings)



(require 'multiple-cursors)
(global-set-key (kbd "C-.")     'mc/mark-next-like-this)
(global-set-key (kbd "C-,")     'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-.") 'mc/mark-all-like-this)
(global-set-key (kbd "S-SPC")   'set-rectangular-region-anchor)
(global-set-key (kbd "C-c m e")   'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c m a")   'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-c m m") 'mc/edit-lines)

(global-set-key (kbd "C-c m n")   'mc/mark-next-lines)
(global-set-key (kbd "C-c m p")   'mc/mark-previous-lines)

(global-set-key (kbd "C-c m s")   'mc/mark-all-symbols-like-this)
(global-set-key (kbd "C-c m w")   'mc/mark-all-words-like-this)
(global-set-key (kbd "C-c m t")   'mc/mark-more-like-this-extended)


(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
 (autoload
   'ace-jump-mode
   "ace-jump-mode"
   "Emacs quick move minor mode"
   t)
 ;; you can select the key you prefer to
 (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

 (autoload
   'ace-jump-mode-pop-mark
   "ace-jump-mode"
   "Ace jump back:-)"
   t)
 (eval-after-load "ace-jump-mode"
   '(ace-jump-mode-enable-mark-sync))
 (define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)


;(require 'smooth-scrolling)
;(setq smooth-scroll-margin 5)

;(set-frame-font "-apple-WenQuanYi_Micro_Hei_Mono-medium-normal-normal-*-14-*-*-*-m-0-iso10646-1")

;
;;; define extra C types to font-lock
;(setq c-font-lock-extra-types
;      (append
;       '("BOOL" "BSTR" "LPC?\\(W\\|T\\|OLE\\)?\\STR" "HRESULT"
;         "BYTE" "DWORD" "SOCKET" "idl_char"
;         "idl_boolean" "idl_byte" "idl_\\(short\\|long\\)_float"
;         "idl_u?\\(small\\|short\\|long\\)_int"
;         "boolean32" "unsigned\\(32\\|16\\)"
;         "SAFEARRAY" "boolean" "UINT" "ULONG" "CDialog")
;       c-font-lock-extra-types))
;
;;; define extra C++ types to font-lock
;(setq c++-font-lock-extra-types
;      (append
;       c-font-lock-extra-types
;       c++-font-lock-extra-types))
;

(require 'generic-x)


(provide 'emacs-base-config)
