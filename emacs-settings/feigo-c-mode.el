

(font-lock-add-keywords 'c++-mode
  '(("\\<[[:alnum:]]+_cast[[:space:]]*<\\([[:alnum:][:space:]*]+\\)>[[:space:]]*(\\([[:alnum:][:space:]*]+\\))"
  (1 font-lock-type-face t)
  (2 font-lock-type-face t))))


(font-lock-add-keywords 'c++-mode
                        '(
                          ("\\<\\(FIXME\\|TODO\\|HACK\\|fixme\\|todo\\|hack\\)" 1 font-lock-warning-face t)
                          ("\\<\\(afx_msg\\)" 1 font-lock-variable-name-face t)

;                          ("[.>-]+ *\\<\\([a-zA-Z_]*\\) *("  1 font-lock-keyword-face)
;                          ("^[[:space:]]*\\<\\([a-zA-Z_]*\\) *("  1 font-lock-keyword-face)

                          ("^\\s-*\\(\\w+\\)\\s-*\("     (1 font-lock-keyword-face))
                          ("[.>-=]+\\s-*\\(\\w+\\)\\s-*\("     (1 font-lock-keyword-face))
                          ("\\(\\[\\)"  1 font-lock-keyword-face)
                          ("\\(\\]\\)"  1 font-lock-keyword-face)

                          ("\\<\\(END_MESSAGE_MAP\\|BEGIN_MESSAGE_MAP\\)" 1 font-lock-function-name-face t)

;                          ("[^/]\\(ON_.* *(\\)\\s-*\(" 1 font-lock-variable-name-face t)
                          ("\\<\\(ON[A-Z_]*\\)" 1 font-lock-variable-name-face t)
                          ("\\<\\(SLOT\\|SIGNAL\\|Q_OBJECT\\)" 1 font-lock-function-name-face t)
                          ("->\\([a-zA-Z_]+\\)(" 1 font-lock-function-name-face )
                          ("\\.\\([a-zA-Z_]+\\)(" 1  font-lock-function-name-face )
                          ("::\\([a-zA-Z_]+\\)(.*;" 1 font-lock-format-specifier-face )
                       
                          ))


;(font-lock-add-keywords 'c++-mode
;  '(
;;    ("\\(\\w+\\)\\s-*\("     (1 font-lock-keyword-face))
;    ("^\\s-*\\(\\w+\\)\\s-*\("     (1 font-lock-keyword-face))
;    ("[.>-]+\\s-*\\(\\w+\\)\\s-*\("     (1 font-lock-keyword-face))
;    )
;  )


;(add-hook 'c-mode-common-hook
 ; (lambda ()
;
;    (font-lock-add-keywords 'c++-mode
;      '(
;        ("\\<\\(FIXME\\|TODO\\|HACK\\|fixme\\|todo\\|hack\\)" 1 dfont-lock-warning-face t)
;))
;


;))
(add-hook 'c-mode-common-hook (lambda ()
  (font-lock-add-keywords nil         
;    '(("[<>:&*=+^%!~,.?;/-]" 0 font-lock-warning-face )))
;    '(("[<>:&*=+^%!~,.?;/-]" 0 '(:foreground "red") )))
    '(("\\([=!|][=]\\)\\|\\([-][>]\\)" 0 '(:foreground "red") )))
))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun my-c-mode-font-lock-if0 (limit)  
  (save-restriction  
    (widen)  
    (save-excursion  
      (goto-char (point-min))  
      (let ((depth 0) str start start-depth)  
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)  
          (setq str (match-string 1))  
          (if (string= str "if")  
              (progn  
                (setq depth (1+ depth))  
                (when (and (null start) (looking-at "\\s-+0"))  
                  (setq start (match-end 0)  
                        start-depth depth)))  
            (when (and start (= depth start-depth))  
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)  
              (setq start nil))  
            (when (string= str "endif")  
              (setq depth (1- depth)))))  
        (when (and start (> depth 0))  
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))  
  nil)  

(defun my-c-mode-common-hook-face ()  
  (font-lock-add-keywords  
   nil  
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))  

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook-face)  
;; (remove-hook 'c-mode-common-hook 'my-c-mode-common-hook-face)  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;   '((my-c-mode-font-lock-if0 (0 '(:foreground "grey") prepend))) 'add-to-end))

;(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;(add-to-list 'font-lock-function-name-face "BEGIN_MESSAGE_MAP"
;(require 'member-functions)
;
; (autoload 'expand-member-functions "member-functions" "Expand C++ member function declarations" t)
; (add-hook 'c++-mode-hook (lambda () (local-set-key "\C-cm" #'expand-member-functions)))
;


;(font-lock-add-keywords nil '(("\\<\\(FIXME\\):" 1 '(:foreground "blue") t)))
;(font-lock-add-keywords nil '(("\\<\\(FIXME\\):" 1 '(:foreground "#F0F0F0") t)))




(defvar font-lock-format-specifier-face		'font-lock-format-specifier-face
  "Face name to use for format specifiers.")

(defface font-lock-format-specifier-face
  '((t (:foreground "OrangeRed1")))
  "Font Lock mode face used to highlight format specifiers."
  :group 'font-lock-faces)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("[^%]\\(%\\([[:digit:]]+\\$\\)?[-+' #0*]*\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\(\\.\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\)?\\([hlLjzt]\\|ll\\|hh\\)?\\([aAbdiuoxXDOUfFeEgGcCsSpn]\\|\\[\\^?.[^]]*\\]\\)\\)"
				       1 font-lock-format-specifier-face t)
				      ("\\(%%\\)" 
				       1 font-lock-format-specifier-face t)) )))



(provide 'feigo-c-mode)
