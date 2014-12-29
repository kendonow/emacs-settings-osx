(require '08-cmake)
(message "08-cmake")


(require 'quickrun)

(require 'emms-config)
(message "emms-config")

(custom-set-faces '(mode-line-highlight ((t nil))) 
                  '(mode-line ((t (:foreground "red" 
                                               :background "blue4")))) 
                  '(mode-line-inactive ((t (:background "gray24" 
                                                        :foreground "green")))))

(message "08-extend")

(require '08-window-numbering-setting)

(require '08-register-channel-setting)

(require 'graphviz-dot-mode-setting )


(require 'linum-relative)
(linum-on)

;; (require 'relative-linum)

;; require 'highlight-sexp)
;; (add-hook 'lisp-mode-hook 'highlight-sexp-mode)
;; (add-hook 'emacs-lisp-mode-hook 'highlight-sexp-mode)

;;  (require 'key-combo)
;;  (key-combo-mode 1)
;; ;;
;; ;;
;; ;;

;; ;; (key-combo-define-global (kbd "=") '(" = " " == " " === " ))
;; ;;   (key-combo-define-global (kbd "C-f") '(forward-char forward-word end-of-line key-combo-return))
;; ;;   (key-combo-define-global (kbd "C-p") '(previous-line scroll-down-command beginning-of-buffer key-combo-return))
;; ;;   ;; (key-combo-define-global (kbd "C-n") '(next-line scroll-up-command  end-of-buffer key-combo-return))

;; ;;
;; ;; or load default settings
;; ;;
;;  (key-combo-load-default)

;; (require 'workgroups2)

;; ;; Change prefix key (before activating WG)
;; (setq wg-prefix-key (kbd "C-c z"))

;; ;; Change workgroups session file
;; (setq wg-session-file "~/.emacs.d/.emacs_workgroups")

;; ;; Set your own keyboard shortcuts to reload/save/switch WG:
;; (global-set-key (kbd "<pause>")     'wg-reload-session)
;; (global-set-key (kbd "C-S-<pause>") 'wg-save-session)
;; (global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
;; (global-set-key (kbd "s-/")         'wg-switch-to-previous-workgroup)


;; (require 'column-enforce-mode)

;; (column-enforce-mode 1)
;; (add-to-list 'load-path "/emacs-setting/git-emacs/")


;; (require 'git-emacs)

(require 'magit-key-mode)
;; (global-set-key (kbd "C-x g m")         'magit-status)
(global-set-key (kbd "C-x v m")         'magit-status)

;; (require 'git-gutter-config)
(require 'git-gutter-config+)

;; (require 'git-messenger) 
;; (global-set-key (kbd "C-x v o") 'git-messenger:popup-message)
;; (define-key git-messenger-map (kbd "m") 'git-messenger:copy-message)
;; (add-hook 'git-messenger:popup-buffer-hook 'magit-commit-mode)


;; magit-key-mode-prefix
;; (setq magit-key-mode-prefix (kbd "C-x g"))

;; (require 'magit)

;; (require 'simplenote)
;; (setq simplenote-email "zhsfei.zj@gmail.com")
;; (setq simplenote-password nil)
;; (simplenote-setup)

(require '99-load-manual)

;; ;; 函数头注释
;; (define-skeleton skeleton-c-mode-functioncomment-func
;;   "generate function comment automatic" nil
;;   "/*********************************
;; * Function Name :
;; * Function description :
;; * Author: jensonhjt
;; * Input parameter:
;; *
;; * Return value:
;; *
;; *
;; *********************************/"
;;   > _  "" > ""
;;   )
;; (define-abbrev-table 'c-mode-abbrev-table '(
;;     ("fc" "" skeleton-c-mode-functioncomment-func 1)
;;     ))
;; (define-abbrev-table 'c++-mode-abbrev-table '(
;;     ("fc" "" skeleton-c-mode-functioncomment-func 1)
;;     ))

(require 'sos)


;; (require 'dired-toggle)
(require 'reveal-in-finder)


;; (add-to-list 'align-rules-list
;;              '(c-assignment1
;;                (regexp . "[=;]\\(\\s-*\\)")
;;                (mode   . '(c-mode))
;;                (repeat . t)))


;; align-regexp

;;  [^ ]+\((\|;\)

;; (setq mode-line-format
;;           (list
;;            ;; value of `mode-name'
;;            "%m: "
;;            ;; value of current buffer name
;;            "buffer %b, "
;;            ;; value of current line number
;;            "line %l "
;;            "-- user: "
;;            ;; value of user
;;            (getenv "USER")))
(setq-default mode-line-format (list

                                ;; the buffer name; the file name as a tool tip
                                " " '(:eval (propertize "%b " 'face 'font-lock-keyword-face
                                                        'help-echo (buffer-file-name)))

                                ;; line and column
                                "(" (propertize "%l" 'face 'font-lock-type-face) "," (propertize
                                                                                      "%c" 'face
                                                                                      'font-lock-type-face)
                                ") "

                                ;; '(multiple-cursors-mode mc/mode-line)
                                '(multiple-cursors-mode ("\|-" (:eval (format #("%d" 0 2 (face
                                                                                          font-lock-comment-face)) 
                                                                              (mc/num-cursors)))
                                                         "-\|"))


                                ;; relative position, size of file
                                "[" (propertize "%p" 'face 'font-lock-constant-face) "/" (propertize
                                                                                          "%I" 'face
                                                                                          'font-lock-constant-face)
                                "] "

                                ;; add the time, with the date and the emacs uptime in the tooltip
                                " ("'(:eval (propertize (format-time-string "%H:%M") 'face
                                                        'font-lock-comment-face 'help-echo (concat
                                                                                            (format-time-string
                                                                                             "%c; ") 
                                                                                            (emacs-uptime
                                                                                             "Uptime:%hh"))))
                                " ) "


                                ;; the current major mode for the buffer.
                                "[" '(:eval (propertize "%m" 'face 'font-lock-string-face 'help-echo
                                                        buffer-file-coding-system)) "] " "[" ;; insert vs overwrite mode, input-method in a tooltip
                                                        '(:eval (propertize 
                                                                 (if overwrite-mode 
                                                                     "Ovr"
                                                                   "Ins")
                                                                 'face 'font-lock-preprocessor-face
                                                                 'help-echo (concat "Buffer is in " 
                                                                                    (if
                                                                                        overwrite-mode 
                                                                                        "overwrite"
                                                                                      "insert")
                                                                                    " mode")))

                                                        ;; was this buffer modified since the last save?
                                                        '(:eval (when (buffer-modified-p) 
                                                                  (concat ","  (propertize "Mod"
                                                                                           'face
                                                                                           'font-lock-warning-face
                                                                                           'help-echo
                                                                                           "Buffer has been modified"))))

                                                        ;; is this buffer read-only?
                                                        '(:eval (when buffer-read-only 
                                                                  (concat ","  (propertize "RO"
                                                                                           'face
                                                                                           'font-lock-type-face
                                                                                           'help-echo
                                                                                           "Buffer is read-only")))) "] " "%-" ;; fill with '-'
                                                                  ))


;; (setq-default mode-line-format '("%e" mode-line-front-space
;;                                  ;; Standard info about the current buffer
;;                                  mode-line-mule-info mode-line-client mode-line-modified
;;                                  ;; mode-line-remote
;;                                  mode-line-frame-identification mode-line-buffer-identification " "
;;                                  mode-line-position
;;                                  ;; Some specific information about the current buffer:
;;                                  ;; lunaryorn-projectile-mode-line ; Project information
;;                                  ;; (vc-mode lunaryorn-vc-mode-line) ; VC information
;;                                  ;; (flycheck-mode flycheck-mode-line) ; Flycheck status
;;                                  (multiple-cursors-mode mc/mode-line) ; Number of cursors
;;                                  ;; Misc information, notably battery state and function name
;;                                  " " mode-line-misc-info
;;                                  ;; And the modes, which I don't really care for anyway
;;                                  " " mode-line-modes mode-line-end-spaces))



;; (require 'plantuml-mode)
;; (require 'plantuml-config )

;; (add-to-list 'auto-mode-alist '("\\.uml$" . plantuml-mode))

;; (require 'narrow-indirect)


;;   (define-key ctl-x-4-map "nd" 'ni-narrow-to-defun-indirect-other-window)
;;   (define-key ctl-x-4-map "nn" 'ni-narrow-to-region-indirect-other-window)
;;   (define-key ctl-x-4-map "np" 'ni-narrow-to-page-indirect-other-window)

;; (require 'narrow-indirect )
;; (global-set-key (kbd "C-x n D") 'narrow-to-defun-indirect)
;; (global-set-key (kbd "C-x n N") 'narrow-to-region-indirect)
;; (global-set-key (kbd "C-x n W") 'widen-indirect)



(require 'comment-dwim-2)
(global-set-key (kbd "M-;") 'comment-dwim-2)


;; (require 'hilit-chg)

;; (global-highlight-changes-mode 1)

;; ;; (custom-set-faces '(highlight-changes ((t (:inherit nil
;; ;;                                                       :italic t :underline t
;; ;;                                                     ))))
;; ;;                   )

;; (custom-set-faces
;;  '(highlight-changes ((t (:italic t ))))
;; )


;; (custom-set-faces '(highlight-changes ((t (:inherit nil
;;                                                     :background "gray26"  :italic t :underline t
;;                                                     :foreground "#00ff7f"))))
;;                   )

;; '(highlight-changes ((t (:inherit nil :background "orange4" :foreground "green" ))))
;; (custom-set-faces    '(highlight-changes-faces (t  (:background "khaki" :foreground "black")))
;; )

;; (custom-set-faces
;;  '(mode-line-highlight ((t nil)))
;;  '(mode-line ((t (:foreground "red" :background "blue4"))))
;;  '(mode-line-inactive ((t (:background "gray24" :foreground "green")))))

;; (add-hook 'write-file-functions 'highlight-changes-rotate-faces nil t)

;; (global-set-key (kbd "C-z ,") 'highlight-changes-next-change)
;; (global-set-key (kbd "C-z .") 'highlight-changes-previous-change)



(defun my-key-dict-hook () 
  (interactive ) 
  (define-key srecode-template-mode-map "\C-cd" 'dictionary-buffer) 
  (define-key srecode-template-mode-map "\C-cw" 
    '(lambda () 
       (interactive) 
       (dictionary-buffer 1))))

(add-hook 'srecode-template-mode-hook 'my-key-dict-hook)
;; (add-hook 'feigo-study-en-mode-hook 'my-key-dict-hook)


;; (require 'dired-hacks-utils)
(require 'dired-filter)
(require 'dired-narrow)


;; (require 'popup-kill-ring)
(require 'wgrep-ag)
(require 'wgrep-ack)
(require 'wgrep-helm)
(setq wgrep-auto-save-buffer t)

(require 'breadcrumb-config)
;; (setq bc-bookmark-file (expand-file-name "~/.emacs.d/bookmarks"))

;; (require 'simplenote)
;; (setq simplenote-email "zhsfei.zj@gmail.com")
;; (setq simplenote-password "")
;; (simplenote-setup)
;; (require 'simplenote-auto-sync-mode)
;; (global-simplenote-auto-sync-mode 1)



;; (require 'fingers)

;; (require 'fingers-qwerty)
;; (setq fingers-region-specifiers fingers-qwerty-region-specifiers)
;; (setq fingers-keyboard-layout-mapper 'fingers-workman-to-qwerty)
;; (fingers-reset-bindings)


;; (defun fingers-mode-visual-toggle ()
;;   (let ((faces-to-toggle '(mode-line mode-line-inactive))
;;         (enabled-color   "#e8e8e8")
;;         (disabled-color   "#a1b56c"))
;;     (cond (fingers-mode
;;            (mapcar (lambda (face) (set-face-background face enabled-color))
;;                    faces-to-toggle))
;;           (t
;;            (mapcar (lambda (face) (set-face-background face disabled-color))
;;                    faces-to-toggle)))))

;; (add-hook 'fingers-mode-hook 'fingers-mode-visual-toggle)

;; (defun eshell-send-input-zAp (&optional use-region queue-p no-newline)
;;   "A customized `eshell-send-input`, to add bm-bookmark to prompt line"
;;   (interactive)
;;   (let ((line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
;;     (if (string-match eshell-prompt-regexp line)
;;         (if (> (length (substring line (match-end 0))) 0)
;;             (bm-bookmark-add))))
;;   (eshell-send-input use-region queue-p no-newline))

;; (require 'egg)
;; (setq egg-auto-update t)
;; (setq egg-switch-to-buffer t)
;; (custom-set-variables
;;   '(egg-mode-key-prefix "C-c v"))



  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
  (guide-key-mode 1) ; Enable guide-key-mode
  (setq guide-key/guide-key-sequence t)

  (setq guide-key/highlight-command-regexp
        '("rectangle"
          ("register" . font-lock-type-face)
          ("bookmark" . font-lock-warning-face)))


(provide '08-extend)
