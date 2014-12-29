

(require 'ascope)


(defun ascope-display-buffer ()
  "Display the *cscope* buffer."
  (interactive)
  (let ((buffer (get-buffer ascope-output-buffer)))
    (if buffer
        (pop-to-buffer buffer)
      (error "The *ascope-Result* buffer does not exist yet"))))

(defun ascope-create-out-file (dir)
  ;; (interactive)
  (interactive "DCscope Initial Directory: ")
  (setq default-directory dir)

  (let ( (out-string (format "cscope -qR -P %s" default-directory))
                    )
    (message  "%s" out-string)
  (shell-command out-string)))



(defvar accope-key-map nil
  "The keymap used in the *acscope* buffer which lists search results.")

(define-prefix-command 'accope-key-map)


(define-key accope-key-map "i" 'ascope-init)

(define-key accope-key-map "l" 'ascope-create-out-file)
(define-key accope-key-map "d" 'ascope-find-global-definition)
(define-key accope-key-map "s" 'ascope-find-this-symbol)
(define-key accope-key-map "t" 'ascope-find-this-text-string)
(define-key accope-key-map "c" 'ascope-find-functions-calling-this-function)
(define-key accope-key-map "f" 'ascope-find-called-functions)
(define-key accope-key-map "I" 'ascope-find-files-including-file)
;; (define-key accope-key-map "l" 'ascope-all-symbol-assignments)
(define-key accope-key-map "x" 'ascope-clear-overlay-arrow)
(define-key accope-key-map "o" 'ascope-pop-marker)

(define-key accope-key-map "n" 'ascope-show-next-entry-other-window)

;; (define-key accope-key-map "n" 'ascope-buffer-next-entry)
;; (define-key accope-key-map "p" 'ascope-buffer-prev-entry)
(define-key accope-key-map "p" 'ascope-show-prev-entry-other-window)
(define-key accope-key-map "b" 'ascope-display-buffer)




(define-key global-map "\C-xa" 'accope-key-map)

(provide 'key-ascope)
