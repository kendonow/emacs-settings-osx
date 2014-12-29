

(defun switch-same-mode-buffer-traversal (mode-name &optional to-next) 
  (let ((current-buffer (current-buffer)) 
        (buffer-list (buffer-list))) 
    (unless to-next 
      (setq buffer-list (nreverse buffer-list))) 
    (catch 'done 
      (dolist (buffer buffer-list) 
        (when (eq (buffer-local-value 'major-mode buffer) mode-name) 
          (when (not (eq current-buffer buffer))
            ;; (message (buffer-name buffer))
            ;; (setq switch-major-mode-current-buffer-name (buffer-name buffer))
            (when to-next 
              (bury-buffer current-buffer)) 
            (switch-to-buffer buffer) 
            (throw 'done t))))
      ;; (message "")
      )))



(defun switch-same-mode-buffer-next () 
  (interactive)
  (switch-same-mode-buffer-traversal  (buffer-local-value 'major-mode (current-buffer)) t))

(defun switch-same-mode-buffer-prev () 
  (interactive) 
  (switch-same-mode-buffer-traversal (buffer-local-value 'major-mode (current-buffer))  ))

(defun switch-current-major-mode-list ()
  ;; (interactive)
  (let
      ((current-buffer-mode-name ) 
       (buffer-list (buffer-list)) 
       (same-buffer-list (list)))
    (setq current-buffer-mode-name (buffer-local-value 'major-mode (current-buffer)))
    (dolist (buffer buffer-list) 
      (when (eq (buffer-local-value 'major-mode buffer) current-buffer-mode-name)
        ;; (princ buffer)
        ;; (princ
        (setq same-buffer-list (cons buffer same-buffer-list)))) 
    ;; (setq same-buffer-list (sort same-buffer-list string<))
    ;; (princ same-buffer-list)
    same-buffer-list))

(defun test () 
  (interactive ) 
  (message "ok") 
  (princ (switch-current-major-mode-list)))





(provide 'switch-same-mode-buffer)
