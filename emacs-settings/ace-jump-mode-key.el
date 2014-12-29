

(require 'ace-jump-mode)

(require 's)



(defun ace-jump-char-mode (query-char) 
  "AceJump char mode" 
  (interactive (list (read-char "Query Char:")))

  ;; We should prevent recursion call this function.  This can happen
  ;; when you trigger the key for ace jump again when already in ace
  ;; jump mode.  So we stop the previous one first.
  (if ace-jump-current-mode 
      (ace-jump-done)) 
  (if (eq (ace-jump-char-category query-char) 'other) 
      (error 
       "[AceJump] Non-printable character"))
  ;;------------------------------
  (if (s-uppercase? (char-to-string query-char)) 
      (setq ace-jump-mode-case-fold nil) 
    (setq ace-jump-mode-case-fold t))
  ;;------------------------------

  ;; others : digit , alpha, punc
  (setq ace-jump-query-char query-char) 
  (setq ace-jump-current-mode 'ace-jump-char-mode) 
  (ace-jump-do (regexp-quote (make-string 1 query-char))))




(defun ace-jump-word-mode (head-char) 
  "AceJump word mode.
You can set `ace-jump-word-mode-use-query-char' to nil to prevent
asking for a head char, that will mark all the word in current
buffer." 
  (interactive (list 
                (if ace-jump-word-mode-use-query-char 
                    (read-char "Head Char:")
                  nil)))

  ;; We should prevent recursion call this function.  This can happen
  ;; when you trigger the key for ace jump again when already in ace
  ;; jump mode.  So we stop the previous one first.
  (if ace-jump-current-mode 
      (ace-jump-done)) 
  (cond ((null head-char)
         ;; \<  - start of word
         ;; \sw - word constituent
         (ace-jump-do "\\<\\sw")) 
        ((memq (ace-jump-char-category head-char) 
               '(digit alpha))
         ;;------------------------------
         (let (ace-jump-mode-case-fold) 
           (if (s-uppercase? (char-to-string head-char)) 
               (setq ace-jump-mode-case-fold nil) 
             (setq ace-jump-mode-case-fold t))
           ;;------------------------------
           (setq ace-jump-query-char head-char) 
           (setq ace-jump-current-mode 'ace-jump-word-mode) 
           (ace-jump-do (concat "\\<" (make-string 1 head-char))))) 
        ((eq (ace-jump-char-category head-char) 'punc)
         ;; we do not query punctuation under word mode
         (if (null ace-jump-mode-detect-punc) 
             (error 
              "[AceJump] Not a valid word constituent"))
         ;; we will use char mode to continue search
         (setq ace-jump-query-char head-char) 
         (setq ace-jump-current-mode 'ace-jump-char-mode) 
         (ace-jump-do (regexp-quote (make-string 1 head-char)))) 
        (t 
         (error 
          "[AceJump] Non-printable character"))))

(defun ace-jump-char-semicolon () 
  (interactive) 
  (ace-jump-multi-char-mode "\[:;\]"))

(defun ace-jump-char-quote () 
  (interactive) 
  (ace-jump-multi-char-mode "\['\"\]"))


(defun ace-jump-char-parenthesis-left () 
  (interactive) 
  (ace-jump-multi-char-mode "\[])}>\]"))

(defun ace-jump-char-parenthesis-right () 
  (interactive) 
  (ace-jump-multi-char-mode "\[{([<\]"))

(defun ace-jump-char-symbol-up () 
  (interactive) 
  (ace-jump-multi-char-mode "\[~`!@#$%^&*\]"))

(defun ace-jump-char-symbol-other () 
  (interactive) 
  (ace-jump-multi-char-mode "\[/?.,'\";:|\\\]"))


;; (global-set-key  "\C-c9" 'ace-jump-char-parenthesis-right)

(defun ace-jump-char-minus () 
  (interactive) 
  (ace-jump-multi-char-mode "\[-_\]"))

(defun ace-jump-char-equal () 
  (interactive) 
  (ace-jump-multi-char-mode "\[=+\]"))

(global-set-key  "\C-j;" 'ace-jump-char-semicolon)
(global-set-key  "\C-j'" 'ace-jump-char-quote)
(global-set-key  "\C-j9" 'ace-jump-char-parenthesis-right)
(global-set-key  "\C-j0" 'ace-jump-char-parenthesis-left)
(global-set-key  "\C-j[" 'ace-jump-char-parenthesis-right)
(global-set-key  "\C-j]" 'ace-jump-char-parenthesis-left)
(global-set-key  "\C-j-" 'ace-jump-char-minus)
(global-set-key  "\C-j=" 'ace-jump-char-equal)

;; (global-set-key  "\C-c;" 'ace-jump-char-semicolon)
;; (global-set-key  "\C-c'" 'ace-jump-char-quote)
;; (global-set-key  "\C-c[" 'ace-jump-char-parenthesis-right)
;; (global-set-key  "\C-c]" 'ace-jump-char-parenthesis-left)
(global-set-key  "\C-c9" 'ace-jump-char-parenthesis-right)
(global-set-key  "\C-c0" 'ace-jump-char-parenthesis-left)

(global-set-key  "\C-c-" 'ace-jump-char-minus)
(global-set-key  "\C-c=" 'ace-jump-char-equal)

(global-set-key  "\C-c8" 'ace-jump-char-symbol-up)
(global-set-key  "\C-j8" 'ace-jump-char-symbol-up)

(global-set-key  "\C-c7" 'ace-jump-char-symbol-other)
(global-set-key  "\C-j7" 'ace-jump-char-symbol-other)

(defun ace-jump-multi-char-mode (string) 
""
;; We should prevent recursion call this function.  This can happen
  ;; when you trigger the key for ace jump again when already in ace
  ;; jump mode.  So we stop the previous one first.
  (if ace-jump-current-mode 
      (ace-jump-done)) 
  (setq ace-jump-current-mode 'ace-jump-char-mode) 
  ;; (ace-jump-do "\[+=\]")
  (ace-jump-do string)
  )




;; (global-set-key  "\C-c[" 'ace-jump-char-brace-left)
;; (global-set-key  "\C-c]" 'ace-jump-char-brace-right)

;; (global-set-key  "\C-c9" 'ace-jump-char-parenthesis-left)
;; (global-set-key  "\C-c0" 'ace-jump-char-parenthesis-right)
;; (global-set-key  "\C-c=" 'ace-jump-char-equal)
;; (global-set-key  "\C-c-" 'ace-jump-char-minus)






(eval-after-load 
    "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))


;; (defun ace-jump-toggle-scope ()
;;   (interactive)
;;   (if (eq ace-jump-mode-scope 'visible)
;;       (progn (setq ace-jump-mode-scope 'window)
;;              (message "ace-jump-mode-scope window")
;;              )
;;     (message "ace-jump-mode-scope visible")
;;     (setq ace-jump-mode-scope 'visible)))

(defun ace-jump-toggle-scope (arg) 
  (interactive "P") 
  ;; (message "arg=%s"  arg) 
  (if (not arg) 
      (cond  ((eq ace-jump-mode-scope 'visible) 
              (progn 
                (setq ace-jump-mode-scope 'window) 
                )) 
             ((eq ace-jump-mode-scope 'window) 
              (progn 
                (setq ace-jump-mode-scope 'frame) 
                )) 
             ((eq ace-jump-mode-scope 'frame) 
              (progn 
                (setq ace-jump-mode-scope 'visible) 
                ))) 
    (progn 
      (cond  ((eq arg 1) 
              (setq ace-jump-mode-scope 'window)) 
             ((eq arg 2) 
              (setq ace-jump-mode-scope 'frame))
             ((eq arg 3) 
              (setq ace-jump-mode-scope 'visible)) 
             (t nil))))
  (message "ace-jump-mode-scope  %s" ace-jump-mode-scope))

(setq ace-jump-mode-scope 'window)





;; (global-set-key  "\C-cw" 'ace-jump-char-mode)
;; (global-set-key  "\C-c\C-j" 'ace-jump-char-mode)
;; (global-set-key  "\C-cu" 'ace-jump-mode-pop-mark)

(global-set-key  "\C-cj" 'ace-jump-char-mode)





(provide 'ace-jump-mode-key)
