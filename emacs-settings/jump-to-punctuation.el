(defvar xah-punctuations nil "list of punctuation chars.")
(setq xah-punctuations '("=" "*" "$" "#" "+" "\\" "&" "@" "%" "!" "?" "^" "`" "~") )

(defun xah-forward-punct (&optional number)
  "Move cursor to the next occurrence of punctuation.

The list of punctuations to jump to is defined by `xah-punctuations'"
  (interactive "p")
  (if (and number (> 0 number))
      (xah-backward-punct (- 0 number))
    (forward-char 1)
    (search-forward-regexp (eval-when-compile (regexp-opt xah-punctuations)) nil t number)
    (backward-char 1)))

(defun xah-backward-punct (&optional number)
  "Move cursor to the previous occurrence of punctuation.

The list of punctuations to jump to is defined by `xah-punctuations'"
  (interactive "p")
  (if (and number (> 0 number))
      (xah-forward-punct (- 0 number))
    (search-backward-regexp (eval-when-compile (regexp-opt xah-punctuations)) nil t number)))




(defun ergoemacs-forward-open-bracket (&optional number)
  "Move cursor to the next occurrence of left bracket or quotation mark.

With prefix NUMBER, move forward to the next NUMBER left bracket or quotation mark.

With a negative prefix NUMBER, move backward to the previous NUMBER left bracket or quotation mark."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-backward-open-bracket (- 0 number))
    (forward-char 1)
    (search-forward-regexp
     (eval-when-compile
       (regexp-opt
        '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«"))) nil t number)
    (backward-char 1)))

(defun ergoemacs-backward-open-bracket (&optional number)
  "Move cursor to the previous occurrence of left bracket or quotation mark.
With prefix argument NUMBER, move backward NUMBER open brackets.
With a negative prefix NUMBER, move forward NUMBER open brackets."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-forward-open-bracket (- 0 number))
    (search-backward-regexp
   (eval-when-compile
     (regexp-opt
      '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«"))) nil t number)))

(defun ergoemacs-forward-close-bracket (&optional number)
  "Move cursor to the next occurrence of right bracket or quotation mark.
With a prefix argument NUMBER, move forward NUMBER closed bracket.
With a negative prefix argument NUMBER, move backward NUMBER closed brackets."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-backward-close-bracket (- 0 number))
    (search-forward-regexp
     (eval-when-compile
       (regexp-opt '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»"))) nil t number)))

(defun ergoemacs-backward-close-bracket (&optional number)
  "Move cursor to the previous occurrence of right bracket or quotation mark.
With a prefix argument NUMBER, move backward NUMBER closed brackets.
With a negative prefix argument NUMBER, move forward NUMBER closed brackets."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-forward-close-bracket (- 0 number))
    (backward-char 1)
    (search-backward-regexp
     (eval-when-compile
       (regexp-opt '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»"))) nil t number)
    (forward-char 1)))


;; (global-set-key  "\C-c5" 'xah-backward-punct)


;; (define-key ctrl-l-map "l" 

;; (global-set-key  "\C-c6"      (lambda ( ) (interactive ) (feigo-repeat-command 'ergoemacs-backward-open-bracket))) 
;; (global-set-key  "\C-c7"      (lambda ( ) (interactive ) (feigo-repeat-command 'ergoemacs-forward-close-bracket))) 


(provide 'jump-to-punctuation)

