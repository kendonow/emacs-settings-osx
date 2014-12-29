;;; linked-buffer-asciidoc.el --- asciidoc support for linked-buffer -*- lexical-binding: t -*-

;; This file is not part of Emacs

;; Author: Phillip Lord <phillip.lord@newcastle.ac.uk>
;; Maintainer: Phillip Lord <phillip.lord@newcastle.ac.uk>

;; The contents of this file are subject to the LGPL License, Version 3.0.
;;
;; Copyright (C) 2014, Phillip Lord, Newcastle University
;;
;; This program is free software: you can redistribute it and/or modify it
;; under the terms of the GNU Lesser General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at your
;; option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
;; for more details.
;;
;; You should have received a copy of the GNU Lesser General Public License
;; along with this program. If not, see http://www.gnu.org/licenses/.

;;; Commentary:
;;
;; Links buffers with asciidoc [source] blocks.

;;; Code:
(require 'linked-buffer-block)
(require 'm-buffer)

(defun linked-buffer-asciidoc-commented-new ()
  (linked-buffer-commented-asciidoc-configuration
   "lb-commented-clojure asciidoc"
   :this-buffer (current-buffer)
   :linked-file
   (concat
    (file-name-sans-extension
           (buffer-file-name)) ".adoc")
   :comment ";; "))

(defun linked-buffer-clojure-asciidoc-init ()
  (setq linked-buffer-config
        (linked-buffer-asciidoc-commented-new)))

(defun linked-buffer-asciidoc-uncommented-new ()
  (linked-buffer-uncommented-asciidoc-configuration
   "lb-uncommented-clojure-asciidoc"
   :this-buffer (current-buffer)
   :linked-file
   (concat
    (file-name-sans-extension
     (buffer-file-name)) ".clj")
   :comment ";; "))

(defun linked-buffer-asciidoc-clojure-init ()
  (setq linked-buffer-config
        (linked-buffer-asciidoc-uncommented-new)))

(defclass linked-buffer-commented-asciidoc-configuration
  (linked-buffer-commented-block-configuration)
  ()
  "Linked buffer config for asciidoc and other code.")

(defclass linked-buffer-uncommented-asciidoc-configuration
  (linked-buffer-uncommented-block-configuration)
  ()
  "Linked buffer config for asciidoc and other code")


(defun linked-buffer-splitter (l)
  "Returns a function which for use as a partition predicate.
The returned function returns the first element of L until it is
passed a value higher than the first element, then it returns the
second element and so on."
  #'(lambda (x)
      (when
          (and l
               (< (car l) x))
        (setq l (-drop 1 l)))
      (car l)))

(defun linked-buffer-partition-after-source (l-source l-dots)
  "Given a set of markers l-source, partition the markers in
l-dots.

The source markers represent [source] markers, so we take the
next matches to \"....\" immediately after a [source] marker.
This should remove other \"....\" matches.
"
  (-partition-by
   (linked-buffer-splitter l-source)
   (-drop-while
    (lambda (x)
      (and l-source
           (< x (car l-source))))
    l-dots)))

(defun linked-buffer-block-match-asciidoc
  (conf buffer)
  (let* ((source
          (m-buffer-match-begin buffer
                                ";* *\\[source,\\\(clojure\\|lisp\\\)\\]"))
         ;; this could also be a start of title
         (dots
          (m-buffer-match buffer
                          "^;* *----"))
         (source-start
          (linked-buffer-partition-after-source
           source
           (m-buffer-match-begin
            dots)))
         (source-end
          (linked-buffer-partition-after-source
           source (m-buffer-match-end dots))))
    (when source
      (list
       (-map 'cadr source-start)
       (-map 'car source-end)))))

(defmethod linked-buffer-block-match
  ((conf linked-buffer-commented-asciidoc-configuration) buffer)
  (linked-buffer-block-match-asciidoc conf buffer))

(defmethod linked-buffer-block-match
  ((conf linked-buffer-uncommented-asciidoc-configuration) buffer)
  (linked-buffer-block-match-asciidoc conf buffer))

(defmethod linked-buffer-invert
  ((conf linked-buffer-commented-asciidoc-configuration))
  (let ((rtn
         (linked-buffer-asciidoc-uncommented-new)))
    (oset rtn :that-buffer (linked-buffer-this conf))
    rtn))

(defmethod linked-buffer-invert
  ((conf linked-buffer-uncommented-asciidoc-configuration))
  (let ((rtn
         (linked-buffer-asciidoc-commented-new)))
    (oset rtn :that-buffer (linked-buffer-this conf))
    rtn))

(provide 'linked-buffer-asciidoc)
;;; linked-buffer-asciidoc.el ends here
