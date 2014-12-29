;;; dired-sort-map.el --- in Dired: press s then s, x, t or n to sort by Size, eXtension, Time or Name

;; Copyright (C) 2002 -> Free Software Foundation, Inc.

;; Inspired by Francis J. Wright's dired-sort-menu.el
;; Authors: Patrick Anderson, Santiago Mejia, Andy Stewart,
;;  Prof. Jayanth R Varma

;; Versions:
;; don't remember
;; 2.2a bundled in NoteMacs
;; 2.2 Add help message suggested by Santiago Mejia
;; 2.3 Precede each switch with " -" as found by Prof. Jayanth R Varma

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;;; Install:
;; Copy this file to a directory in your load path.
;; Execute: M-x eval-buffer :so you don't have to restart.
;; Add the line: (require 'dired-sort-map) : to your .emacs

;;; Todo:
;; (add-hook
;;  'dired-load-hook
;;  '(lambda ()
;;     (progn

;;; Code:
(require 'dired)
(defvar dired-sort-map (make-sparse-keymap))

(define-key dired-mode-map "s" dired-sort-map)


(defun dired-sort-by-size () 
  "sort by Size" 
  (interactive) 
  (dired-sort-other (concat dired-listing-switches " -S")))

(defun dired-sort-by-eXtension () 
  "sort by Size" 
  (interactive) 
  (dired-sort-other (concat dired-listing-switches " -X")))


(defun dired-sort-by-time () 
  "sort by Time" 
  (interactive) 
  (dired-sort-other (concat dired-listing-switches " -t")))


(defun dired-sort-by-name () 
  "sort by Name" 
  (interactive) 
  (dired-sort-other dired-listing-switches))

(defun dired-sort-help () 
  "sort by Name" 
  (interactive) 
    (interactive) 
    (message "s Size; x eXtension; t Time; n Name"))


(define-key dired-sort-map "s" 'dired-sort-by-size)
(define-key dired-sort-map "x" 'dired-sort-by-eXtension)

(define-key dired-sort-map "t" 'dired-sort-by-time)
(define-key dired-sort-map "n" 'dired-sort-by-name)

(define-key dired-sort-map "?" 'dired-sort-help)

(provide 'dired-sort-map)
;;; dired-sort-map.el ends here
