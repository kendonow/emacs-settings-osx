
(require 'font-lock-ext)
(require 'load-theme-buffer-local)

(defvar feigo-study-en-mode-hook nil)


(setq study-en-keyword
       '(
        ;; ("n\\.\\|v[ti]\\.\\|a\\.\\|ad\\." .  font-lock-function-name-face)
        ;; ("[^a-zA-Z]\\(n\\.\\|v[ti]\\.\\|a\\.\\|ad\\.\\)" 1 (:foreground "Blue") );font-lock-function-name-face)
         ;; ("n/\\|v[ti]/\\|a/\\|ad/" .  (:foreground "Blue") )

         ("\\*\\[\\|\\]" 1 font-lock-function-name-face)
         ;; ("\\[\\s-*,\\(.*\\)'.*\\]" 1  (:foreground "LightSkyBlue"))
         ;; ("\\[.*'\\(.*\\)\\]" 1 (:foreground "BurlyWood" ))
         ;; ("\\[.*\\('\\).*\\]" 1 ( :foreground "CadetBlue" ))

         ;; ("\\([.;] \\)" 0 '(:foreground "red" :background "grey") )

         ("\\-\\([^, -]*\\)[,-]" 1 '(:foreground "red") )
         ("\\-\\([^, -]*\\)$" 1 '(:foreground "red") )
         ;; ("\\.\\s-*\\(\\w+\\)" 1 '(:foreground "red") )
         ("[.;]\\s-*\\(\\<[[:upper:]]\\w*\\)" 1 '(:foreground "red") )
         ("^\\s-*\\(\\<[[:upper:]]\\w*\\)" 1 '(:foreground "red") )

         
         ("[,]\\s-*\\(\\<[a-z]\\w*\\)" 1 '(:foreground "dark red") )
         ("\\(^\\[\\[.*$\\)" 1 '(:foreground "blue") t)

;         '(("\\([=!|][=]\\)\\|\\([-][>]\\)" 0 '(:foreground "red") )))

;         ("].*," 1  font-lock-comment-face)
         
         )
      )
;
;(setq my-mode-font-lock-keywords
;	  (list
;	   '("^#.*$" 0 'bold) ; make the line beginning with "#" bold
;	   '("\\(foo\\)\\(bar\\)" ; the word foobar in two faces
;		 (1 'font-lock-warning-face)
;		 (2 'font-lock-type-face))))
;


(define-derived-mode feigo-study-en-mode text-mode "study-en-mode"
  (setq font-lock-defaults '(study-en-keyword))
  ;; (set-face-attribute 'default nil :height 200)
  (linum-mode)
  (toggle-truncate-lines -1)
  (text-scale-adjust 4)
;  (maximize-frame)

  (visual-line-mode 1)
;  (color-theme-jsc-light2)
; (load-theme 'adwaita) 
  ;; (load-theme-buffer-local 'dichromacy)
;  (setq mode-name "math lang")
)

(provide 'feigo-study-en-mode)

