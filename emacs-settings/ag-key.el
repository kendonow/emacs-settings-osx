(require 'fg-ag)



(define-prefix-command 'ctrl-ag-map)

(global-set-key    "\C-cr" ctrl-ag-map)
(define-key ctrl-ag-map "d" 'ag )
;; (define-key ctrl-ag-map "a" 'ag )
(define-key ctrl-ag-map "e" 'ag-regexp)
(define-key ctrl-ag-map "c" 'ag-regexp-c-class)
(define-key ctrl-ag-map "m" 'ag-regexp-c-macro-define)
(define-key ctrl-ag-map "l" 'fg/ag-select-history )
;; (define-key ctrl-ag-map "s" 'ag-same )
(define-key ctrl-ag-map "v" 'fg/ag-set-directory )
(define-key ctrl-ag-map "b" 'ag/buffer-show-current)
;; (define-key ctrl-ag-map "f" 'ag-dired-regexp )


(require 'smart-repeat-mode)

(sr-define-alist   '("\C-crp" "\C-crn") 
                             '(("n"  next-error  ) 
                               ("p"  previous-error) 
                               ("e"  x-compilation-last-error) 
                               ("a"  first-error)))


(setq ag-highlight-search t)


(provide 'ag-key)
