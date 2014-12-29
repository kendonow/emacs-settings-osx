;;;
;; Filename: smart-repeat-mode.el
;; Description: Support multi repeat command
;; Author: feigo.zj@gmail.com
;; Maintainer: zhsfei
;; Copyright (C) :2013 zhsfei all rights reserved.
;; Created: :2013-11-29
;; Version: 0.0.2
;; Keywords: multi repeat command

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
;;   Put the smart-repeat-mode.el to your load-path.
;;   And add to .emacs: (require 'smart-repeat-mode)

;; example 1

;; (sr-define-alist  '("\C-l" "\C-cl" )
;;     '(("l" recenter-top-bottom )
;;       ("\C-l"  recenter-top-bottom)
;;       ("b"  (lambda () (interactive) (move-to-window-line (- -1 scroll-margin))))
;;       ("2"  (lambda () (interactive) (move-to-window-line (- -1 scroll-margin))))
;;       ("t"  (lambda () (interactive) (move-to-window-line scroll-margin)))
;;       ("1"  (lambda () (interactive) (move-to-window-line scroll-margin)))
;;       )
;;     )

;; example 2

;; (sr-define-alist  '("\C-ce" "\C-ca")
;;     '((("e" "n") end-of-defun    )
;;       (("a"  "p")   beginning-of-defun)) )

;; example 3

;; (sr-define-alist-prefix "\C-c" '(("p" backward-paragraph) 
;;                                                 ("n" forward-paragraph) 
;;                                                 ("e" end-of-defun    ) 
;;                                                 ("a"   beginning-of-defun) 
;;                                                 ("b" recent-jump-backward    )) )



(defvar smart-repeat-old-key-alist nil)

