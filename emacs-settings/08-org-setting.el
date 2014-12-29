;; (add-to-list 'load-path "~/emacs-setting/org-8.2.7b/lisp")
;; (add-to-list 'load-path "~/emacs-setting/org-8.2.7b/contrib/lisp")
;; ;;                                         ; for org-mode setting
;; ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((dot . t)))


(require '04-beamer-setting)
;; (require '04-org-extend)


(require 'htmlize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun smart-org-common-hook () 
  (require 'smart-repeat-mode) 
  (sr-define-alist   '("\C-zp" "\C-zn") 
                               '(("n"  outline-next-visible-heading  ) 
                                 ("p"  outline-previous-visible-heading) 
                                 ("f"  org-forward-heading-same-level  ) 
                                 ("b"   org-backward-heading-same-level)) nil org-mode-map) 
  (define-key org-mode-map (kbd "C-c i") 
    (lambda ( ) 
      (interactive ) 
      (feigo-repeat-command 'org-shifttab))) 
  (define-key org-mode-map  (kbd "C-c ;"    ) 'comment-region-extend) 
  (define-key org-mode-map  (kbd "C-c '"    ) 'uncomment-region-extend)
  (require  'switch-same-mode-buffer)


  ;; (sr-define-alist  '("\C-c\." "\C-c," "\C-c/") 
  ;;                             '( ;;
  ;;                               ([left] previous-buffer    ) 
  ;;                               ("\."  switch-same-mode-buffer-prev) 
  ;;                               (","  switch-same-mode-buffer-next) 
  ;;                               ("/" previous-buffer )
  ;;                               ;; ("\C-/"  next-buffer)
  ;;                               ("?"  next-buffer) 
  ;;                               ([right] previous-buffer    )) nil org-mode-map)



  (sr-define-alist-prefix "\C-c" '(;; ([left] previous-buffer    )
                                                ("\." switch-same-mode-buffer-next  ) 
                                                (","  switch-same-mode-buffer-prev) 
                                                ("?" previous-buffer ) 
                                                ("/"  next-buffer)
                                                ;; ([right] previous-buffer    )
                                                )
                                          nil org-mode-map)

  (linum-mode 1)
)

(add-hook 'org-mode-hook 'smart-org-common-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(add-to-list 'load-path "~/emacs-setting/color-theme-tangotango")
(require 'color-theme-tangotango)
(require 'color-theme-buffer-local)

(defun org-common-hook-theme-local () 
  (color-theme-buffer-local 'color-theme-tangotango (current-buffer)))

(add-hook 'org-mode-hook 'org-common-hook-theme-local)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 使用xelatex一步生成PDF
;; for org 7.8
(setq org-latex-to-pdf-process '("xelatex -interaction nonstopmode %f"
                                 "xelatex -interaction nonstopmode %f"))


;; ;; for org 8.2.7
;; (setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
;;                                  "xelatex -interaction nonstopmode %f"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#FFFFEA")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
  "Face used for the line delimiting the end of source blocks.")


;; (require 'ob-plantuml)

(setq org-plantuml-jar-path
      (expand-file-name "~/bin/plantuml.jar"))


;; (require 'org-mobile)
;; (setq org-mobile-inbox-for-pull "~/mobile_org")
;; (setq org-mobile-directory "~/mobile_org")
;; (define-key org-mode-map "\C-cp" 'org-mobile-pull)
;; (define-key org-agenda-mode-map "\C-cp" 'org-mobile-pull)

(provide '08-org-setting)
