;;----------------------------------------------------------------------------
;; Smartrep.el
;; http://sheephead.homelinux.org/2011/12/19/6930/
;; https://github.com/myuhe/smartrep.el
;; https://raw.github.com/tkf/smartrep.el/master/smartrep.el
;;----------------------------------------------------------------------------


;; (when (require 'smartrep nil t)
;;   (setq orig-binding (key-binding "\C-l")) ; default key bind backup
;;   (progn
;;     (global-set-key "\C-l" nil)
;;     (smartrep-define-key
;;         global-map "C-l"
;;       '(("SPC" . 'scroll-up)
;;         ("b" . 'scroll-down)
;;         ("l" . 'forward-char)
;;         ("h" . 'backward-char)
;;         ("j" . 'next-line)
;;         ("k" . 'previous-line)
;;         ("i" . 'keyboard-quit)))
;;     )
;;   (global-set-key "\C-l\C-l" 'recenter-top-bottom)
;;   ;;(global-set-key "\C-l" orig-binding) ; default key bind revert


;;   ;; multiple-cursors
;;   (progn
;;     (smartrep-define-key
;;         global-map "C-l"
;;       '(("n" . 'mc/mark-next-like-this)
;;         ("p" . 'mc/mark-previous-like-this))))

;;   ;; org-mode
;;   (eval-after-load "org"
;;     '(progn
;;        (smartrep-define-key
;;            org-mode-map "C-c"
;;          '(("n" . 'outline-next-visible-heading)
;;            ("p" . 'outline-previous-visible-heading)))))

;;   (progn
;;     (smartrep-define-key global-map "M-g"
;;        '(("n"   . 'next-error)
;;          ("p"   . 'previous-error)
;;          ("C-n" . 'next-error)
;;          ("C-p" . 'previous-error))))

(require 'smartrep nil t)
(defun highlight-symbol-at-point-smartrep () 
  (interactive)
  ;; highlight-symbol-at-pointより抜粋
  (let ((symbol (highlight-symbol-get-symbol))) 
    (unless symbol 
      (error 
       "No symbol at point")) 
    (when (and font-lock-mode 
               (not (highlight-symbol-symbol-highlighted-p symbol))) 
      (highlight-symbol-add-symbol symbol))) 
  (message "[p]rev [n]ext [P]revDefun [N]extDefun [L]ist [a]ll [x]Remove [X]RemoveAll") 
  (condition-case e 
      (smartrep-read-event-loop '(("p" . highlight-symbol-prev) 
                                  ("n" . highlight-symbol-next) 
                                  ("s" . highlight-symbol-next) 
                                  ("r" . highlight-symbol-prev) 
                                  ("C-s" . highlight-symbol-next) 
                                  ("C-r" . highlight-symbol-prev) 
                                  ("P" . highlight-symbol-prev-in-defun) 
                                  ("N" . highlight-symbol-next-in-defun) 
                                  ("X" . highlight-symbol-remove-all) 
                                  ("L" . highlight-symbol-list-all) 
                                  ("a" . highlight-symbol-all) 
                                  ("x" . highlight-symbol-at-point))) 
    (quit (highlight-symbol-at-point)))) 


(global-set-key (kbd "C-c s") 'highlight-symbol-at-point-smartrep)



    ;; (smartrep-define-key
    ;;     c-mode-base-map "C-c"
    ;;   '(("e" c-end-of-defun    ) 
    ;;                             ("a"   c-beginning-of-defun) 
    ;;                             ("w"   copy-c-defun-name) 
    ;;                             ("p" backward-paragraph) 
    ;;                             ("n" forward-paragraph))
    ;;   )


(provide 'init-smartrep)
