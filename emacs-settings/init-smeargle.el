(require 'smeargle)


(custom-set-variables
 '(smeargle-colors '((older-than-1day   . "red")
                     (older-than-3day   . "green")
                     (older-than-1week  . "yellow")
                     (older-than-2week  . nil)
                     (older-than-1month . "orange")
                     (older-than-3month . "pink")
                     (older-than-6month . "cyan")
                     (older-than-1year . "grey50"))))


(global-set-key (kbd "C-x v s") 'smeargle)

;; Highlight regions at opening file
(add-hook 'find-file-hook 'smeargle)

;; Updating after save buffer
(add-hook 'after-save-hook 'smeargle)


(provide 'init-smeargle)
