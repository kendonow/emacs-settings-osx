
;;; key-multiple-cursors.el

;; Copyright (C) 2013 feigo.zj

;; Author: feigo.zj <feigo.zj@gmail.com>
;; Keywords: multiple cursors
;; Version: 1.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:



;; (add-to-list 'load-path "~/emacs-setting/expand-region/")
(require 'expand-region)

;; (add-to-list 'load-path "~/emacs-setting/multiple-cursors/")
(require 'multiple-cursors)




(defvar pairs_char nil)
"pairs char"
(setq  pairs_char (string-to-list "\[\]\{\}\(\)" ))

(defvar quote_char nil)
(setq  quote_char (string-to-list "\'\"" ))


(defun current-is-pairs-quotes-char-p() 
  (let ((char (following-char))  ) 
    (memq char  quote_char)))

(defun current-is-pairs-char-p() 
  (let ((char (following-char))  ) 
    (memq char  pairs_char)))



(defun er/mark-inside-pairs-extend ()
  "if current point char is pairs then call outside-pairs/quotes" 
  (interactive) 
  (if (er--point-inside-pairs-p) 
      (if (current-is-pairs-char-p) 
          (er/mark-outside-pairs) 
        (er/mark-inside-pairs)) 
    (if (current-is-pairs-quotes-char-p) 
        (er/mark-outside-quotes) 
      (er/mark-inside-quotes))))

(defun er/mark-inside-quotes-extend () 
  (interactive) 
  (if (er--point-inside-string-p) 
      (if (current-is-pairs-quotes-char-p) 
          (er/mark-outside-quotes) 
        (er/mark-inside-quotes)) 
    (if (current-is-pairs-char-p) 
        (er/mark-outside-pairs) 
      (er/mark-inside-pairs))))



(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)
;; (global-set-key (kbd "C-x SPC")     'set-rectangular-region-anchor)
;; (global-set-key (kbd "C-c SPC")     'set-rectangular-region-anchor)


(define-prefix-command 'ctrl-z-mc)
;; (global-set-key "\C-z" ctrl-z-mc)
(global-set-key (kbd "C-c m") 'ctrl-z-mc)
                                        ;(global-set-key (kbd "C-x c") 'ctrl-z-mc)
;; (global-set-key (kbd "M-z")   'ctrl-z-mc)

(defun mc/edit-paragraph-begin () 
  "" 
  (interactive) 
  (unless mark-active 
    (er/mark-paragraph)) 
  (mc/edit-beginnings-of-lines)
  )

(defun mc/edit-paragraph-end () 
  "" 
  (interactive) 
  (unless mark-active 
    (er/mark-paragraph)) 
  (mc/edit-lines)
  (mc/execute-command-for-all-cursors 'end-of-line)

  ;; (mc/edit-ends-of-lines)
  )


(define-key ctrl-z-mc  " " 'set-rectangular-region-anchor     )

(define-key ctrl-z-mc  "e"   'mc/edit-ends-of-lines)
(define-key ctrl-z-mc  "a"   'mc/edit-beginnings-of-lines)

(define-key ctrl-z-mc  "0"   'er/mark-inside-pairs-extend)
(define-key ctrl-z-mc  "]"   'er/mark-inside-pairs-extend)
(define-key ctrl-z-mc  "'"   'er/mark-inside-quotes-extend)
(define-key ctrl-z-mc  "\""   'er/mark-outside-quotes)

(define-key ctrl-z-mc  "n"   'mc/mark-next-like-this)
(define-key ctrl-z-mc  "p"   'mc/mark-previous-like-this)

(define-key ctrl-z-mc  (kbd "C-n")   'mc/mark-next-like-this)
(define-key ctrl-z-mc  (kbd "C-p")   'mc/mark-previous-like-this)

(define-key ctrl-z-mc  (kbd "C-.") 'mc/mark-all-like-this)








(define-key ctrl-z-mc  "h" 'mc/edit-paragraph-begin)


(define-key ctrl-z-mc  "i"   'mc/insert-numbers)
(define-key ctrl-z-mc  "u"   'mc/sort-regions)
(define-key ctrl-z-mc  "o"   'mc/reverse-regions)




(define-key ctrl-z-mc  "l"   'mc/edit-lines)

(setq mc/edit-lines-empty-lines 'pad)
;; (define-key ctrl-z-mc  "\C-w"   'mc/mark-all-words-like-this)
(define-key ctrl-z-mc  "t"   'mc/mark-more-like-this-extended)

(define-key ctrl-z-mc  "=" 'er/expand-region)
(define-key ctrl-z-mc  "-" 'er/contract-region)
(define-key ctrl-z-mc  "s" 'mc/mark-all-symbols-like-this)
(define-key ctrl-z-mc  "w" 'mc/mark-all-words-like-this)





(global-set-key (kbd "C-'")     'mc/mark-next-like-this)
(global-set-key (kbd "C-;")     'mc/mark-previous-like-this)

(global-set-key (kbd "C-M-'")     'mc/skip-to-next-like-this)
(global-set-key (kbd "C-M-;")     'mc/skip-to-previous-like-this)


;; (global-set-key (kbd "C-M-'")     'mc/unmark-next-like-this)
;; (global-set-key (kbd "C-M-;")     'mc/unmark-previous-like-this)



;; (global-set-key (kbd "M-l")   'mc/edit-lines)


(provide 'key-multiple-cursors)
