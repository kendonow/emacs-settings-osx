(load "graphviz-dot-mode.el" nil t t)

(defun my-graphviz-dot-mode-hook ()
  ;; (linum-mode -1)
  ;; (define-key doc-view-mode-map "\C-xk" 'doc-view-kill-proc-and-buffer)
  (define-key graphviz-dot-mode-map "\C-c\C-p"    'graphviz-dot-preview) 
  ;; (define-key graphviz-dot-mode-map "\C-c\C-c"    'compile) 
  (define-key graphviz-dot-mode-map "\C-c\C-v"    'graphviz-dot-view)
  (local-unset-key "\C-c\C-c") 
  (local-unset-key "\C-c\C-u")
  (local-unset-key "\C-cp") 
  ;; (local-unset-key "\C-cc") 
  (local-unset-key "\C-cv")
)
(add-hook 'graphviz-dot-mode-hook 'my-graphviz-dot-mode-hook)




(defun my-doc-view-mode-hook () 
  (linum-mode -1) 
  (define-key doc-view-mode-map "\C-xk" 'doc-view-kill-proc-and-buffer)
)
(add-hook 'doc-view-mode-hook 'my-doc-view-mode-hook)


;; (require 'graphviz-dot-mode)
(add-hook 'find-file-hooks 
          '(lambda () 
             (if (eq major-mode 'doc-view-mode) 
                 (progn 
                   (linum-mode -1) 
                   (define-key doc-view-mode-map "\C-xk" 'doc-view-kill-proc-and-buffer)) 
               (linum-mode 1)))
)

(setq graphviz-dot-auto-indent-on-semi nil)

(provide 'graphviz-dot-mode-setting )
