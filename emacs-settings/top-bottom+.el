(defvar recent-move-flag-backward nil)
(defvar recent-move-flag-forward nil)
(defvar recent-move-direction 'top-direction)

(setq scroll-conservatively 1)
(defun recenter-move-half-top-bottom () 
  (interactive) 
  ;; (unless (eq this-command last-command )
  ;;   (setq recent-move-direction nil)
  ;;   )
  (cond ((eq recent-move-direction 'top-direction) 
         (recenter-move-half-page-backward)) 
        ((eq recent-move-direction 'bottom-direction) 
         (recenter-move-half-page-forward))
        (t 
         (recenter-top-bottom ))
        ))



(defun recenter-move-half-page-backward () 
  (cond ((eq recent-move-flag-backward t) 
         (setq recent-move-flag-backward nil) 
         (move-to-window-line  (+ 1 scroll-conservatively)         ))
        ((eq recent-move-flag-backward nil) 
         (setq recent-move-flag-backward t) 
         (recenter )))
)

(defun recenter-move-half-page-forward () 
  (cond ((eq recent-move-flag-forward t) 
         (setq recent-move-flag-forward nil) 
         (move-to-window-line  (- -2 scroll-conservatively)))
        ((eq recent-move-flag-forward nil)
         (setq recent-move-flag-forward t) 
         (recenter ))))



(defun recenter-move-half-top () 
  (interactive) 
  (setq recent-move-direction 'top-direction)
  (recenter-move-half-top-bottom))

(defun recenter-move-half-bottom () 
  (interactive) 
  (setq recent-move-direction 'bottom-direction)
  ;; (move-to-window-line (- 1 scroll-conservatively))
  (recenter-move-half-top-bottom))

;; (sr-define-alist  '("\C-l" ) 
;;                             '(("l"    recenter-move-half-top-bottom ) 
;;                               ("\C-l"  recenter-move-half-top-bottom) 
;;                               ("b"    recenter-move-half-bottom )
;;                               ;; ("\C-v"    recenter-move-half-bottom )
;;                               ("t"   recenter-move-half-top)
;;                               ;; ("v"   recenter-move-half-top)
;;                               ("m" 
;;                                (lambda () 
;;                                  (interactive) 
;;                                  (setq recent-move-direction nil)))))



(provide 'top-bottom+)
