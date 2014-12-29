

;
;(setq skeleton-pair t)
;(global-set-key "{" 'skeleton-pair-insert-maybe)
;(global-set-key "<" 'skeleton-pair-insert-maybe)
;(global-set-key "[" 'skeleton-pair-insert-maybe)
;(global-set-key "(" 'skeleton-pair-insert-maybe)
;(global-set-key "'" 'skeleton-pair-insert-maybe)
;(global-set-key "\"" 'skeleton-pair-insert-maybe)
;


(require 'key-chord)
(key-chord-mode 1)


(defun key-chord-for-c-mode-common-hook ()

  (key-chord-define c++-mode-map "''"     "\"  \"\C-b\C-b")
;  (key-chord-define c++-mode-map "''"     "\"  \"\C-b\C-b")
  (key-chord-define c++-mode-map  "\"\""     "\"  \"\C-b\C-b")
                                        ;(key-chord-define-global "[]"     "[  ]\C-b\C-b")
  (key-chord-define c++-mode-map "[["     "{  }\C-b\C-b")
  (key-chord-define c++-mode-map "]]"     "(  )\C-b\C-b")
  (key-chord-define c++-mode-map "[]"     "[  ]\C-b\C-b")


  (key-chord-define c++-mode-map ";;"  "\C-e;")
  (key-chord-define c++-mode-map "{}"  "\n{\n\n}\C-p\t")
  (key-chord-define c++-mode-map "[["  "\n{\n\n}\C-p\t")
  (key-chord-define c++-mode-map "()"  "(  )\C-b\C-b")
  )


(add-hook 'c-mode-common-hook 'key-chord-for-c-mode-common-hook)


;(key-chord-define-global "qq"     "the ")


(provide 'key-chord-config)
