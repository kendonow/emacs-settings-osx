(require  'thing-mark)
(require 'feigo-function)

(defun thing-mark-symbol-repeat ( )
  (interactive )
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-symbol)
)
(defun thing-mark-word-repeat (&optional arg)
  (interactive )
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-word)

)

(defun thing-mark-line-repeat (&optional arg)
  (interactive )
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-line)
)


(defun thing-mark-list-repeat()
  (interactive)
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-list)
)
(defun thing-mark-defun-repeat ( )
  (interactive )
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-defun)
)
(defun thing-mark-string-repeat ( )
  (interactive )
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-string)
)
;; yank begin
(defun thing-mark-block-repeat ( )
  (interactive )
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-block)
)
;; yank end 

;; yank begin
(defun thing-parenthesis-jump-repeat ( )
  (interactive )
  (feigo-repeat-command 'thing-parenthesis-jump)
)
;; yank end 


(defun thing-mark-paragraph-repeat ( )
  (interactive )
  (thing-mark-mode t)
  (feigo-repeat-command 'thing-mark-paragraph)
)

(defun thing-mark-backward-start ( )
  (interactive )
  (thing-mark-mode t)
  (setq thing-mark-current-thing 'word)
  (push-mark (point) t transient-mark-mode)

  (mark-thing-backward)
)



(provide 'thing-mark-repeat)
