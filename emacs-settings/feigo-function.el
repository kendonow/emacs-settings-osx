
(defun feigo-repeat-command (command) 
  "Repeat COMMAND."
  ;; (let ((repeat-message-function  'ignore))
  (let () 
    (setq last-repeatable-command  command) 
    (repeat nil)))

(defun my-cc-mode-comment-dwim () 
  "Comment or uncomment the current line or text selection." 
  (interactive) 
  (let (p1 p2) 
    (if (region-active-p) 
        (progn 
          (save-excursion 
            (setq p1 (region-beginning) p2 (region-end)) 
            (goto-char p1) 
            (if (wholeLineIsCmt-p) 
                (my-uncomment-region p1 p2) 
              (my-comment-region p1 p2))) 
          (deactivate-mark)) 
      (progn 
        (if (wholeLineIsCmt-p) 
            (my-uncomment-current-line) 
          (my-comment-current-line))))))

(defun wholeLineIsCmt-p () 
  (save-excursion 
    (beginning-of-line 1) 
    (cond ((eq   major-mode 'emacs-lisp-mode) 
           (looking-at "[ \t]*;") ) 
          ((eq major-mode 'c++-mode) 
           (looking-at "[ \t]*//") ) 
          ((eq major-mode 'python-mode) 
           (looking-at "[ \t]*#") ) 
          (t (looking-at "[ \t]*;") ))))

(defun my-comment-current-line () 
  (interactive) 
  (beginning-of-line 1) 
  (when (eq major-mode 'python-mode) 
    (insert "#")) 
  (when (eq major-mode 'emacs-lisp-mode) 
    (insert ";")) 
  (when (eq major-mode 'c++-mode) 
    (insert "//")))

(defun my-uncomment-current-line () 
  "Remove ¡°//¡± (if any) in the beginning of current line." 
  (interactive) 
  (when (wholeLineIsCmt-p) 
    (beginning-of-line 1) 
    (cond ((eq   major-mode 'emacs-lisp-mode) 
           (progn 
             (search-forward ";") 
             (delete-backward-char 1))) 
          ((eq major-mode 'c++-mode) 
           (progn 
             (search-forward "//") 
             (delete-backward-char 2))) 
          ((eq major-mode 'python-mode) 
           (progn 
             (search-forward "#") 
             (delete-backward-char 1))) 
          (t 
           (progn 
             (search-forward ";") 
             (delete-backward-char 1))))))

(defun my-comment-region (p1 p2) 
  "Add ¡°//¡± to the beginning of each line of selected text." 
  (interactive "r") 
  (let ((deactivate-mark nil)) 
    (save-excursion 
      (goto-char p2) 
      (while (>= (point) p1) 
        (my-comment-current-line) 
        (previous-line)))))

(defun my-uncomment-region (p1 p2) 
  "Remove ¡°//¡± (if any) in the beginning of each line of selected text." 
  (interactive "r") 
  (deactivate-mark nil) 
  (save-excursion 
    (goto-char p2) 
    (while (>= (point) p1) 
      (my-uncomment-current-line) 
      (previous-line))))

(defun ska-point-to-register() 
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position." 
  (interactive) 
  (setq zmacs-region-stays t) 
  (point-to-register 8) 
  (message "Store Cursor Point "))

(defun ska-jump-to-register() 
  "Switches between current cursorposition and position
that was stored with ska-point-to-register." 
  (interactive) 
  (setq zmacs-region-stays t) 
  (let ((tmp (point-marker))) 
    (jump-to-register 8) 
    (set-register 8 tmp)) 
  (message "Restore Cursor Point "))

(defun my-append-to-lines (text-to-be-inserted) 
  (interactive "sEnter text to append: ") 
  (save-excursion 
    (let (point-ln mark-ln initial-ln final-ln count) 
      (barf-if-buffer-read-only) 
      (setq point-ln (line-number-at-pos)) 
      (exchange-point-and-mark) 
      (setq mark-ln (line-number-at-pos)) 
      (if (< point-ln mark-ln) 
          (progn 
            (setq initial-ln point-ln final-ln mark-ln) 
            (exchange-point-and-mark)) 
        (setq initial-ln mark-ln final-ln point-ln)) 
      (setq count initial-ln) 
      (while (<= count final-ln) 
        (progn 
          (move-end-of-line 1) 
          (insert text-to-be-inserted) 
          (next-line) 
          (setq count (1+ count)))) 
      (message "From line %d to line %d." initial-ln final-ln ))))

(defun eshell/clear() 
  "to clear the eshell buffer." 
  (interactive) 
  (let ((inhibit-read-only t)) 
    (erase-buffer)))

(defun xml-pretty-print-xml-region (begin end) 
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules." 
  (interactive "r") 
  (save-excursion 
    (nxml-mode) 
    (goto-char begin) 
    (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
      (backward-char) 
      (insert "\n")) 
    (indent-region begin end)) 
  (message "Ah, much better!"))

(defun align-regexp-repeated (start stop regexp) 
  "Like align-regexp, but repeated for multiple columns. See
http://www.emacswiki.org/emacs/AlignCommands" 
  (interactive "r\nsAlign regexp: ") 
  (let ((spacing 1) 
        (old-buffer-size (buffer-size))) 
    (when (string-match regexp " ") 
      (setq spacing 0)) 
    (align-regexp start stop (concat "\\([[:space:]]*\\)" regexp) 1 spacing t) 
    (align-regexp start (+ stop (- (buffer-size) old-buffer-size)) 
                  (concat regexp "\\([[:space:]]*\\)") 1 spacing t)))

(defun buf-move-keybinding(&optional arg) 
  "buf keybinding" 
  (interactive "p") 
  (let ((step t) 
        (ev last-command-event) 
        (echo-keystrokes nil)) 
    (while step 
      (let ((base  (event-basic-type ev) )) 
        (setq step t) 
        (cond ((or 
                (eq base 'left) 
                (eq base ?w)) 
               (setq step t) 
               (condition-case nil 
                   (buf-move-left) 
                 (error 
                  "test"))) 
              ((eq base 'right) 
               (setq step t) 
               (condition-case nil 
                   (buf-move-right) 
                 (error 
                  "test"))) 
              ((eq base 'up) 
               (setq step t) 
               (condition-case nil 
                   (buf-move-up) 
                 (error 
                  "test"))) 
              ((eq base 'down) 
               (setq step t) 
               (condition-case nil 
                   (buf-move-down) 
                 (error 
                  "test"))) 
              (t 
               (setq step nil) 
               (message "buf-move-keybinding"))) 
        (if step 
            (setq ev (read-event "press key [[ left right up down ]]")) 
          (message "buf move quit"))))  ;let
    )                                   ;while
  )

(defun other-buffer-keybinding(&optional arg) 
  "buf keybinding" 
  (interactive "p") 
  (let ((step t) 
        (ev last-command-event) 
        (echo-keystrokes nil)) 
    (while step 
      (let ((base  (event-basic-type ev) )) 
        (setq step t) 
        (cond ((eq base ?o) 
               (setq step t) 
               (other-window 1)) 
              ((eq base ?i) 
               (setq step t) 
               (other-window -1)) 
              ((eq base 'left) 
               (setq step t) 
               (condition-case nil 
                   (windmove-left) 
                 (error 
                  "test"))) 
              ((eq base 'right) 
               (setq step t) 
               (condition-case nil 
                   (windmove-right) 
                 (error 
                  "test"))) 
              ((eq base 'up) 
               (setq step t) 
               (condition-case nil 
                   (windmove-up) 
                 (error 
                  "test"))) 
              ((eq base 'down) 
               (setq step t) 
               (condition-case nil 
                   (windmove-down) 
                 (error 
                  "test"))) 
              (t 
               (setq step nil) 
               (message "quit other-buffer-keybinding"))) 
        (if step 
            (setq ev (read-event "o,i =other left right up down ")) 
          (message "buffer window  quit")))) ;let
    (push ev unread-command-events)          ;let
    )                                        ;while
  )

(defun toggle-line-spacing (&optional arg) 
  "Toggle line spacing between 1 and 5 pixels." 
  (interactive "p") 
  (setq-default line-spacing arg) 
  (message "line-spacing is set %d" arg) 
  (redraw-display))

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode -1)

(defun rotate-windows () 
  "Rotate your windows" 
  (interactive) 
  (cond ((not (> (count-windows)1)) 
         (message "You can't rotate a single window!")) 
        (t 
         (setq i 1) 
         (setq numWindows (count-windows)) 
         (while  (< i numWindows) 
           (let* ((w1 (elt (window-list) i)) 
                  (w2 (elt (window-list) 
                           (+ (% i numWindows) 1))) 
                  (b1 (window-buffer w1)) 
                  (b2 (window-buffer w2)) 
                  (s1 (window-start w1)) 
                  (s2 (window-start w2))) 
             (set-window-buffer w1  b2) 
             (set-window-buffer w2 b1) 
             (set-window-start w1 s2) 
             (set-window-start w2 s1) 
             (setq i (1+ i)))))))

(defun rotate-windows-reverse () 
  "Rotate your windows" 
  (interactive) 
  (cond ((not (> (count-windows) 1)) 
         (message "You can't rotate a single window!")) 
        (t 
         (setq numWindows (count-windows)) 
         (setq i numWindows) 
         (while  (> i 0) 
           (let* ((w1 (elt (window-list) i)) 
                  (w2 (elt (window-list) 
                           (- (% i numWindows) 1))) 
                  (b1 (window-buffer w1)) 
                  (b2 (window-buffer w2)) 
                  (s1 (window-start w1)) 
                  (s2 (window-start w2))) 
             (set-window-buffer w1  b2) 
             (set-window-buffer w2 b1) 
             (set-window-start w1 s2) 
             (set-window-start w2 s1) 
             (setq i (1- i)))))))

(defun visual-line-line-range () 
  (save-excursion 
    (cons 
     (progn 
       (vertical-motion 0) 
       (point)) 
     (progn 
       (vertical-motion 1) 
       (+ (point) 0)))))

(setq hl-line-range-function 'visual-line-line-range)

(require 'hl-line+)
(hl-line-toggle-when-idle 2)

(defun toggle-fullscreen () 
  "Toggle full screen" 
  (interactive) 
  (set-frame-parameter nil 'fullscreen 
                       (when (not (frame-parameter nil 'fullscreen)) 
                         'fullboth)))

(defun ns-toggle-fullscreen-32 () 
  (interactive) 
  (shell-command "emacs_fullscreen.exe --topmost"))

(if (eq system-type 'windows-nt) 
    (global-set-key  [C-f12] 'ns-toggle-fullscreen-32) 
  (global-set-key  [C-f12] 'toggle-fullscreen))



(defun sudo-edit (&optional arg) 
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file." 
  (interactive "P") 
  (if (or arg 
          (not buffer-file-name)) 
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "Find file(as root): "))) 
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


(defun my-insert-date () 
  (interactive)
  ;;  (insert "//    ")
  (insert (format-time-string "%Y-%m-%d %H:%M" (current-time))) 
  (insert "    @") 
  (insert (user-full-name)))

(defun my-show-date-time () 
  (interactive) 
  (let ((time-string)) 
    (setq time-string (format-time-string "%Y-%m-%d %H:%M" (current-time))) 
    (message time-string) 
    (kill-new time-string)))


(defun all-over-the-screen () 
  (interactive) 
  (delete-other-windows)
  ;; (split-window-horizontally)
  (split-window-horizontally) 
  (balance-windows) 
  (follow-mode t))



(defun eshell-cd-here-split-window () 
  "From a buffer run and it will split your window and cd to the buffer's directory" 
  (interactive) 
  (let ((cur default-directory)) 
    (split-window-sensibly) 
    (other-window 1) 
    (eshell) 
    (eshell/cd cur) 
    (insert "") 
    (eshell-send-input)))


(defun remove-multi-blank-lines () 
  "Collapse multiple blank lines from buffer or region into a single blank line" 
  (interactive) 
  (save-excursion 
    (let (min max) 
      (if (equal (region-active-p) nil) 
          (mark-whole-buffer)) 
      (setq min (region-beginning) max (region-end))
      ;; (query-replace-regexp "^
      (replace-regexp "^
\\{2,\\}" "
" nil min max))))

(defun remove-comment-lines-elisp ()
  "Removes all comment lines from buffer or region"
  (interactive)
  (save-excursion
    (let (min max)
      (if (equal (region-active-p) nil)
          (mark-whole-buffer))
      (setq min (region-beginning) max (region-end))
      (flush-lines "^\\s-*;" min max t))))

(defun remove-comment-lines-c-mode ()
  "Removes all comment lines from buffer or region"
  (interactive)
  (save-excursion
    (let (min max)
      (if (equal (region-active-p) nil)
          (mark-whole-buffer))
      (setq min (region-beginning) max (region-end))
      (flush-lines "^\\s-*//" min max t))))

;;  (defun remove-comment-lines ()
;;   ""
;;   (interactive )
;;   (goto-char (point-min))
;;   (flush-lines "^\\s-*\\\\$",min)
;; )


;;   (let ((count 0)(buffername (buffer-name)))
;;     (while (re-search-forward "^[ \t]*\n" nil t)
;;       (progn
;;         (replace-match "")
;;         (setq count (+ count 1))
;;         )
;;       )
;;     (if (> count 0)
;;         (progn
;;           (message "remove %d line(s) in buffer %s" count buffername)
;;           (goto-char (point-min))
;;           )
;;       (message "no blank line in buffer %s" buffername)
;;       )
;;     )
;;   )

;; (defun remove-useless-lines ()
;;   "useless lines means blank lines and duplicate lines"
;;   (interactive "*")
;;   (remove-duplicate-lines)
;;   (remove-blank-lines)
;;   )


(provide 'feigo-function)
