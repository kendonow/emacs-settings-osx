
(if (eq system-type 'windows-nt) 
    nil
  (push "/usr/local/bin" exec-path)

                                        ;  (progn (setenv "PATH" (concat "/usr/local/bin/" path-separator (getenv "PATH")))
                                        ;         (setenv "PATH" (concat "/usr/local/texlive/2011/bin/universal-darwin" path-separator (getenv "PATH")))
                                        ;         )
  )


;; (setq exec-path (append exec-path '("/usr/local/bin")))

                                        ;just for latex when shell
                                        ;(if (eq window-system 'mac)
                                        ;   (add-to-list 'exec-path "/usr/local/texlive/2011/bin/universal-darwin")
                                        ;)
                                        ;
(setq backup-directory-alist (quote (("." . "~/.backups"))))

(global-linum-mode 1)



                                        ;(set-cursor-color "Blue")
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
                                        ;(scroll-bar-mode -1)
                                        ;(tool-bar-mode -1)
                                        ;(blink-cursor-mode t)
                                        ;(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
                                        ;(tooltip-mode -1)


                                        ;(load-theme 'tango)
                                        ;(setq default-frame-alist
                                        ;'((height . 42) (width . 72))
                                        ;)
                                        ;
                                        ;(column-number-mode)



(setq user-full-name "feigo.zj")

;; (setq scroll-step 2
;;     scroll-margin 1
;;    scroll-conservatively 10000)



(global-auto-revert-mode 1)


;; CHINESE-GBK settings

;;
;;
                                        ;(message "chinese-gbk")
                                        ;(set-language-environment 'Chinese-GB)
                                        ;(setq-default pathname-coding-system 'euc-cn)
                                        ;(setq file-name-coding-system 'euc-cn)

;; (prefer-coding-system 'utf-8)

;; (set-language-environment "chinese-gbk")
;; (set-terminal-coding-system 'chinese-gbk)
;; (set-keyboard-coding-system 'chinese-gbk)
;; (set-clipboard-coding-system 'chinese-gbk)
;; (set-buffer-file-coding-system 'chinese-gbk)
;; (set-selection-coding-system 'chinese-gbk)

;; (modify-coding-system-alist 'process "*" 'chinese-gbk)



;; (require 'un-define)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

;;
;; (setq mac-command-modifier 'meta)
                                        ; (setq mac-option-modifier 'control)
(setq mac-option-modifier 'meta)

                                        ;(setq-default cursor-type 'bar)
(setq-default cursor-type 'box)


                                        ;(require 'browse-kill-ring+)
                                        ;(browse-kill-ring-default-keybindings)


(require 'recent-jump)
;; set recent-jump
(setq recent-jump-threshold 4)
(setq recent-jump-ring-length 200)


                                        ;(require 'highlight-symbol)
                                        ;
                                        ;
                                        ;(require 'hl-line)
                                        ;赂脽脕脕碌卤脟掳脨脨
(global-hl-line-mode 1)


;; (require 'hl-spotlight)
;; (hl-spotlight-mode 1)
;; ;; list-color-display
;; (set-face-background 'hl-line "RoyalBlue4")
;; (setq hl-spotlight-height 1)


(require 'key-multiple-cursors)





                                        ; inhabi
                                        ;inhibit  message for C-x C-l and C-x C-u
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
                                        ;(setq default-directory "~/Work/supconit/")



                                        ;(require 'ido)
                                        ;(ido-mode t)

;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)
;; (setq ido-auto-merge-work-directories-length -1)



(setq-default kill-whole-line t)
(setq kill-ring-max 200)

(setq x-select-enable-clipboard t)




;; 此处与helm 很卡 有关系，但不知道什么原因，注销掉这行就不卡了，??
;; (setq default-truncate-lines t)
;; (setq default-truncate-lines nil)

;; (set-default 'truncate-lines t)
(setq truncate-lines nil)

;; make side by side buffers function the same as the main window
;; (setq truncate-partial-width-windows nil)



                                        ;(require 'copy)
                                        ;(require 'cut)

                                        ;(require 'thing-edit)


;; (global-set-key [(control x)(k)] 'kill-this-buffer)
;; (global-set-key [(control x)(control k)] 'kill-buffer)


(require 'linum)
(setq linum-format "%3d ")


(require 'rect-mark)
(require 'rect-extension)
(require  'rect-replace)




;;(setq bm-restore-repository-on-load t)
(require 'bm-ext)
;;
;;(add-hook' after-init-hook 'bm-repository-load)
;;(add-hook 'find-file-hooks 'bm-buffer-restore)
;;(add-hook 'kill-buffer-hook 'bm-buffer-save)
;;(add-hook 'kill-emacs-hook '(lambda nil
;;                              (bm-buffer-save-all)
;;                              (bm-repository-save)))
;;;;
;;;;   ;; Update bookmark repository when saving the file.
;;(add-hook 'after-save-hook 'bm-buffer-save)
;;;;
;;;;   ;; Restore bookmarks when buffer is reverted.
;;(add-hook 'after-revert-hook 'bm-buffer-restore)
;;(setq bm-buffer-persistence t)
;;



(tool-bar-mode -1)
(scroll-bar-mode -1)


                                        ;(require 'my_windmove)
                                        ;(require 'buffer-move)


;; (require 'key-ascope)


;; (setq auto-mode-alist
;;       (cons '("\\.odl$" . idl-mode)
;; 	    auto-mode-alist))

;; (setq auto-mode-alist
;;       (cons '("\\.idl$" . idl-mode)
;; 	    auto-mode-alist))

;;    (add-hook 'c-mode-common-hook 'google-set-c-style)


;;(global-set-key "%" 'match-paren)

;;(defun match-paren (arg)
;;  "Go to the matching paren if on a paren; otherwise insert %."
;;  (interactive "p")
;;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;; ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;; (t (self-insert-command (or arg 1)))))
;;
;;

;;(defun my-match-paren (arg)
;;  "Press % to jump to matching paren -- lgfang"
;;  (interactive "p")
;;  (cond ((looking-at "[([{]") (forward-sexp) (backward-char))
;;        ((looking-at "[])}]") (forward-char) (backward-sexp))
;;        (t (self-insert-command (or arg 1)))))
;;(define-key global-map "%" 'my-match-paren)
;;


                                        ;卤锚脤芒脌赂脧脭脢戮脦脛录镁脗路戮露
(setq frame-title-format '("%S" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

                                        ;鲁脡露脭脧脭脢戮脌篓潞脜,碌芦虏禄脌麓禄脴碌炉脤酶 (show-paren-mode t)
                                        ;(setq show-paren-style 'parentheses)

                                        ;脣脩脣梅鹿芒卤锚脧脗脳脰路没麓庐

(defun my-isearch-yank-word-or-char-from-beginning () 
  "Move to beginning of word before yanking word in isearch-mode." 
  (interactive)
  ;; Making this work after a search string is entered by user
  ;; is too hard to do, so work only when search string is empty.
  (if (= 0 (length isearch-string)) 
      (beginning-of-thing 'word)) 
  (isearch-yank-word-or-char)
  ;; Revert to 'isearch-yank-word-or-char for subsequent calls
  (substitute-key-definition 'my-isearch-yank-word-or-char-from-beginning 'isearch-yank-word-or-char
                             isearch-mode-map))



(add-hook 'isearch-mode-hook 
          (lambda () 
            "Activate my customized Isearch word yank command."
            (substitute-key-definition 'isearch-yank-word-or-char
                                       'my-isearch-yank-word-or-char-from-beginning
                                       isearch-mode-map)))






                                        ;
                                        ;(setq hs-minor-mode-map
                                        ;  (let ((map (make-sparse-keymap)))
                                        ;    ;; These bindings roughly imitate those used by Outline mode.
                                        ;    (define-key map "\C-c2h"	      'hs-hide-block)
                                        ;    (define-key map "\C-c2s"	      'hs-show-block)
                                        ;    (define-key map "\C-c2\C-h"    'hs-hide-all)
                                        ;    (define-key map "\C-c2\C-s"    'hs-show-all)
                                        ;    (define-key map "\C-c2\C-l"	      'hs-hide-level)
                                        ;    (define-key map "\C-c2\C-c"	      'hs-toggle-hiding)
                                        ;    (define-key map [(shift mouse-2)] 'hs-mouse-toggle-hiding)
                                        ;    map)
                                        ;  "Keymap for hideshow minor mode.")
                                        ;

                                        ;(require 'session)
                                        ;(add-hook 'after-init-hook 'session-initialize)

                                        ; (defun my-activate-ctypes () (require 'ctypes))
                                        ;
                                        ; (add-hook 'c-mode-hook 'my-activate-ctypes)
                                        ; (add-hook 'c++-mode-hook 'my-activate-ctypes)
                                        ;



;; (require 'inline-string-rectangle)
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)


;; (autoload
;;   'ace-jump-mode
;;   "ace-jump-mode"
;;   "Emacs quick move minor mode"
;;   t)
;; ;; you can select the key you prefer to
;; (define-key global-map (kbd "C-c j") 'ace-jump-mode)

;; (autoload
;;   'ace-jump-mode-pop-mark
;;   "ace-jump-mode"
;;   "Ace jump back:-)"
;;   t)
;; (eval-after-load "ace-jump-mode"
;;   '(ace-jump-mode-enable-mark-sync))

;; (define-key global-map (kbd "C-c k") 'ace-jump-mode-pop-mark)




;; (require 'smooth-scrolling)
                                        ;(setq smooth-scroll-margin 3)


                                        ;(require 'key-chord-config)


;; (require 'cal-china-x)
;; (setq mark-holidays-in-calendar t)
;; (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
;; (setq calendar-holidays cal-china-x-important-holidays)

;; (setq christian-holidays nil) ;; 不显示基督教的节日
;; (setq hebrew-holidays nil)    ;; 不显示希伯来人的节日
;; (setq islamic-holidays nil)   ;; 不显示伊斯兰教的节日




;; (require 'easy-bookmark)
;; (require 'bookmark+)
;; (require 'key-bookmark-plus)


;; (require 'diredful)



(defun concat-string-list (list) 
   "Return a string which is a concatenation of all elements of the list separated by spaces" 
    (mapconcat '(lambda (obj) (format "%s" obj)) list " "))


;; (require 'ee-autoloads)
;; (require 'ifind-mode)


;; (require 'ggtags)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'undo-tree)
(global-undo-tree-mode 1)

;; (require 'feigo-function)
(defun undo-tree-redo/repeat ()
  (interactive)
  (feigo-repeat-command 'undo-tree-redo)
  )



(global-set-key (kbd "C-x /") 'undo-tree-redo/repeat)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'smex)


;;                                         ;; (require 'evil)


                                        ;(evil-mode 1)

(require 'toggle-split)





;; (require 'recentf)
;; (recentf-mode 1)

(require 'dired-setting)



;; (require 'visual-regexp)

;; (define-key global-map (kbd "C-c r") 'vr/replace)
;; (define-key global-map (kbd "C-c q") 'vr/query-replace)


(set-face-attribute 'default nil 
                    :height 150 
                    :bold nil)



(define-key minibuffer-local-map "\C-k" 'delete-minibuffer-contents)
(define-key minibuffer-local-map "\C-a" 'move-beginning-of-line)


(require 'uniquify)

(setq uniquify-buffer-name-style 'forward)

;; 解决 shell中文乱码问题
(ansi-color-for-comint-mode-on)
;; (setq ansi-color-for-comint-mode t)
;; (message "01-common-setting")
(provide '01-common-setting)
