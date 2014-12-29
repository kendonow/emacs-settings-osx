


(defun kill-mode-buffers (buffer-mode &optional arg)
  (let ((current-buffer (current-buffer)))
    (dolist (buffer (buffer-list))
      (when (and (eq (buffer-local-value 'major-mode buffer) buffer-mode)
                 )
        (when (and arg 
          (not (eq buffer current-buffer)))
          (kill-buffer buffer)
          (message "kill buffer")
          )
        )

)))


(defun kill-mode-buffers-lisp ()
  (interactive )
  (kill-mode-buffers 'emacs-lisp-mode t)
)


(defun kill-mode-buffers-eshell ()
  (interactive )
  (kill-mode-buffers 'eshell-mode t)
)

(defun kill-mode-buffers-c++-mode ()
  (interactive )
  (kill-mode-buffers 'c++-mode t)
)


(provide 'kill-buffers)