(defcustom smartrep-mode-line-active-bg (face-background 'highlight) 
  "Background color when smartrep-mode is activated" 
  :type 'string 
  :group 'smart-repeat)

(defcustom smartrep-mode-line-deactive-bg nil ; (face-background 'unhighlight)
  ;; (defcustom smartrep-mode-line-deactive-bg nil
  "Background color when smartrep-mode is deactivated" 
  :type 'string 
  :group 'smart-repeat)

(setq smartrep-mode-line-deactive-bg nil)


(setq smartrep-mode-line-active-bg nil)

;; '(:background "gray24"
;;                                      :foreground "green"))



(defun smart-repeat-close-mode ( ) 
  "close smart repeat mode" 
  (interactive) 
  (smart-repeat-mode -1) 
  (push last-command-event unread-command-events) 
  (set-face-background 'mode-line smartrep-mode-line-deactive-bg) 
  (message "close repeat-mode "))

(defvar smart-repeat-keymap nil)
;; (setq smart-repeat-keymap nil)

(when (or  (string-match "24.3.1" (emacs-version)))
  (unless smart-repeat-keymap 
    (setq smart-repeat-keymap (make-keymap)) 
    (set-char-table-range (nth 1 smart-repeat-keymap) t 'smart-repeat-close-mode)
    (suppress-keymap smart-repeat-keymap )))


(when (or  (string-match "24.4.1" (emacs-version)))
  (unless smart-repeat-keymap 
    (setq smart-repeat-keymap (make-keymap)) 
    (set-char-table-range (nth 1 smart-repeat-keymap) t 'smart-repeat-close-mode)
    ;; (let ((meta-map (make-sparse-keymap)))
    (let ((meta-map (make-keymap)))
      (define-key smart-repeat-keymap (char-to-string meta-prefix-char) meta-map)
      (set-char-table-range (nth 1 meta-map) t 'smart-repeat-close-mode)
      )
    ;; (suppress-keymap smart-repeat-keymap )

    ))


(defun smart-repeat-undefine-last-alist(old-key-alist) 
  "undefine the lastest repeat key map , just define-key to smart-repeat-close-mode" 
  (dolist (key old-key-alist) 
    (let ((key-value (car key))) 
      (if (listp key-value) 
          (dolist (one-key key-value) 
            (define-key smart-repeat-keymap one-key  'smart-repeat-close-mode)) 
        (define-key smart-repeat-keymap key-value  'smart-repeat-close-mode)))))



(defun smart-repeat-define-internal-one-key (key-value fun-value) 
  (when (listp fun-value) 
    (setq fun-value (car fun-value))) 
  (define-key smart-repeat-keymap key-value  fun-value))

(defun smart-repeat-define-internal-alist-key (key-alist key-fun) 
  (dolist  (one-key key-alist) 
    (smart-repeat-define-internal-one-key one-key key-fun)))

(defun smart-repeat-define-internal (key-alist) 
  (dolist (key key-alist) 
    (let ((fun-value (cdr key)) 
          (key-value (car key))) 
      (if (listp key-value) 
          (smart-repeat-define-internal-alist-key key-value fun-value) 
        (smart-repeat-define-internal-one-key key-value fun-value)))))


(defun smart-repeat--get-keychar (char) 
  (if (vectorp char) 
      (aref char 0) 
    (string-to-char char)))



(defun smart-repeat-check-alist-last (key-or-alist event) 
  (let  (foundp ) 
    (dolist (akey key-or-alist) 
      (when (eq event  (smart-repeat--get-keychar akey)) 
        (setq foundp t)))
    foundp))


(defun smart-repeat-check-akey-last-base-key (key-or-alist event) 
  (let  ( (base-key (event-basic-type event) )) 
    (if (eq base-key  (smart-repeat--get-keychar key-or-alist)) 
        t
      nil)))

(defun smart-repeat-check-akey-last (key-or-alist event) 
  (if (eq event  (smart-repeat--get-keychar key-or-alist)) 
      t
    nil))

(defun smart-repeat-check-last-command (alist) 
  (let ( foundFlag-p (event last-command-event) key-or-alist) 
    (setq foundFlag-p nil ) 
    (while (and (not foundFlag-p) 
                (not (null alist))) 
      (setq key-or-alist (caar alist) ) 
      (if (listp key-or-alist) 
          (setq foundFlag-p (smart-repeat-check-alist-last key-or-alist event)) 
        (setq foundFlag-p (smart-repeat-check-akey-last key-or-alist event))) 
      (when foundFlag-p 
        (push last-command-event unread-command-events)) 
      (unless foundFlag-p 
        (setq foundFlag-p (smart-repeat-check-akey-last-base-key key-or-alist event)) 
        (when foundFlag-p
          ;; (push (srm-character-to-event (event-basic-type event)) unread-command-events)
          (push (event-basic-type event) unread-command-events))) 
      (setq alist (cdr alist)))))

(define-minor-mode smart-repeat-mode "" 
  nil
  " sRepeat"
  smart-repeat-keymap 
  :global t)


(defun sr-define-alist ( key-alist fun-alist &optional back-unread keymap) 
  (let ((one-key) ) 
    (unless keymap 
      (setq keymap global-map)) 
    (while (and (not (null key-alist))) 
      (setq one-key (car key-alist)) 
      (sr-define-key  one-key fun-alist back-unread keymap) 
      (setq key-alist (cdr key-alist)))))


(defun sr-define-alist-prefix ( prefx_key fun-alist &optional back-unread keymap)
  (let   ((        key-alist)) 
    (setq key-alist (mapcar 
                     (lambda(x) 
                       (concat prefx_key  (car x)))
                     fun-alist)) 
    (sr-define-alist key-alist fun-alist back-unread keymap)))



(defun sr-process-multi-command (key-alist push-back-read key-last)
  (if smart-repeat-old-key-alist 
      (smart-repeat-undefine-last-alist smart-repeat-old-key-alist)) 
  (smart-repeat-define-internal  key-alist) 
  (setq smart-repeat-old-key-alist key-alist)
  ;; (push (srm-character-to-event (car (last (string-to-list key-last))) ) unread-command-events)
  (push  (car (last (string-to-list key-last)) ) unread-command-events)
  ;; (setq smartrep-mode-line-deactive-bg (face-background 'mode-line))
  (set-face-background 'mode-line smartrep-mode-line-active-bg)
  (smart-repeat-mode 1))

(defun sr-define-key ( key-set alist back-unread keymap) 
  (lexical-let 
      ((key-alist alist) 
       (key-last key-set) 
       (push-back-read (not back-unread))) 
    (define-key keymap key-set 
      (lambda () 
        "sr-define-key  " 
        (interactive) 
        (sr-process-multi-command key-alist push-back-read key-last)))))

(provide 'smart-repeat-mode)
