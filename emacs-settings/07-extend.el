

;; (require 'regex-tool)




;; (require 'find-file-in-project)

;; (defun toggle-selective-display (column)
;;   (interactive "P")
;;       (set-selective-display
;;        (or column
;;            (unless selective-display
;;              (1+ (current-column))))))

;; (global-set-key (kbd "C-\\") 'toggle-selective-display)

(require 'hideshow-org)
(global-set-key "\C-cI" 'hs-org/minor-mode)
(defadvice goto-line (after expand-after-goto-line activate compile) 
  "hideshow-expand affected block when using goto-line in a collapsed buffer" 
  (save-excursion 
    (hs-show-block)))






(defun isearch-from-local-var (&optional col-indent) 
  (interactive "p") 
  (let ((word (current-word))) 
    (beginning-of-defun) 
    (setq regexp-search-ring (cons (concat "\\b" word "\\b") regexp-search-ring)) 
    (search-forward-regexp (concat "\\b" word "\\b"))))



(require 'rainbow-delimiters)
;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; (global-rainbow-delimiters-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completions-common-part ((t (:inherit default 
                                         :foreground "red")))) 
 '(diredp-compressed-file-suffix ((t (:foreground "#7b68ee")))) 
 '(diredp-ignored-file-name ((t (:foreground "#aaaaaa"))))
 ;; '(rainbow-delimiters-depth-1-face ((t (:foreground "Cyan"  ))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"  )))) 
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#22ff6c")))) 
 '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow1")))) 
 '(rainbow-delimiters-depth-4-face ((t (:foreground "Magenta3"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "Brown" )))) 
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#22ff6c" 
                                                    :background "#443344"))))
 ;; '(rainbow-delimiters-depth-6-face ((t (:foreground "RosyBrown"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "yellow1" 
                                                    :background "#443344")))) 
 '(rainbow-delimiters-depth-8-face ((t (:foreground "Magenta3" 
                                                    :background "#443344")))) 
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#8b7500" 
                                                    :background "#443344")))) 
 '(rainbow-delimiters-unmatched-face ((t ( :foreground "green" 
                                                       :background "red")))) 
 '(show-paren-match ((((class color) 
                       (background light)) 
                      (:background "azure2")))))


