(require 'rect)

(defun rect-search-replace-in-rectangle
  (start end search-pattern replacement search-function literal)
  "Replace all instances of SEARCH-PATTERN (as found by SEARCH-FUNCTION)
with REPLACEMENT, in each line of the rectangle established by the START
and END buffer positions.

SEARCH-FUNCTION should take the same BOUND and NOERROR arguments as
`search-forward' and `re-search-forward'.

The LITERAL argument is passed to `replace-match' during replacement.

If `case-replace' is nil, do not alter case of replacement text."
  (apply-on-rectangle
   (lambda (start-col end-col search-function search-pattern replacement)
     (move-to-column start-col)
     (let ((bound (min (+ (point) (- end-col start-col))
                       (line-end-position)))
           (fixedcase (not case-replace)))
       (while (funcall search-function search-pattern bound t)
         (replace-match replacement fixedcase literal))))
   start end search-function search-pattern replacement))

(defun rect-replace-regexp-rectangle-read-args (regexp-flag)
  "Interactively read arguments for `rect-replace-regexp'
or `rect-replacs-string' (depending upon REGEXP-FLAG)."
  (let ((args (query-replace-read-args
               (concat "Replace"
                       (if current-prefix-arg " word" "")
                       (if regexp-flag " regexp" " string"))
               regexp-flag)))
    (list (region-beginning) (region-end)
          (nth 0 args) (nth 1 args) (nth 2 args))))

(defun rect-replace-regexp
  (start end regexp to-string &optional delimited)
  "Perform a regexp search and replace on each line of a rectangle
established by START and END (interactively, the marked region),
similar to `replace-regexp'.

Optional arg DELIMITED (prefix arg if interactive), if non-nil, means
replace only matches surrounded by word boundaries.

If `case-replace' is nil, do not alter case of replacement text."
  (interactive (rect-replace-regexp-rectangle-read-args t))
  (when delimited
    (setq regexp (concat "\\b" regexp "\\b")))
  (rect-search-replace-in-rectangle
   start end regexp to-string 're-search-forward nil))

(defun rect-replacs-string
  (start end from-string to-string &optional delimited)
  "Perform a string search and replace on each line of a rectangle
established by START and END (interactively, the marked region),
similar to `replace-string'.

Optional arg DELIMITED (prefix arg if interactive), if non-nil, means
replace only matches surrounded by word boundaries.

If `case-replace' is nil, do not alter case of replacement text."
  (interactive (rect-replace-regexp-rectangle-read-args nil))
  (let ((search-function 'search-forward))
    (when delimited
      (setq search-function 're-search-forward
            from-string (concat "\\b" (regexp-quote from-string) "\\b")))
    (rect-search-replace-in-rectangle
     start end from-string to-string search-function t)))



(defun rect-upcase (s e)
  "change chars in rectangle to uppercase"
  (interactive "r")
  (apply-on-rectangle 'upcase-rectangle-line s e))

(defun upcase-rectangle-line (startcol endcol)
  (when (= (move-to-column startcol) startcol)
    (upcase-region (point)
                   (progn (move-to-column endcol 'coerce)
                          (point)))))



(defun rect-downcase (s e)
  "change chars in rectangle to uppercase"
  (interactive "r")
  (apply-on-rectangle 'downcase-rectangle-line s e))

(defun downcase-rectangle-line (startcol endcol)
  (when (= (move-to-column startcol) startcol)
    (downcase-region (point)
                   (progn (move-to-column endcol 'coerce)
                          (point)))))

(defun rect-capitalize (s e)
  "change chars in rectangle to uppercase"
  (interactive "r")
  (apply-on-rectangle 'capitalize-rectangle-line s e))

(defun capitalize-rectangle-line (startcol endcol)
  (when (= (move-to-column startcol) startcol)
    (capitalize-region (point)
                   (progn (move-to-column endcol 'coerce)
                          (point)))))



(defun yank-replace-rectangle (start end)
   "Similar like yank-rectangle, but deletes selected rectangle first."
   (interactive "r")
   (delete-rectangle start end)
   (pop-to-mark-command)
   (yank-rectangle))
 
 (global-set-key (kbd "C-x r C-y") 'yank-replace-rectangle)




(global-set-key (kbd "C-x r %") 'rect-replacs-string)
(global-set-key (kbd "C-x r q") 'rect-replacs-string)

(global-set-key (kbd "C-x r M-%") 'rect-replace-regexp)
(global-set-key (kbd "C-x r e") 'rect-replace-regexp)



(global-set-key (kbd "C-x r M-l") 'rect-downcase)
(global-set-key (kbd "C-x r M-u") 'rect-upcase)
(global-set-key (kbd "C-x r M-c") 'rect-capitalize)

;(global-set-key (kbd "C-x r M-%") 'rect-replace-regexp)







(provide  'rect-replace)
