;; Copyright (C) 2013  Free Software Foundation, Inc.
;;
;; Author: feigo  <feigo.zj@gmail.com>
;; Keywords:
;; Created: 2014-08-20
;; Version: 0.0.1
;; Keywords: jump method

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to
;; the Free Software Foundation,


;; Installation:
;;   Put the jump-c-to-method.el to your load-path.
;;   And add to .emacs: (require 'jump-c-to-method)
;; you can use below or you like
;; (defun c-mode-hook-jump-method ()
;;   (define-key c-mode-base-map (kbd "\C-ci"    ) 'jm-switch-c-method-h-cpp) 
;;   (define-key c-mode-base-map (kbd "\C-cw"    ) 'jm-copy-c-defun-name)
;;   (define-key c-mode-base-map (kbd "\C-co"    ) 'jm-switch-cc-to-h)
;; )
;;
;; (add-hook 'c-mode-common-hook 'c-mode-hook-jump-method)



(require 'thingatpt)


(defun --jm-get-thing-forward (thing &optional arg)
  (let ((bounds (bounds-of-thing-at-point thing))
        (begin )
        (end ))
    (when bounds
      (setq begin (car bounds))
      (setq end (cdr bounds))
      (while (and (not (eobp))
                  (/= arg 1))
        (forward-thing thing)
        (setq bounds (bounds-of-thing-at-point thing))
        (setq end (cdr bounds))
        (setq arg (1- arg))))
    (if (null begin)
        nil
      (cons begin end))))


(defun --jm-get-thing-forward-list ()
  ""
  (let ( beg end)
    (cond ( (looking-at "\\s\(")
            (setq beg (point))
            (forward-sexp )
            (setq end (point))
            (cons beg end)
            )
          ( (looking-back "\\s\)" 1)
            (setq end (point))
            (backward-sexp )
            (setq beg (point))
            (cons beg end)
            )
          (t ;; then test if )
           (with-demoted-errors
             (sp-down-sexp)
             (sp-up-sexp)
             (setq beg (point))
             (backward-sexp )
             (setq end (point))
             (cons beg end))

           ))))

(defun --jm-get-thing-forward-defun ()
  ""
  (let ((oldpoint (point)) beg end)
    (beginning-of-defun)
    (setq beg (point))
    (end-of-defun)
    (setq end (point))
    (while (looking-at "^\n")
      (forward-line 1))
    (if (> (point) oldpoint)
        (progn
          (cons beg end))
      (goto-char oldpoint)
      (end-of-defun)
      (setq end (point))
      (beginning-of-defun)
      (setq beg (point)))
    (cons beg end)
    ))

(defun --jm-test-point-forward (arg) 
  (let ((bounds (bounds-of-thing-at-point arg))) 
    (unless bounds 
      (forward-thing arg 1))))

(defun is-c-file () 
  (let ( b-c-file ext) 
    (setq ext (file-name-extension (buffer-file-name))) 
    (when (string-match ext "h\\|hh\\|hpp|c\\|cc\\|C\\|cpp") 
      (setq b-c-file t))))

(defun is-c-headfile () 
  (let ( bHeadfile ext) 
    (setq ext (file-name-extension (buffer-file-name))) 
    (when (string-match ext "h\\|hh\\|hpp") 
      (setq bHeadfile t))))



(defun get-c-method-name(bheader-file) 
  (let ((bounds  ) beg end method-name is-backquote) 
    (if bheader-file 
        (beginning-of-line) 
      (progn 
        (--jm-test-point-forward 'defun) 
        (goto-char (cdr (--jm-get-thing-forward-defun) )) 
        (c-beginning-of-defun))) 
    (setq bounds (--jm-get-thing-forward-list)) 
    (when bounds 
      (goto-char (cdr bounds)) 
      (forward-symbol -1) 
      (setq bounds (--jm-get-thing-forward 'symbol 1)) 
      (setq method-name 
            (buffer-substring 
             (car bounds) 
             (cdr bounds))) 
      (backward-char 1) 
      (when (looking-at "~")
        ;; (setq is-backquote t)
        (setq method-name (concat "~" method-name)))
      ;; (princ is-backquote)
      )
    method-name))


(defun jm-switch-cc-to-h ()
   (interactive)
   (when (string-match "^\\(.*\\)\\.\\([^.]*\\)$" buffer-file-name)
     (let ((name (match-string 1 buffer-file-name))
 	  (suffix (match-string 2 buffer-file-name)))
       (cond ((string-match suffix "c\\|cc\\|C\\|cpp")
 	     (cond ((file-exists-p (concat name ".h"))
 		    (find-file (concat name ".h"))
 		   )
 		   ((file-exists-p (concat name ".hh"))
 		    (find-file (concat name ".hh"))
 		   )
           ((file-exists-p (concat name ".hpp"))
 		    (find-file (concat name ".hpp"))
 		   )
 	    ))
 	    ((string-match suffix "h\\|hh\\|hpp")
 	    ;; ((string-match suffix "h\\|hh")
 	     (cond ((file-exists-p (concat name ".cc"))
 		    (find-file (concat name ".cc"))
 		   )
 		   ((file-exists-p (concat name ".C"))
 		    (find-file (concat name ".C"))
 		   )
 		   ((file-exists-p (concat name ".cpp"))
 		    (find-file (concat name ".cpp"))
 		   )
 		   ((file-exists-p (concat name ".c"))
 		    (find-file (concat name ".c"))
 		   )))))))


(defun go-c-source-method(bHeadFile) 
  (let ( method-name is-continue (case-fold-search t)) 
    (setq method-name (get-c-method-name bHeadFile)) 
    (princ method-name) 
    (when method-name
      ;; (buftoggle)
      (jm-switch-cc-to-h) 
      (beginning-of-buffer) 
      (if bHeadFile 
          (setq method-name (concat "::"  "\\s-*" method-name "\\s-*" "\(")) 
        (setq method-name (concat "\\s-*" method-name "\\s-*" "\("))) 
      (setq is-continue t) 
      (while (and  is-continue 
                   (search-forward-regexp method-name nil t)) 
        (setq is-continue (point-in-comment))) 
      (unless (point-in-comment) 
        (forward-symbol -1)))))

(defun point-in-comment () 
  "Determine if the point is inside a comment" 
  (let ((syn (syntax-ppss))) 
    (and (nth 8 syn) 
         (not (nth 3 syn)))))

(defun is-comment() 
  (interactive ) 
  (princ (point-in-comment) ))

(defun jm-switch-c-method-h-cpp() 
  (interactive ) 
  (when (is-c-file) 
    (go-c-source-method (is-c-headfile))))



(defun jm-copy-c-defun-name() 
  (interactive ) 
  (save-excursion 
    (when (is-c-file) 
      (let ( bounds method-name  (case-fold-search t))
        (setq method-name (get-c-method-name (is-c-headfile))) 
        (kill-new method-name) 
        (princ method-name)))))

(defun c-mode-hook-jump-method ()
  (define-key c-mode-base-map (kbd "\C-ci"    ) 'jm-switch-c-method-h-cpp) 
  (define-key c-mode-base-map (kbd "\C-cw"    ) 'jm-copy-c-defun-name)
  (define-key c-mode-base-map (kbd "\C-co"    ) 'jm-switch-cc-to-h)
  (define-key c-mode-base-map (kbd "\C-c\C-o"    ) 'expand-member-functions)

)


(add-hook 'c-mode-common-hook 'c-mode-hook-jump-method)


(provide 'jump-c-to-method)