;;                                         ; 测试
;; (defun toggle-coding-system-gbk-utf8 (&optional arg )
;;   (interactive "P")
;;   (if arg
;;       (progn
;;         (revert-buffer-with-coding-system 'gbk )
;;         (message "revert to gbk"))
;;     (revert-buffer-with-coding-system 'utf-8 )
;;     (message "revert to utf-8")))

;; (global-set-key  (kbd "C-x RET e") 'toggle-coding-system-gbk-utf8)



(defun what-face (pos) 
  (interactive "d") 
  (let ((face (or (get-char-property (point) 'read-face-name) 
                  (get-char-property (point) 'face)))) 
    (if face 
        (message "Face: %s" face) 
      (message "No face at %d" pos))))

(require 'color-identifiers-mode)
;; (global-color-identifiers-mode )
(defun delimiters-and-color-hook () 
  ;; (princ (buffer-size)) 
  (when (< (buffer-size) 
           (* 1024 100))
    ;; (setq buffer-read-only t)
    (color-identifiers-mode 1) 
    (rainbow-delimiters-mode 1) 
    (setq truncate-lines t)))


(add-hook 'c-mode-common-hook 'delimiters-and-color-hook)
(add-hook 'emacs-lisp-mode-hook 'delimiters-and-color-hook)

;; (require 'highlight-global)
;; (global-set-key (kbd "C-c H") 'highlight-frame-toggle)




;; (defun my-find-file-check-make-large-file-read-only-hook ()
;;   "If a file is over a given size, make the buffer read only."
;;   (when (> (buffer-size) (* 1024 10))
;;     (setq buffer-read-only t)
;;     ;; (color-identifiers-mode -1)
;;     ;; (rainbow-delimiters-mode -1)
;;     ;; (buffer-disable-undo)
;;     (fundamental-mode)
;;     )
;; )

;; (add-hook 'find-file-hooks 'my-find-file-check-make-large-file-read-only-hook)
;; (remove-hook 'find-file-hooks 'my-find-file-check-make-large-file-read-only-hook)





(which-function-mode)

(setq mode-line-misc-info (delete (assoc 'which-func-mode
                                      mode-line-misc-info) mode-line-misc-info)
      which-func-header-line-format '(which-func-mode ("" which-func-format)))

(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    ;; (setq mode-line-format (delete (assoc 'which-func-mode
    (setq mode-line-misc-info (delete (assoc 'which-func-mode
                                          mode-line-misc-info) mode-line-misc-info)
          header-line-format which-func-header-line-format)))


(custom-set-faces 
 '(which-func ((t (:foreground "green" )))) 
)

;; (require 'setup-linum)
;; (linum-on)



;; (add-to-list 'load-path "~/emacs-setting/sublimity/")

;; (require 'sublimity)
;; (add-hook 'sublimity-map-setup-hook
;;           (lambda ()
;;             (setq buffer-face-mode-face '(:family "Monospace"))
;;             (buffer-face-mode)))
;; (setq sublimity-map-size 20)
;; (setq sublimity-map-fraction 0.3)
;; (setq sublimity-map-text-scale -7)
;; (setq sublimity-scroll-weight 5
;;       sublimity-scroll-drift-length 10)
;; (setq sublimity-attractive-centering-width 110)
;; ;; (setq sublimity-scroll-weight 10
;; ;;       sublimity-scroll-drift-length 5)

;; (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; ;; (require 'sublimity-attractive)


;; (require 'no-word)
;; (add-to-list 'auto-mode-alist '("\\.doc\\'" . no-word))
;;  (defvar no-word-coding-systems '(("greek-iso-8bit" . "8859-7.txt")
;;                                      ("iso-8859-7" . "8859-7.txt")
;;                                      ("iso-8859-1" . "8859-1.txt"))
;;       "Alist mapping coding system to antiword map file.")
;; (defun no-word ()
;;       "Run antiword on the entire buffer."
;;       (interactive)
;;       (let ((map-file (cdr (assoc (completing-read
;;                                    "Select coding: (default iso-8859-1) "
;;                                    no-word-coding-systems
;;                                    nil t nil nil "iso-8859-1")
;;                                   no-word-coding-systems)))
;;             (modified (buffer-modified-p)))
;;         (shell-command-on-region
;;          (point-min) (point-max) 
;;          (format "antiword -m %s -" map-file)
;;          (current-buffer)
;;          t)
;;         (set-buffer-modified-p modified)))





;; (defun prelude-open-with ()
;;   "Simple function that allows us to open the underlying
;; file of a buffer in an external program."
;;   (interactive)
;;   (when buffer-file-name
;;     (shell-command (concat
;;                     (if (eq system-type 'darwin)
;;                         "open"
;;                       (read-shell-command "Open current file with: "))
;;                     " "
;;                     buffer-file-name))))

;; (global-set-key (kbd "C-x C-o") 'prelude-open-with)

;; (defun xah-open-in-external-app (&optional file)
;;   "Open the current file or dired marked files in external app.

;; The app is chosen from your OS's preference."
;;   (interactive)
;;   (let ( doIt
;;          (myFileList
;;           (cond
;;            ((string-equal major-mode "dired-mode") (dired-get-marked-files))
;;            ((not file) (list (buffer-file-name)))
;;            (file (list file)))))
    
;;     (setq doIt (if (<= (length myFileList) 5)
;;                    t
;;                  (y-or-n-p "Open more than 5 files? ") ) )
    
;;     (when doIt
;;       (cond
;;        ((string-equal system-type "windows-nt")
;;         (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList))
;;        ((string-equal system-type "darwin")
;;         (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
;;        ((string-equal system-type "gnu/linux")
;;         (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath)) ) myFileList) ) ) ) ) )


;; (global-set-key (kbd "C-x RET C-f") 'xah-open-in-external-app)


(require 'openwith)
 (openwith-mode 1)
(setq openwith-associations  
'(;; ("\\.pdf\\'" "open" (file))
    ;; ("\\.html\\'" "open" (file))
    ("\\.mp3\\'" "mplayer" (file))
    ("\\.mp4\\'" "open" (file))
    ("\\.mkv\\'" "open" (file))
    ("\\.avi\\'" "open" (file))
    ("\\.doc\\'" "open" (file))
    ("\\.xls\\'" "open" (file))
    ;; ("\\.html\\'" "open" (file))
    ;; ("\\.\\(?:mpe?g\\|avi\\|wmv\\)\\'" "mplayer" ("-idx" file))
    ;; ("\\.\\(?:jp?g\\|png\\)\\'" "display" (file))
    )
)

 ;; (when (require 'openwith nil 'noerror)
 ;;      (setq openwith-associations
 ;;            (list
 ;;             (list (openwith-make-extension-regexp
 ;;                    '("mpg" "mpeg" "mp3" "mp4"
 ;;                      "avi" "wmv" "wav" "mov" "flv"
 ;;                      "ogm" "ogg" "mkv"))
 ;;                   "open"
 ;;                   '(file))
 ;;             ;; (list (openwith-make-extension-regexp
 ;;             ;;        '("xbm" "pbm" "pgm" "ppm" "pnm"
 ;;             ;;          "png" "gif" "bmp" "tif" "jpeg" "jpg"))
 ;;             ;;       "geeqie"
 ;;             ;;       '(file))
 ;;             (list (openwith-make-extension-regexp
 ;;                    '("doc" "xls" "ppt" "odt" "ods" "odg" "odp"))
 ;;                   "libreoffice"
 ;;                   '(file))
 ;;             '("\\.html" "open" (file))
 ;;             '("\\.chm" "kchmviewer" (file))
 ;;             ;; (list (openwith-make-extension-regexp
 ;;             ;;        '("pdf" "ps" "ps.gz" "dvi"))
 ;;             ;;       "okular"
 ;;             ;;       '(file))
 ;;             ))
 ;;      (openwith-mode 1))


(provide '07-extend)
