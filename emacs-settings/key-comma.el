


(require 'feigo-function)

(define-prefix-command 'ctrl-comma-map)
(global-set-key  (kbd "C-,")  ctrl-comma-map)


(define-key ctrl-comma-map "l"      (lambda ( ) (interactive ) (feigo-repeat-command 'recenter-top-bottom-2)))
(define-key ctrl-comma-map "b"     (lambda ( ) (interactive ) (recenter -1)))
(define-key ctrl-comma-map "t"     (lambda ( ) (interactive ) (recenter 1)))






(provide 'key-comma)
