(require 'breadcrumb )


(unless (fboundp 'breadcrumb-map) 
  (define-prefix-command 'breadcrumb-map) 
  (global-set-key "\C-xm" breadcrumb-map))


(global-set-key "\C-xms" 'bc-set) 
(global-set-key "\C-xmm" 'bc-set)

;; (global-set-key "\C-xmp" 'bc-previous)
;; (global-set-key "\C-xmn" 'bc-next)

;; (global-set-key "\C-xmb" 'bc-local-previous)
;; (global-set-key "\C-xmf" 'bc-local-next)

;; (global-set-key "\C-xm\M-p" 'bc-local-previous)
;; (global-set-key "\C-xm\M-n" 'bc-local-next)

;; (global-set-key "\C-xmc" 'bc-goto-current)
(global-set-key "\C-xml" 'bc-list)

(require 'smart-repeat-mode)

(sr-define-alist-prefix  ' "\C-xm"  ' (("n"   bc-next) 
                                                      ("p"  bc-previous ) 
                                                      ("f"   bc-local-next) 
                                                      ("b"  bc-local-previous ) 
                                                      ;; ("l"  bc-list ) 
                                                      ("c"  bc-goto-current )))


(provide 'breadcrumb-config )
