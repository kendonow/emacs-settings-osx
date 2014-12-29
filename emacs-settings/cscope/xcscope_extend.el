

(require 'xcscope_hist_wash)


(defun cscope-repeat-command (command)
  "Repeat COMMAND."
  ;; (let ((repeat-message-function  'ignore))
  (let ()
    (setq last-repeatable-command  command)
    (repeat nil)))


(defun cscope-toggle-update-database ()
  (interactive)
  (setq cscope-do-not-update-database
        (not cscope-do-not-update-database))
  (message "set cscope-do-not-update-database =%s" cscope-do-not-update-database)
  )



(defun cscope-buffer-search-extend-count (do-symbol do-next step)
  "The body of the following four functions."
  (let* (line-number old-point point
		     (search-file (not do-symbol))
		     (search-prev (not do-next))
		     (direction (if do-next step (- 0 step)))
		     ;; (direction (if do-next 2 -2))
		     (old-buffer (current-buffer))
		     (old-buffer-window (get-buffer-window old-buffer))
		     (buffer (get-buffer cscope-output-buffer-name))
		     (buffer-window (get-buffer-window (or buffer (error "The *cscope* buffer does not exist yet"))))
		     )
    (set-buffer buffer)
    (setq old-point (point))
    (forward-line direction)
    (setq point (point))
    (setq line-number (get-text-property point 'cscope-line-number))
    (while (or (not line-number)
	       (or (and do-symbol (= line-number -1))
		   (and search-file  (/= line-number -1))))
      (forward-line direction)
      (setq point (point))
      (if (or (and do-next (>= point (point-max)))
	      (and search-prev (<= point (point-min))))
	  (progn
	    (goto-char old-point)
	    (error "The %s of the *cscope* buffer has been reached"
		   (if do-next "end" "beginning"))))
      (setq line-number (get-text-property point 'cscope-line-number)))
    (if (eq old-buffer buffer) ;; In the *cscope* buffer.
	(cscope-show-entry-other-window)
      (cscope-select-entry-specified-window old-buffer-window) ;; else
      (if (windowp buffer-window)
	  (set-window-point buffer-window point)))
    (set-buffer old-buffer)
    ))



(defun cscope-next-symbol-count ( arg)
  "Move to the next symbol in the *cscope* buffer."
  (interactive "p")
  (cscope-buffer-search-extend-count t t arg))


(defun cscope-next-file-count (arg)
  "Move to the next file in the *cscope* buffer."
  (interactive "p")
  (cscope-buffer-search-extend-count nil t arg))


(defun cscope-prev-symbol-count (arg)
  "Move to the previous symbol in the *cscope* buffer."
  (interactive "p")
  (cscope-buffer-search-extend-count t nil arg))


(defun cscope-prev-file-count (arg)
  "Move to the previous file in the *cscope* buffer."
  (interactive "p")
  (cscope-buffer-search-extend-count nil nil arg))



(defun cscope-find-this-symbol-no-prompting()
  "Locate a symbol in source code [no database update performed -- no user prompting]."
  (interactive)
  (let ((symbol (cscope-extract-symbol-at-cursor nil))
	;; (cscope-do-not-update-database t)
	(cscope-adjust t))
    (setq cscope-symbol symbol)
    (cscope-call (format "Finding symbol: %s" symbol)
		 (list "-0" symbol) nil 'cscope-process-filter
		 'cscope-process-sentinel))
  (unless  cscope-do-not-update-database 
    (setq cscope-do-not-update-database t)
    )
  )




(define-key cscope:map "\C-csm" 'cscope-toggle-update-database)
(define-key cscope:map "\C-css" 'cscope-find-this-symbol-no-prompting)
(define-key cscope:map "\C-csr" 'cscope-find-this-symbol)
(define-key cscope:map "\C-csl" 'cscope-create-list-of-files-to-index)
;;--
;;--(define-key cscope:map "\C-csh"
;;--(define-key cscope:map "\C-csj"
;;--(define-key cscope:map "\C-csk"
;;--(define-key cscope:map "\C-csm"
;;--(define-key cscope:map "\C-csq"
;;--(define-key cscope:map "\C-csw"
;;--(define-key cscope:map "\C-csz"




(define-key cscope:map "\C-csn" 
  (lambda ( ) (interactive ) (cscope-repeat-command 'cscope-next-symbol)))

(define-key cscope:map "\C-csp" 
  (lambda ( ) (interactive ) (cscope-repeat-command 'cscope-prev-symbol)))


(define-key cscope-list-entry-keymap "k" 'cscope-wash-keep)
(define-key cscope-list-entry-keymap "K" 'cscope-wash-flush)
(define-key cscope-list-entry-keymap "U" 'cscope-wash-undo)

(define-key cscope-list-entry-keymap "n" 'cscope-next-symbol-count)
(define-key cscope-list-entry-keymap "p" 'cscope-prev-symbol-count)
(define-key cscope-list-entry-keymap "\M-p" 'cscope-prev-file-count)
(define-key cscope-list-entry-keymap "\M-n" 'cscope-next-file-count)


(define-key cscope-list-entry-keymap "m" 'cscope-toggle-update-database)




(provide 'xcscope_extend)
