(require 'ace-jump-mode-key )
(message "ctrl-j-key")
(unless (fboundp 'ctrl-j-thing) 
  (define-prefix-command 'ctrl-j-thing) 
  (global-set-key "\C-j" ctrl-j-thing))

(global-set-key  "\C-jw" 'ace-jump-word-mode)
(global-set-key  "\C-jc" 'ace-jump-char-mode)
(global-set-key  "\C-jj" 'ace-jump-word-mode)
(global-set-key  "\C-jl" 'ace-jump-line-mode)
(global-set-key  "\C-ju" 'ace-jump-mode-pop-mark)


(global-set-key  "\C-j\C-j" 'ace-jump-toggle-scope)

(global-set-key  "\C-j1" '
                 (lambda ( ) 
                   (interactive ) 
                   (ace-jump-toggle-scope 1)))

(global-set-key  "\C-j2" '
                 (lambda ( ) 
                   (interactive ) 
                   (ace-jump-toggle-scope 2)))

(global-set-key  "\C-j3" '
                 (lambda ( ) 
                   (interactive ) 
                   (ace-jump-toggle-scope 3)))

;; ace-jump-toggle-scope





(provide 'ctrl-j-key )
