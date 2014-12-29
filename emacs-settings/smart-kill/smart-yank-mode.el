
(defvar smart-yank-keymap nil)
(defvar smart-yank-arg 1)


(defun close-smart-yank-mode ( ) 
  (interactive) 
  (smart-yank-mode -1) 
  (yank) 
  (push last-command-event unread-command-events))



(defun  smart-yank-word( &optional arg) 
  (interactive "p") 
  (smart-yank-mode -1)
  (let (( bounds (get-thing-forward 'word 1))) 
    (when bounds 
      (delete-region (car bounds) 
                     (cdr bounds)))
    (yank (get-yank-max-arg  arg))

))


(defun get-yank-max-arg( arg ) 
  "get max of the  former arg and arg" 
  (let ((x 1)) 
    (if  (/= arg 1) 
        (setq x arg) 
      (setq x (max arg smart-yank-arg))) 
    (setq smart-yank-arg 1)
    x))

(defun  smart-yank-symbol( &optional arg) 
  (interactive "p") 
  (smart-yank-mode -1) 
  (let (( bounds (get-thing-forward 'symbol 1))) 
    (when bounds 
      (delete-region (car bounds) 
                     (cdr bounds)))
    (yank (get-yank-max-arg  arg))

))



(defun  smart-yank-list( &optional arg) 
  (interactive "p") 
  (smart-yank-mode -1) 
  (let (( bounds (get-thing-forward-list ))) 
    (when bounds 
      (delete-region (car bounds) 
                     (cdr bounds)))
    (yank (get-yank-max-arg  arg))

))

(defun  smart-yank-quote-string( &optional arg) 
  (interactive "p") 
  (smart-yank-mode -1) 
  (let (( bounds (get-thing-forward-string ))) 
    (when bounds 
      (delete-region (car bounds) 
                     (cdr bounds)))
    (yank (get-yank-max-arg  arg))

))

(if smart-yank-keymap 
    nil 
  (setq smart-yank-keymap (make-keymap)) 
  (set-char-table-range (nth 1 smart-yank-keymap) t 'close-smart-yank-mode) 
  (suppress-keymap smart-yank-keymap) 
  (define-key smart-yank-keymap "w"    'smart-yank-word) 
  (define-key smart-yank-keymap "s"    'smart-yank-symbol) 
  (define-key smart-yank-keymap "\C-y"    
    (lambda() 
      (interactive)   
      (smart-yank-mode -1) 
      (yank))) 
  (define-key smart-yank-keymap "y"    
    (lambda() 
      (interactive)   
      (smart-yank-mode -1) 
      (yank))))

(define-minor-mode smart-yank-mode "" 
  nil
  " sYank"
  smart-yank-keymap 
  :global nil 
  :after-hook ;; (message "yank toggle")
)



(defun smart-yank-call (&optional arg) 
  "" 
  (interactive "p") 
  (if arg 
      (setq smart-yank-arg arg) 
    (setq smart-yank-arg 1)) 
  (smart-yank-mode t))






(provide 'smart-yank-mode)
