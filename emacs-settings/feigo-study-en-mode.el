
(require 'font-lock-ext)
(require 'load-theme-buffer-local)
(require 'color-theme)
(defvar feigo-study-en-mode-hook nil)

(make-variable-buffer-local 'hl-line) 

;; (defvar-local  hl-line "blue" )
(require 'color-theme-buffer-local)

(setq study-en-keyword
       '(
;        ("n\\.\\|v[ti]\\.\\|a\\.\\|ad\\." . font-lock-function-name-face)
        ("[^a-zA-Z]\\(n\\.\\|v[ti]\\.\\|a\\.\\|ad\\.\\)" 1 font-lock-function-name-face)
         ("n/\\|v[ti]/\\|a/\\|ad/" .  font-lock-function-name-face )

         ("\\*\\[\\|\\]" . font-lock-constant-face)
         ("\\[\\s-*,\\(.*\\)'.*\\]" 1  font-lock-keyword-face)
         ;; ("\\[.*'\\(.*\\)\\]" 1 font-lock-string-face);(:foreground "BurlyWood" ))
         ("\\[.*'\\(.*\\)\\]" 1 '(:foreground "sea green" ))
         ("\\[.*\\('\\).*\\]" 1 '( :foreground "red" ))


         ("\\-\\([^, -]*\\)[,-]" 1 '(:foreground "red") )
         ("\\-\\([^, -]*\\)$" 1 '(:foreground "red") )
         ("[.;?!]\\s-*\\(\\<[[:upper:]]\\w*\\)" 1 '(:foreground "red") )
         ("^\\s-*\\(\\<[[:upper:]]\\w*\\)" 1 '(:foreground "red") )

         
         ("[,]\\s-*\\(\\<[a-z]\\w*\\)" 1 '(:foreground "dark red") )
         ("\\(^\\[\\[.*$\\)" 1 '(:foreground "blue") t)
         
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




 ;; (setq feigo-study-en-map nil)

(defvar feigo-study-en-map
  (let ((map (make-sparse-keymap)))
    ;; Will inherit from `text-map' thanks to define-derived-mode.
     (define-key map "\M-n" 'my-forward-sentence)
     (define-key map "\M-p" 'my-backward-sentence)

  (define-key map "\C-cd" 'dictionary-buffer)
  (define-key map "\C-cw"     
    '(lambda () 
       (interactive) 
       (dictionary-buffer 1)))
    map)
  "Keymap used in `study map'.")

;; (if feigo-study-en-map
;;     nil
;;   (setq feigo-study-en-map (make-keymap))
;;   ;; (set-char-table-range (nth 1 feigo-study-en-map) t 'close-top-bottom-mode)

;;   ;; (suppress-keymap feigo-study-en-map)
;;   (define-key feigo-study-en-map "r"      'move-to-window-line)
;; )

;; (define-derived-mode feigo-study-en-mode text-mode "study-en-mode"
(define-derived-mode feigo-study-en-mode text-mode "study-en-mode"
" for study en 
\\{feigo-study-en-map}"
  (setq font-lock-defaults '(study-en-keyword))
  (visual-line-mode 1)

  ;; (set-face-attribute 'default nil :height 200)
  (linum-mode)
  (toggle-truncate-lines -1)
  (text-scale-adjust 1)
;  (maximize-frame)
  ;; (run-hooks 'feigo-study-en-mode-hook) 

  (color-theme-buffer-local 'color-theme-jsc-light2 (current-buffer))

  ;; (set (make-local-variable 'hl-line) "blue")
;; (set-face-background (make-local-variable 'hl-line) "blue")
;; (set-face-background 'hl-line "red")
  (use-local-map feigo-study-en-map)
  
 ;; (color-theme-jsc-light2)

;; (load-theme 'adwaita) 
 ;; (load-theme-buffer-local 'zenburn)
;  (setq mode-name "math lang")

  ;; (use-local-map feigo-study-en-map)
)


(defun my-forward-sentence (&optional arg)
  (interactive "P")
  (if arg
      (forward-char arg)
  (let ((bounds (bounds-of-thing-at-point 'sentence)))
    (if bounds
    (goto-char (cdr bounds))  )
    )
  ;; (beginning-of-thing 'sentence)
   (forward-sentence )
   (backward-sentence)
))

(defun my-backward-sentence (&optional arg)
  (interactive "P")
 (if arg
      (backward-char arg)
  (let ((bounds (bounds-of-thing-at-point 'sentence)))
    (if bounds
    (goto-char (car bounds))  )
    )
  (backward-sentence )
  (forward-sentence )
))


;; (defun my-feigo-study-en-key-hook ()
;;   (define-key c-mode-base-map (kbd "M-a") 'my-end-fun)
;;   (define-key c-mode-base-map (kbd "M-e") 'my-beginning-fun)
;;   )


;; (defun my-feigo-study-en-key-hook ()

;;   (define-key feigo-study-en-mode-map (kbd"\C-f" )'my-forward-sentence)
;;   (define-key feigo-study-en-mode-map (kbd "\C-b") 'my-backward-sentence)

;;   )
 ;; (add-hook 'feigo-study-en-mode-hook 'my-feigo-study-en-key-hook)
;; (lambda nil (color-theme-buffer-local 'color-theme-jsc-light2 (current-buffer))))


(provide 'feigo-study-en-mode)

