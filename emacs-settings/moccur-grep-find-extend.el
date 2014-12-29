


(defun moccur-grep-find-subdir2 (dir in-mask ex-mask)
  (let ((files (cdr (cdr (directory-files dir t)))) (list) (plist))
    (if (not (moccur-search-file-p dir))
        (setq list nil)
      (dolist (elt files)
        (cond
         ((and
           (not (string-match "^[.]+$" (file-name-nondirectory elt)))
           (file-directory-p elt))
          (setq list (append (moccur-grep-find-subdir2 elt in-mask ex-mask) list)))
         ((string-match "^[.]+$" (file-name-nondirectory elt))
          ())
         ((and (string-match in-mask (file-name-nondirectory elt))
               (or (not ex-mask )
                   (not (string-match ex-mask (file-name-nondirectory elt))))
               )
          (push elt list))
         (t ()))
        (if (not (eq list plist))
            (message "Listing %s ..." (file-name-directory elt)))
        (setq plist list)))
    list))
 
 
 
(defun moccur-grep-find2 (dir inputs)
  (interactive
   (list (moccur-grep-read-directory)
         (moccur-grep-read-regexp moccur-grep-default-mask)))
  (moccur-setup)
  (setq moccur-last-command 'moccur-grep-find2)
 
  (let (regexps
        in-mask ex-mask ;; mask
        (files nil)
        ;;(default-directory dir)
        )
    (setq regexps
          (mapconcat 'concat
                     (if (= 1 (length inputs))
                         inputs
                       (list (nth 0 inputs)) ;; (reverse (cddr (reverse inputs)))
                       )
                     " "))
    (cond
     ((= 1 (length inputs))
      (setq in-mask ".")
      (setq ex-mask nil))
     ((= 2 (length inputs))
      (setq in-mask (nth 1 inputs))
      (setq ex-mask nil))
     (t
      (setq in-mask (nth 1 inputs))
      (setq ex-mask (nth 2 inputs))))
 
 
    (unless (string= "." in-mask)
        (setq in-mask (concat "\\."
                              (mapconcat 'identity
                                         (split-string in-mask ",")
                                         "$\\|\\.")
                              "$" )))
    (if ex-mask
        (setq ex-mask (concat "\\."
                              (mapconcat 'identity
                                         (split-string ex-mask ",")
                                         "$\\|\\.")
                              "$" )))
 
    (message "regexp  : %s" regexps)
    (message "in-mask : %s" in-mask)
    (message "ex-mask : %s" ex-mask)
 
    (message "Listing files...")
    (cond
     ((listp dir)
      (while dir
        (cond
         ((file-directory-p (car dir))
          (setq files (append
                       (reverse (moccur-grep-find-subdir2 (car dir) in-mask ex-mask))
                       files)))
         (t
          (setq files (cons
                       (car dir)
                       files))))
        (setq dir (cdr dir))))
     (t
      (setq files (reverse (moccur-grep-find-subdir2 dir in-mask ex-mask)))))
    (message "Listing files done!")
    (moccur-search-files regexps files)
    ))


(provide 'moccur-grep-find-extend)
