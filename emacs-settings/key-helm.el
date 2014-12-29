


                                        ;;(add-to-list 'load-path "~/emacs-setting/helm/")
;; (add-to-list 'load-path "~/emacs-setting/helm-13-12-9/")
;; (add-to-list 'load-path "~/emacs-setting/helm-1.5.7/")
;; (add-to-list 'load-path "~/emacs-setting/helm-1.5.9/")
; (add-to-list 'load-path "~/emacs-setting/helm-1.6.0/")
;; (add-to-list 'load-path "~/emacs-setting/helm-1.6.3/")

;; (add-to-list 'load-path "~/emacs-setting/helm-13-12-19/")
;; (add-to-list 'load-path "~/emacs-setting/helm-extend/")
(require 'helm-mode)
(require 'helm-config)

(require 'helm-descbinds)
(helm-descbinds-mode 1 )


(require 'color-moccur)

(setq moccur-split-word t)


;; (require 'helm-c-moccur)

;; (setq helm-c-moccur-enable-initial-pattern t)
(helm-mode 1)



;;----------------------------------------

(define-key global-map "\M-q" 'quoted-insert)
                                        ;(define-key global-map "\C-q\M-q" 'quoted-insert)
;; (global-set-key (kbd "C-c n") 'helm-mini)


;;----------------------------------------

(setq helm-split-window-default-side 'right)
(setq helm-split-window-in-side-p nil)

(setq helm-always-two-windows t)

(setq helm-full-frame nil)

;;----------------------------------------
(defun init-input-prefix (&optional prefix) 
  (if prefix 
      ""
    (thing-at-point 'symbol)))


;; (defun helm-previous-line-extend (&optional arg) 
;;   "Move selection to the previous line." 
;;   (interactive "p") 
;;   (helm-previous-line arg) 
;;   (helm-execute-persistent-action))

;; (defun helm-next-line-extend (&optional arg) 
;;   "Move selection to the previous line." 
;;   (interactive "p") 
;;   (helm-next-line arg) 
;;   (helm-execute-persistent-action))


;; (add-hook 'helm-before-initialize-hook
;;           #'(lambda () (helm-attrset 'follow 1 helm-source-buffers-list)))


(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

;; (define-key helm-moccur-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
;; (define-key helm-moccur-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
;; (define-key helm-moccur-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

;; (define-key helm-moccur-map (kbd "C-p")        'helm-previous-line-extend)
;; (define-key helm-moccur-map (kbd "C-n")        'helm-next-line-extend)

(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

(require 'helm-imenu)


;;;###autoload
;; (defun my-helm-occur (&optional prefix) 
;;   "Preconfigured helm for Occur." 
;;   (interactive "P") 
;;   (setq helm-multi-occur-buffer-list (list (buffer-name (current-buffer)))) 
;;   (helm-occur-init-source) 
;;   (helm-attrset 'name "Occur" helm-source-occur)
;;   ;; (if prefix

;;   ;; )
;;   (helm :sources 'helm-source-occur 
;;         :buffer "*helm occur*" 
;;         :history 'helm-grep-history 
;;         :truncate-lines t
;;         ;; :keymap my-helm-occur-map
;;         ;; :input initial-input
;;         :input (init-input-prefix prefix)

;;         ;; :input (thing-at-point 'symbol)
;;         ))


;; (remove-hook 'helm-before-initialize-hook
;;           #'(lambda () (helm-attrset 'follow 1 helm-source-buffers-list)))

;; (add-hook 'helm-before-initialize-hook
;;           #'(lambda () (helm-attrset 'follow 1 helm-source-occur)))




(defun my-helm-occur ()
  "Preconfigured helm for Occur."
  (interactive)
  (helm-occur-init-source)
  (let ((bufs (list (buffer-name (current-buffer)))))
    (helm-attrset 'moccur-buffers bufs helm-source-occur)
    (helm-set-local-variable 'helm-multi-occur-buffer-list bufs)
    (helm-set-local-variable
     'helm-multi-occur-buffer-tick
     (cl-loop for b in bufs
              collect (buffer-chars-modified-tick (get-buffer b)))))
  (helm :sources 'helm-source-occur
        :buffer "*helm occur*"
        :history 'helm-grep-history
        :input (init-input-prefix )
        ;; :follow t
        :preselect (and (memq 'helm-source-occur helm-sources-using-default-as-input)
                        (format "%s:%d:" (buffer-name) (line-number-at-pos (point))))
        :truncate-lines t))


;; (defun my-helm-c-moccur-occur-by-moccur (&optional prefix)
;;   (interactive "P")
;;   ;; (if prefix
;;       ;; (helm-c-moccur-resume)
;;     (helm-c-moccur-occur-by-moccur-base
;;      (if prefix;helm-c-moccur-enable-initial-pattern
;;         ""
;;        (regexp-quote (or (thing-at-point 'symbol) ""))
;;        )))




;; (defun helm-yank-text-at-point ()
;;   "Yank the symbol from the window before entering the minibuffer."
;;   (interactive)
;;   (let ((symbol (and (minibuffer-selected-window)
;;                      (with-current-buffer
;;                          (window-buffer (minibuffer-selected-window))
;;                        (thing-at-point 'symbol)))))
;;     (if symbol (insert symbol)
;;       (minibuffer-message "No symbol found"))))



(setq helm-candidate-number-limit 199)

;; (global-set-key "\C-z" helm-command-prefix)
(global-set-key "\C-q" helm-command-prefix)




(require 'helm-ag)
(setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
(setq helm-ag-command-option "--all-text")
(setq helm-ag-thing-at-point 'symbol)


(setq helm-command-map 
      (let ( (map helm-command-map) ) 
        (define-key map (kbd "p"   ) 'my-helm-occur            )

        (define-key map (kbd "o"   ) 'helm-swoop            )
        ;; (define-key map (kbd "o"   )    'my-helm-c-moccur-occur-by-moccur )
        ;; (define-key map (kbd "9"   ) (lambda () (interactive )  (my-helm-c-moccur-occur-by-moccur t)))
        ;; (define-key map (kbd "i"   ) (lambda () (interactive )  (my-helm-c-moccur-occur-by-moccur t)))
        ;; (define-key map (kbd "C-o"   ) (lambda () (interactive )  (my-helm-occur t)))

        ;; (define-key map (kbd "o"   ) 'helm-c-moccur-occur-by-moccur )
        (define-key map (kbd "r"   )    'helm-recentf          ) 
        (define-key map (kbd "y"   )    'helm-show-kill-ring   )
        ;; (define-key map (kbd "t")       'helm-yas-complete)
        ;; (define-key map (kbd "y"   )    'helm-yas-complete   )
        ;; (define-key map (kbd "b"   )    'helm-buffers-list           ) 
        ;; (define-key map (kbd "b"   )    'switch-to-buffer           ) 
        (define-key map (kbd "x"   )    'helm-M-x              ) 
        (define-key map (kbd "g"   )    'helm-do-grep          ) 
        ;; (define-key map (kbd "C-d"   )  'dmoccur               )
        ;; (define-key map (kbd "d"   )    'helm-c-moccur-dmoccur)
        (define-key map (kbd "m"   )    'helm-mark-ring       ) 
        ;; (define-key map (kbd "d"   )    'helm-dabbrev       )
        (define-key map (kbd "d"   )    'helm-descbinds       )

        ;; (define-key map (kbd "C-s" )    'moccur-display-buffer )
        ;; (define-key map (kbd "s" )   'moccur )
        ;; (define-key map (kbd "s" )      'helm-swap-windows )
        ;; (define-key map (kbd "C-s" ) 'helm- )
        ;; (define-key map (kbd "d" ) 'helm-dabbrev )
        ;; helm
        (define-key map (kbd "C-q"   )  'helm-resume           )
        ;; (define-key map (kbd "l"   ) 'helm-bookmarks           )
        (define-key map (kbd "l")       'helm-pp-bookmarks)
        ;; (define-key map (kbd "h")    'helm-eshell-history)
        (define-key map (kbd "h")       'helm-dired-history-view) 
        (define-key map (kbd "i")       'helm-imenu) 
        ;; (define-key map (kbd "j")       'helm-imenu)
        ;; (define-key map (kbd "a")       'helm-all-mark-rings) 
        (define-key map (kbd "a")       'helm-ag) 
        ;; (define-key map (kbd "C-f")     'helm-for-files) 
        (define-key map (kbd "f")       'helm-find-files)
        ;; (define-key map (kbd "j")       'helm-locate)
        (define-key map (kbd "e")       'helm-gtags-find-tag)
        ;; (define-key map (kbd "h")       'helm-minibuffer-history)
        ;; (define-key map (kbd "C-e")     'helm-gtags-find-rtag)
        map))
;; hel
;; (define-key isearch-mode-map "\C-q" 'helm-c-moccur-from-isearch)

;; (global-set-key (kbd "C-x b") 'ibuffer)
;; (global-set-key (kbd "C-c y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c y") 'helm-yas-complete)


;; ;; (global-set-key (kbd "M-o") 'helm-c-moccur-occur-by-moccur)
;; ;; (global-set-key (kbd "C-M-o") 'helm-c-moccur-dmoccur)
;; (add-hook 'dired-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "O") 'helm-c-moccur-dired-do-moccur-by-moccur)))


;; (global-set-key (kbd "C-M-s") 'helm-c-moccur-isearch-forward)
;; (global-set-key (kbd "C-M-r") 'helm-c-moccur-isearch-backward)





;; (require 'helm-gtags)


;; (setq helm-gtags-local-directory "~/Qt5.1.1/5.1.1/clang_64/include/")


;; ;;; Enable helm-gtags-mode
;; (add-hook 'c-mode-hook 'helm-gtags-mode)
;; (add-hook 'c++-mode-hook 'helm-gtags-mode)
;; ;; (add-hook 'asm-mode-hook 'helm-gtags-mode)

;; ;; customize
;; (custom-set-variables
;;  '(helm-gtags-path-style 'relative)
;;  '(helm-gtags-ignore-case t)
;;  '(helm-gtags-auto-update t))

;; ;; key bindings
;; (eval-after-load "helm-gtags"
;;   '(progn
;;      (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
;;      (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
;;      (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
;;      (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
;;      (define-key helm-gtags-mode-map (kbd "C-c ,") 'helm-gtags-previous-history)
;;      (define-key helm-gtags-mode-map (kbd "C-c .") 'helm-gtags-next-history)
;;      ;; (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
;; ))




;; (require 'helm-etags+)

;; (require 'etags-table)

;; ;; (setq etags-table-alist
;; ;;       (list
;; ;;        '("~/qt_project/06-hmi/sciDrawDemo/.*\\.[cpph]$" "~/qt_project/06-hmi/sciDrawDemo/TAGS")
;; ;;        ;; '("/tmp/.*\\.c$"  "/java/tags/linux.tag" "/tmp/TAGS" )
;; ;;        ;; '(".*\\.java$"  "/opt/sun-jdk-1.6.0.22/src/TAGS" )
;; ;;        ;; '(".*\\.[ch]$"  "/java/tags/linux.ctags")
;; ;;        ))

;; (setq etags-table-alist
;;       (list
;;        ;; For jumping to standard headers:
;;        ;; '(".*\\.\\([ch]\\|cpp\\)" "~/qt_project/06-hmi/sciDrawDemo/TAGS")
;;        '("~/qt_project/06-hmi/sciDrawDemo/" "~/qt_project/06-hmi/sciDrawDemo/TAGS")
;;        ;; For jumping across project:
;;        ;; '("/home/devel/proj1/" "/home/devel/proj2/TAGS" "/home/devel/proj3/TAGS")
;;        ;; '("/home/devel/proj2/" "/home/devel/proj1/TAGS" "/home/devel/proj3/TAGS")
;;        ;; '("/home/devel/proj3/" "/home/devel/proj1/TAGS" "/home/devel/proj2/TAGS")
;;        ))

;; (add-hook 'helm-etags+-select-hook 'etags-table-recompute)


;; (global-set-key "\C-ci" 'helm-etags+-select)
;; (require 'etags-select)
;; (global-set-key "\M-." 'etags-select-find-tag)


;; (global-set-key "\C-c\C-i" 'helm-etags+-history-go-back)
;; (global-set-key "\C-cI" 'helm-etags+-history-go-back)

(require 'helm-gtags)
(setq helm-gtags-path-style 'root)
;; (setq helm-gtags-local-directory "~/Qt5.2.0/5.2.0/Src/")
(setq helm-gtags-local-directory nil)

;; (global-set-key "\C-ci" 'helm-gtags-find-tag)
;; (global-set-key "\C-ci" 'helm-gtags-find-tag-from-here)
;; (global-set-key "\C-c," 'helm-gtags-previous-history)
;; (global-set-key "\C-c." 'helm-gtags-next-history)

;; (require 'helm-ag)

;; (setq helm-ag-insert-at-point t)
;; (global-set-key "\C-c9" 'helm-ag)


;; (add-hook 'eshell-mode-hook
;;           #'(lambda ()
;;               (define-key eshell-mode-map
;;                 [remap pcomplete]
;;                 'helm-esh-pcomplete)
;;               (define-key eshell-mode-map
;;                 [remap eshell-pcomplete]
;;                 'helm-esh-pcomplete))
;; )

;; (add-hook 'eshell-mode-hook
;;           #'(lambda ()
;;               (define-key eshell-mode-map
;;                 (kbd "M-n")
;;                 'helm-eshell-history)))




;; (setq helm-c-locate-command "~/bin/everything %.0s %s")
;; (setq helm-c-locate-command "mdfind -onlyin ~/MetroView3_link %s %s")

;; (setq helm-for-files-preferred-list
;;   '(helm-source-buffers-list
;;     helm-source-buffer-not-found
;; ;    helm-source-recentf
;;     helm-source-bookmarks
;;     helm-source-file-cache
;; ;    helm-source-files-in-current-dir
;; ;    helm-source-locate
;;     helm-source-mac-spotlight))





(require 'savehist)
(add-to-list 'savehist-additional-variables 'helm-dired-history-variable)
(savehist-mode 1)
(eval-after-load 
    'dired 
  '(progn 
     (require 'helm-dired-history) 
     (define-key dired-mode-map "," 'helm-dired-history-view)))



;; (add-hook 'helm-grep-mode-hook
;;           '(lambda ()
;;              (define-key helm-grep-mode-map (kbd "n") 'helm-gm-next-file)
;;              (define-key helm-grep-mode-map (kbd "p")   'helm-gm-precedent-file)
;;              )
;; )

;; (add-hook 'helm-moccur-mode-hook
;;           '(lambda ()
;;              (define-key helm-moccur-mode-map (kbd "n") 'helm-gm-next-file)
;;              (define-key helm-moccur-mode-map (kbd "p")   'helm-gm-precedent-file)
;;              )
;; )





;; (defvar helm-grep-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "RET")      'helm-grep-mode-jump)
;;     (define-key map (kbd "C-o")      'helm-grep-mode-jump-other-window)
;;     (define-key map (kbd "q")        'helm-grep-mode-quit)
;;     (define-key map (kbd "<C-down>") 'helm-grep-mode-jump-other-window-forward)
;;     (define-key map (kbd "<C-up>")   'helm-grep-mode-jump-other-window-backward)
;;     (define-key map (kbd "<M-down>") 'helm-gm-next-file)
;;     (define-key map (kbd "<M-up>")   'helm-gm-precedent-file)
;;     map))




;; (require 'helm-gtags)

;; (add-hook 'helm-gtags-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
;;              (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
;;              (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
;;              (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
;;              (local-set-key (kbd "C-c C-f") 'helm-gtags-find-files)))

;; ;; (require 'helm-config)
;; (require 'helm-ack)


;; (setq helm-c-ack-version 2.02)
;; ;; Does not insert '--type' option
;; (setq helm-c-ack-auto-set-filetype nil)

;; ;; Insert "thing-at-point 'symbol" as search pattern
;; (setq helm-c-ack-thing-at-point 'symbol)




;; (add-to-list 'load-path "~/emacs-setting/helm-extend/helm-swoop/")
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)

;; (global-set-key (kbd "C-q o") 'helm-swoop)
;; (global-set-key (kbd "C-q k") 'helm-swoop-back-to-last-point)
;; (global-set-key (kbd "C-q [") 'helm-multi-swoop)
(setq helm-multi-swoop-edit-save t)

;; (setq helm-swoop-split-direction 'split-window-vertically)
(setq helm-swoop-split-direction 'split-window-horizontally)

(setq helm-swoop-speed-or-color t)
;; (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all

;; (add-to-list 'load-path "~/emacs-setting/helm-extend/helm-cmd-t/")
;; (require 'helm-C-x-b)
;;
;; (global-set-key [remap switch-to-buffer] 'helm-C-x-b)

(setq helm-ff-lynx-style-map nil helm-input-idle-delay 0.1 helm-idle-delay 0.1)

;;;###autoload
(defvar helm-source-same-mode-buffers-list)
(defvar helm-buffers-same-mode-list-cache nil)

(setq  helm-source-same-mode-buffers-list `((name . "same major mode Buffers") 
                                            (init . 
                                                  (lambda () 
                                                    (setq helm-buffers-same-mode-list-cache
                                                          (switch-current-major-mode-list))
                                                    ;; Issue #51 Create the list before `helm-buffer' creation.
                                                    )) 
                                            (candidates . helm-buffers-same-mode-list-cache) 
                                            (no-matchplugin) 
                                            (type . buffer) 
                                            (match . helm-files-match-only-basename)
                                            ;; (filtered-candidate-transformer . (lambda (candidates _source)
                                            ;;                                         (cl-loop for i in candidates
                                            ;;                                                  if helm-ff-transformer-show-only-basename
                                            ;;                                                  collect (cons (helm-basename i) i)
                                            ;;                                                  else collect i)))
                                            ;; (match helm-buffer-match-major-mode)
                                            ;; (match helm-buffer-match-major-mode)
                                            (persistent-action .
                                                               helm-buffers-list-persistent-action) 
                                            (keymap . ,helm-buffer-map) 
                                            (volatile) 
                                            (mode-line . helm-buffer-mode-line-string) 
                                            (persistent-help .
                                                             "Show this buffer / C-u \\[helm-execute-persistent-action]: Kill this buffer")))

(defun helm-buffers-list-and-dir () 
  "Preconfigured `helm' to list buffers." 
  (interactive) 
  (helm :sources '( ;; helm-source-same-mode-buffers-list
                   helm-source-buffers-list

                   ;; helm-source-files-in-current-dir
                   ;; helm-source-ido-virtual-buffers
                   helm-source-buffer-not-found) 
        :buffer "*helm buffers*" 
        :keymap helm-buffer-map 
        :truncate-lines t))
;; :truncate-lines nil))

(global-set-key (kbd "C-x b") 'helm-buffers-list-and-dir)

(setq helm-truncate-lines t)

(add-hook 'eshell-mode-hook 
          #'(lambda () 
             (define-key eshell-mode-map "\C-qh" 'helm-eshell-history)))


(when  (eq system-type 'darwin) 

(defun recentf-list-short-path(dir-or-file) 
  (when  (eq system-type 'darwin) 
    (concat "~/" (file-relative-name dir-or-file (getenv "HOME"))))

)


(setq helm-source-recentf `((name . "Recentf") 
                            (init . 
                                  (lambda () 
                                    (require 'recentf) 
                                    (recentf-mode 1)))
                            ;; (candidates . recentf-list)
                            (candidates . 
                                        (lambda () 
                                          (mapcar 'recentf-list-short-path recentf-list)))
                            (match . helm-files-match-only-basename) 
                            (filtered-candidate-transformer . 
                                                            (lambda (candidates _source) 
                                                              (cl-loop for i in candidates if
                                                                       helm-ff-transformer-show-only-basename
                                                                       collect (cons (helm-basename
                                                                                      i) i) else
                                                                                      collect i))) 
                            (keymap . ,helm-generic-files-map) 
                            (help-message . helm-generic-file-help-message) 
                            (mode-line . helm-generic-file-mode-line-string) 
                            (action . ,(cdr (helm-get-actions-from-type helm-source-locate)))))

)

(global-set-key "\C-x\C-r" 'helm-recentf)




;; ;; ;;;; Loading
;; (defmacro eval-after-load* (file &rest form)
;;   "Macro for simple `eval-after-load'.

;;  * FILE is a symbol or a string.
;;  * FORM allows for multiple body forms and is byte-compiled.

;; See `eval-after-load'."
;;   (declare (indent 1))
;;   `(eval-after-load ,file
;;      `(funcall #',(lambda () ,@form))))

;; (require 'all-ext)

;; (defun all-from-helm-ag ()
;;   "Call `all' from `helm' content."
;;   (interactive)
;;   (helm-run-after-quit
;;    'all-from-anything-occur-internal "helm-ag"
;;    helm-buffer helm-current-buffer))

;; ;; ;; (defun all-from-helm-ag ()
;; ;; ;;   "Call `all' from `helm' content."
;; ;; ;;   (interactive)
;; ;; ;;   (helm-run-after-quit
;; ;; ;;    'all-from-anything-occur-internal "helm-ag"
;; ;; ;;    helm-buffer helm-current-buffer))

;; ;; ;; (eval-after-load 'helm-ag
;; ;; ;;   (define-key helm-map (kbd "C-c C-a") 'all-from-helm-ag))
;; (eval-after-load 'helm-ag
;;   (define-key helm-map (kbd "C-c C-e") 'all-from-helm-ag))

;; ;; (defun all-from-helm-grep ()
;; ;;   "Call `all' from `helm' content."
;; ;;   (interactive)
;; ;;   (helm-run-after-quit
;; ;;    'all-from-anything-occur-internal "helm grep"
;; ;;    helm-buffer helm-current-buffer))

;; (eval-after-load* 'helm-do-grep
;;   (define-key helm-map (kbd "C-c C-a") 'all-from-helm-grep))


;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(setq helm-ff-transformer-show-only-basename  t)


;; (setq helm-follow-mode-persistent t)
(provide 'key-helm)
