

(define-prefix-command 'tab-prefix-map)
(global-set-key [f18]  'tab-prefix-map)



(define-key tab-prefix-map "e"    ' toggle-global-auto-high-mode )
(define-key tab-prefix-map "b"    ' buffer-menu )
(define-key tab-prefix-map "f"    ' copy-buffer-filename-as-kill )

(define-key tab-prefix-map "r"    ' revert-buffer )
(define-key tab-prefix-map "s"    ' scroll-lock-mode )


(provide 'feigo-tab-key-config)






