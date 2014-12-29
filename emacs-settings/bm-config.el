
(require 'bm-ext)
;; (require 'bm)
(require 'smart-repeat-mode)

;; (global-set-key (kbd "<C-f2>") 'bm-toggle)
;; (global-set-key (kbd "<f2>")   'bm-next)
;; (global-set-key (kbd "<S-f2>") 'bm-previous)

(sr-define-alist-prefix "\C-xr" '(("p" bm-previous) 
                                  ("n" bm-next)) )

(global-set-key (kbd "C-x r m")   'bm-toggle)
(global-set-key (kbd "C-x r l")   'bm-show-all)

;; (global-set-key (kbd "C-x r M")   'bookmark-set)
;; (global-set-key (kbd "C-x m l")   'load-other-bookmark-file)
(provide 'bm-config )
