;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; Easy bookmarks management
;;
;; Author: Anthony Fairchild
;;

;;;; Keymaping examples
;; (global-set-key [(control f2)]  'af-bookmark-toggle )
;; (global-set-key [f2]  'af-bookmark-cycle-forward )
;; (global-set-key [(shift f2)]  'af-bookmark-cycle-reverse )
;; (global-set-key [(control shift f2)]  'af-bookmark-clear-all )

;; Include common lisp stuff
(require 'cl)
(require 'bookmark)

(require 'thingatpt)

;(require 'bookmark+-lit)
;(require 'bookmark+-lit nil t)


(defface af-bookmark-persistent-face
  ;; '((t (:foreground "Yellow" :background "Red")))
  '((t (:foreground "Yellow" :background "DarkBlue")))
  "Face for missing files.")


;; (defface af-bookmakr-persistent-face
;;   '((((class grayscale)
;;       (background light)) (:background "DimGray"))
;;     (((class grayscale)
;;       (background dark))  (:background "LightGray"))

    ;; (((class color)
    ;;   (background light)) (:foreground "White" :background "DarkBlue"))
    ;; (((class color)
    ;;   (background dark))  (:foreground "White" :background "DarkBlue"))

;    (((class color)
;      (background light)) ( :background "DarkBlue"))
;    (((class color)
;      (background dark))  ( :background "DarkBlue"))
;)
;  "Face used to highlight current line if bookmark is persistent."
;  :group 'af-bookmark)


(defvar af-current-bookmark nil)


;setq myStr (buffer-substring startPos endPos)

;;

;;(defun af-copy-line ()
;;
;;  (setq beg (line-beginning-position)) 
;;  (setq end (line-end-position))
;;  (setq mystr (buffer-substring beg end))
;;)
;;

(defun af-copy-a-word ()
 "Copy words at point"
 (setq beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point))) 
	(setq end (progn (forward-word 1) (point))
          )
  (setq mystr (buffer-substring beg end))

)

(defun af-copy-a-symbol ()
 "Copy symbol at point"
 (save-excursion
  (let (    (beg (beginning-of-thing 'symbol))
            (end (progn (forward-symbol 1 ) (end-of-thing 'symbol))))

  (setq mystr (buffer-substring beg end)
        )))
)

(defun af-bookmark-make-name ()
  "makes a bookmark name from the buffer name and cursor position"
;  (let (name (af-copy-a-symbol))

  (let ((seq-name nil))
    ;; (setq seq-name (format "%03d" (length bookmark-alist)))
    
  (concat        seq-name 
                    "--"(af-copy-a-symbol) "--[" (buffer-name (current-buffer))
          "] - " (number-to-string (point) )
  )))


(defun af-bookmark-make-name-old ()
  "makes a bookmark name from the buffer name and cursor position"
  (concat (buffer-name (current-buffer))
          " - " (number-to-string (point))))

;; (defun af-bookmark-toggle ()
;;   "remove a bookmark if it exists, create one if it doesnt exist"
;;   (interactive)
;;   (let ((bm-name (af-bookmark-make-name)))
;;     (if (bookmark-get-bookmark bm-name t)
;;         (progn (bookmark-delete bm-name)
;;                (message "bookmark removed %s" bm-name))
;;       (progn (bookmark-set bm-name)
;;              (setf af-current-bookmark bm-name)
;;              (message "bookmark set %s" bm-name)))))

(defun af-bookmark-toggle ()
  "remove a bookmark if it exists, create one if it doesnt exist"
  (interactive)
  (let ((bm-name (af-bookmark-make-name))
        (bm-overlay (make-overlay (line-beginning-position) (+ 1 (line-end-position))))
        )
    (if (bookmark-get-bookmark bm-name t)
        (progn (bookmark-delete bm-name)
               (delete-overlay bm-overlay)
               (message "bookmark removed %s" bm-name)
               )
      (progn (bookmark-set bm-name)
             (overlay-put bm-overlay 'priority 1)
             (overlay-put bm-overlay  'face 'af-bookmark-persistent-face)
             (setf af-current-bookmark bm-name)
             (message "bookmark set %s" bm-name)))))

(defun af-bookmark-cycle (i)
  "Cycle through bookmarks by i.  'i' should be 1 or -1"
  (if bookmark-alist
      (progn (unless af-current-bookmark
               (setf af-current-bookmark (first (first bookmark-alist))))
             (let ((cur-bm (assoc af-current-bookmark bookmark-alist)))
               (setf af-current-bookmark
                     (if cur-bm
                         (first (nth (mod (+ i (position cur-bm bookmark-alist))
                                          (length bookmark-alist))
                                     bookmark-alist))
                       (first (first bookmark-alist))))
               (bookmark-jump af-current-bookmark)
               ;; Update the position and name of the bookmark.  We
               ;; only need to do this when the bookmark has changed
               ;; position, but lets go ahead and do it all the time
               ;; anyway.
               (bookmark-set-position af-current-bookmark (point))
               (let ((new-name (af-bookmark-make-name)))
                 (bookmark-set-name af-current-bookmark new-name)
                 (setf af-current-bookmark new-name))))
    (message "There are no bookmarks set!")))


(defun af-bookmark-cycle-extend (i)
  "Cycle through bookmarks by i.  'i' should be 1 or -1"
  (if bookmark-alist
      (progn (unless af-current-bookmark
               (setf af-current-bookmark (first (first bookmark-alist))))
             (let ((cur-bm (assoc af-current-bookmark bookmark-alist)))
               (setf af-current-bookmark
                     (if cur-bm
                         (first (nth (mod (+ i (position cur-bm bookmark-alist))
                                          (length bookmark-alist))
                                     bookmark-alist))
                       (first (first bookmark-alist))))
               (bookmark-jump af-current-bookmark)
               ;; Update the position and name of the bookmark.  We
               ;; only need to do this when the bookmark has changed
               ;; position, but lets go ahead and do it all the time
               ;; anyway.
               (bookmark-set-position af-current-bookmark (point))
               
               (let* ((new-name (af-bookmark-make-name))
                     (oldpoint (point))
                     
                     ;; (over-lay-pos-start (progn (beginning-of-line) (point)))
                     ;; (over-lay-pos-end (progn (end-of-line) (point)))

                     ;; (bm-overlay (make-overlay over-lay-pos-start over-lay-pos-end))
                     (bm-overlay (make-overlay (line-beginning-position) (+ 1 (line-end-position))))
                     )
                 ;; (goto-char oldpoint)
                 (overlay-put bm-overlay 'priority 1)
                 (overlay-put bm-overlay  'face 'af-bookmark-persistent-face)
                 ;; (overlay-put (make-overlay over-lay-pos-start over-lay-pos-end) 'prio '(:background "red"))
                 ;; (overlay-put bm-overlay 'face '(:background "red"))

                 (bookmark-set-name af-current-bookmark new-name)
                 (setf af-current-bookmark new-name))))
    (message "There are no bookmarks set!")))




(defun af-bookmark-cycle-forward ()
  "find the next bookmark in the bookmark-alist"
  (interactive)
  (af-bookmark-cycle-extend 1))
(defun af-bookmark-cycle-reverse ()
  "find the next bookmark in the bookmark-alist"
  (interactive)
  (af-bookmark-cycle-extend -1))

(defun af-bookmark-clear-all()
  "clears all bookmarks"
  (interactive)
  (setf bookmark-alist nil)
  (message "bookmark all cleared")
)





(defadvice bookmark-jump (after bookmark-jump activate)
  (let ((latest (bookmark-get-bookmark bookmark)))
    (setq bookmark-alist (delq latest bookmark-alist))
    (add-to-list 'bookmark-alist latest)))




(provide 'easy-bookmark)
