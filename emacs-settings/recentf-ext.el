(defvar recentf-ext-version "$Id: recentf-ext.el,v 1.3 2010/05/04 09:06:55 rubikitch Exp $")
(eval-when-compile (require 'cl))
(defgroup recentf-ext nil
  "recentf-ext"
  :group 'emacs)
(require 'recentf)

(recentf-mode 1)

;;; [2009/03/01] (@* "`recentf' as most recently USED files")
(defun recentf-push-buffers-in-frame ()
  (walk-windows
   (lambda (win)
     (let ((bfn (buffer-local-value 'buffer-file-name (window-buffer win))))
       (and bfn (recentf-add-file bfn))))))
(add-to-list 'window-configuration-change-hook 'recentf-push-buffers-in-frame)

;;; [2009/12/24] (@* "`recentf' directory")
(defun recentf-add-dired-directory ()
  (when (and (stringp dired-directory)
             (equal "" (file-name-nondirectory dired-directory)))
    (recentf-add-file dired-directory)))
(add-hook 'dired-mode-hook 'recentf-add-dired-directory)



;(defun recentf-ido-find-file ()
;  "Find a recent file using Ido."
;  (interactive)
;  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
;    (when file
;      (find-file file))))
;
;

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let* ((file-assoc-list
	  (mapcar (lambda (x)
		    (cons (file-name-nondirectory x)
			  x))
		  recentf-list))
	 (filename-list
	  (remove-duplicates (mapcar #'car file-assoc-list)
			     :test #'string=))
	 (filename (ido-completing-read "Choose recent file: "
					filename-list
					nil
					t)))
    (when filename
      (find-file (cdr (assoc filename
			     file-assoc-list))))))

(defun recentf-open-files-compl ()
  (interactive)
  (let* ((all-files recentf-list)
         (tocpl (mapcar (function 
                         (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
         (prompt (append '("File name: ") tocpl))
         (fname (completing-read (car prompt) (cdr prompt) nil nil)))
    (find-file (cdr (assoc-ignore-representation fname tocpl))))) 



(defun files-recent-type (src)
  (interactive)
  (let* ((tocpl (mapcar (lambda (x) (cons (file-name-nondirectory x) x))
                        src))
         (fname (completing-read "File name: " tocpl nil nil)))
    ;; (princ tocpl)
    (when fname
      (find-file (cdr (assoc-string fname tocpl))))))

(defun files-recent-visited ()
  (interactive)
  (files-recent-type recentf-list))
  ;; (files-recent-type file-name-history))



(setq recentf-max-saved-items 999)
;; (global-set-key "\C-c\C-f" 'recentf-ido-find-file)
(global-set-key "\C-c\C-f" 'files-recent-visited)
;; (define-key eshell-command-map "\C-c\C-f" 'files-recent-visited)


;(global-set-key "\C-cr" 'recentf-open-files-compl)
;(global-set-key "\C-cf" 'recentf-open-files-compl)
;; (global-set-key "\C-x\C-r" 'files-recent-visited)
;; (global-set-key "\C-x\C-r" 'recentf-open-files-compl)
;(global-set-key "\C-c\C-f" 'recentf-ido-find-file)


(provide 'recentf-ext)

