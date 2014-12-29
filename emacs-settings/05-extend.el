








(define-key occur-mode-map "\C-g" 'color-occur-exit)









(require 'ag-key)



;(add-to-list 'load-path "~/emacs-setting/wgrep/")


;; (require 'ack-and-a-half)
;; ;; Create shorter aliases
;; (defalias 'ack 'ack-and-a-half)
;; (defalias 'ack-same 'ack-and-a-half-same)
;; (defalias 'ack-find-file 'ack-and-a-half-find-file)
;; (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; (setq ack-and-a-half-prompt-for-directory t)

(require 'compilation-mode-x)




(require 'astyle)





;; (require 'tempo-c-cpp)

;; (which-function-mode 1)







;; (define-prefix-command 'ctrl-j-map)
;; (global-set-key    "\C-j" ctrl-j-map)
;; (global-set-key  "\C-jj" 'ace-jump-char-mode)
;; (global-set-key  "\C-j\C-j" 'ace-jump-char-mode)
;; (global-set-key  "\C-jl" 'ace-jumpl-ine-mode)
;; (global-set-key  "\C-jw" 'ace-jump-word-mode)




;; (global-set-key (kbd "C-c SPC")     'ace-jump-char-mode)

(defface egoge-display-time
   '((((type x w32 mac))
      ;; #060525 is the background colour of my default face.
      (:foreground "red" :inherit bold))
     (((type tty))
      (:foreground "blue")))
   "Face used to display the time in the mode line.")

;; This causes the current time in the mode line to be displayed in
 ;; `egoge-display-time-face' to make it stand out visually.
 (setq display-time-string-forms
       '((propertize (concat month"月"day"日 " 24-hours ":" minutes " ")
 		    'face 'egoge-display-time)))
(display-time-mode 1)

;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda ()
;;             (face-remap-add-relative
;;              'mode-line '((:foreground "ivory" :background "DarkOrange2") mode-line))))

;; (add-hook 'c++-mode-hook
;;           (lambda ()
;;             (face-remap-add-relative
;;              'mode-line '((:foreground "ivory" :background "red") mode-line))))





;(require 'smart-yank-mode)
(provide '05-extend)
