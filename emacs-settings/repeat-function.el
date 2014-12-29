
;; Copyright (C) 2013  Free Software Foundation, Inc.
;;
;; Author: feigo  <feigo.zj@gmail.com>
;; Keywords: bookmark repeat
;; Created: 2013-03-28

(defun repeat-command (command)
  "Repeat COMMAND."
  (setq last-repeatable-command  command)
  (repeat nil)
)

(provide 'repeat-function)

