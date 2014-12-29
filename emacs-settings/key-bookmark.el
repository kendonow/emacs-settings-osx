
;; Copyright (C) 2013  Free Software Foundation, Inc.
;;
;; Author: feigo  <feigo.zj@gmail.com>
;; Keywords: bookmark repeat
;; Created: 2013-03-28


(require 'easy-bookmark)

(require 'repeat-function)






(define-prefix-command 'easy-bookmark-map)

;; (define-key ctl-x-map   "m" easy-bookmark-map)




;; (defun af-bookmark-cycle-next/repeat( )
;;   (interactive)
;;   (repeat-command 'af-bookmark-cycle-forward ))

(defun af-bookmark-cycle-next() 
  (interactive) 
  (af-bookmark-cycle 1))


(defun af-bookmark-cycle-prev() 
  (interactive) 
  (af-bookmark-cycle -1))
;; (repeat-command 'af-bookmark-cycle-reverse))


;; (define-key easy-bookmark-map          "m" 'bm-toggle)
;; (define-key easy-bookmark-map          "b" 'bm-show)
;; (define-key easy-bookmark-map          "l" 'bm-show-all)

;; (define-key easy-bookmark-map          "n" 'bm-next/repeat)
;; (define-key easy-bookmark-map          "p" 'bm-prev/repeat)



;; (define-key easy-bookmark-map          "c" 'af-bookmark-clear-all)
;; (define-key easy-bookmark-map          "l" 'bookmark-bmenu-list)

(require 'smart-repeat-mode)

(sr-define-alist-prefix "\C-xr" '(("p" af-bookmark-cycle-prev) 
                                  ("n" af-bookmark-cycle-next)) )

;; (global-set-key (kbd "C-x r n")  'af-bookmark-cycle-next/repeat)

;; (global-set-key (kbd "C-x r p")   'af-bookmark-cycle-prev/repeat)

(global-set-key (kbd "C-x r m")   'af-bookmark-toggle)
(global-set-key (kbd "C-x r M")   'bookmark-set)
;; (global-set-key (kbd "C-x m l")   'load-other-bookmark-file)



(defun bookmark-yank-word () 
  "Get the next word from buffer `bookmark-current-buffer' and append
it to the name of the bookmark currently being set, advancing
`bookmark-yank-point' by one word." 
  (interactive) 
  (let ((string 
         (with-current-buffer bookmark-current-buffer 
           (goto-char bookmark-yank-point) 
           (thing-at-point 'symbol)
           ;; (buffer-substring-no-properties
           ;;  (point)
           ;;  (progn
           ;;    (forward-word 1)
           ;;    (setq bookmark-yank-point (point))))
           )))
    ;; (insert string)
    string))

(defun bookmark-set (&optional name no-overwrite) 
  "Set a bookmark named NAME at the current location.
If name is nil, then prompt the user.

With a prefix arg (non-nil NO-OVERWRITE), do not overwrite any
existing bookmark that has the same name as NAME, but instead push the
new bookmark onto the bookmark alist.  The most recently set bookmark
with name NAME is thus the one in effect at any given time, but the
others are still there, should the user decide to delete the most
recent one.

To yank words from the text of the buffer and use them as part of the
bookmark name, type C-w while setting a bookmark.  Successive C-w's
yank successive words.

Typing C-u inserts (at the bookmark name prompt) the name of the last
bookmark used in the document where the new bookmark is being set;
this helps you use a single bookmark name to track progress through a
large document.  If there is no prior bookmark for this document, then
C-u inserts an appropriate name based on the buffer or file.

Use \\[bookmark-delete] to remove bookmarks (you give it a name and
it removes only the first instance of a bookmark with that name from
the list of bookmarks.)" 
  (interactive (list nil current-prefix-arg)) 
  (unwind-protect 
      (let* ((record (bookmark-make-record))
             ;; `defaults' is a transient element of the
             ;; extensible format described above in the section
             ;; `File format stuff'.  Bookmark record functions
             ;; can use it to specify a list of default values
             ;; accessible via M-n while reading a bookmark name.
             (defaults (bookmark-prop-get record 'defaults)) 
             (default 
               (if (consp defaults) 
                   (car defaults)
                 defaults)))
        (if defaults
            ;; Don't store default values in the record.
            (setq record (assq-delete-all 'defaults record))
          ;; When no defaults in the record, use its first element.
          (setq defaults (car record) default defaults))
        (bookmark-maybe-load-default-file)
        ;; Don't set `bookmark-yank-point' and `bookmark-current-buffer'
        ;; if they have been already set in another buffer. (e.g gnus-art).
        (unless (and bookmark-yank-point 
                     bookmark-current-buffer) 
          (setq bookmark-yank-point (point)) 
          (setq bookmark-current-buffer (current-buffer)))
        (let ((str (or name 
                       (read-from-minibuffer (format "Set bookmark (%s): " default)
                                             ;; nil
                                             (thing-at-point 'symbol)
                                             bookmark-minibuffer-read-name-map nil nil defaults)))) 
          (and (string-equal str "") 
               (setq str default)) 
          (bookmark-store str (cdr record) no-overwrite)

          ;; Ask for an annotation buffer for this bookmark
          (when bookmark-use-annotations 
            (bookmark-edit-annotation str)))) 
    (setq bookmark-yank-point nil) 
    (setq bookmarkbookmark-current-buffer-current-buffer nil)))




(defun load-other-bookmark-file () 
  (interactive) 
  (let (( bookmark-file (read-file-name "Bookmark file: " "~/.emacs.d/bookmark-bak/" nil t))) 
    (message bookmark-file) 
    (if bookmark-default-file 
        (bookmark-save        )) 
    (setq bookmark-default-file bookmark-file) 
    (setq bookmarks-already-loaded nil) 
    (setq bookmark-alist nil) 
    (bookmark-load bookmark-default-file t t)
    ;; (bookmark-bmenu-list)
    )
)



(define-key bookmark-bmenu-mode-map "L" 'load-other-bookmark-file)


(provide 'key-bookmark)
