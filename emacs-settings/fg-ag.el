;;; ag.el --- A front-end for ag ('the silver searcher'), the C ack replacement.

;; Copyright (C) 2013 Wilfred Hughes <me@wilfred.me.uk>
;;
;; Author: Wilfred Hughes <me@wilfred.me.uk>
;; Created: 11 January 2013
;; Version: 0.31

;;; Commentary:

;; Please see README.md for documentation, or read in online at
;; https://github.com/Wilfred/ag.el/#agel

;;; License:

;; This file is not part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(eval-when-compile 
  (require 'cl)) ;; dolist, flet

(eval-when-compile 
  (unless (fboundp 'setq-local) 
    (defmacro setq-local (var val) 
      (list 'set (list 'make-local-variable (list 'quote var)) val)))
  (unless (fboundp 'defvar-local) 
    (defmacro defvar-local (var val &optional docstring) 
      (declare 
       (debug defvar) 
       (doc-string 3)) 
      (list 'progn (list 'defvar var val docstring) 
            (list 'make-variable-buffer-local (list 'quote var))))))

(defcustom ag-executable
  "ag"
  "Name of the ag executable to use."
  :type 'string
  :group 'ag)


;; (defcustom ag-arguments (list "--smart-case" "--nogroup" "--column" "--")
(defcustom ag-arguments (list "--smart-case" "--group" "--column" "--") 
  "Default arguments passed to ag." 
  :type '(repeat (string)) 
  :group 'ag)

(setq ag-arguments (list "--smart-case"  "--noheading"  "--column" "--"))
;; (setq ag-arguments (list "--smart-case" "--group"   "--column" "--"))
;; "--nobreak"
;; "--ackmate"
;; "--nogroup"
;; (setq ag-arguments nil)

(defcustom ag-highlight-search nil 
  "Non-nil means we highlight the current search term in results.

This requires the ag command to support --color-match, which is only in v0.14+" 
  :type 'boolean 
  :group 'ag)

(defcustom ag-reuse-buffers nil 
  "Non-nil means we reuse the existing search results buffer, rather than
creating one buffer per unique search." 
  :type 'boolean 
  :group 'ag)

(defcustom ag-reuse-window nil 
  "Non-nil means we open search results in the same window,
hiding the results buffer." 
  :type 'boolean 
  :group 'ag)


(defvar ag-root-project-dir nil)
(require 'compile)

;; Although ag results aren't exactly errors, we treat them as errors
;; so `next-error' and `previous-error' work. However, we ensure our
;; face inherits from `compilation-info-face' so the results are
;; styled appropriately.
(defface ag-hit-face '((t :inherit compilation-info)) 
  "Face name to use for ag matches." 
  :group 'ag)

(defface ag-match-face '((t :inherit match)) 
  "Face name to use for ag matches." 
  :group 'ag)



(defun ag-dir-is-valid-p (dir) 
  (let ((buff-name (buffer-file-name))) 
    (unless dir 
      (setq dir (read-directory-name "Directory: ")    ))
    ;; (when buff-name
    ;;   (unless (file-in-directory-p buff-name dir)
    ;;     (setq dir (read-directory-name "Directory: ")    )))
    dir))

(defun ag/next-error-function (n &optional reset) 
  "Open the search result at point in the current window or a
different window, according to `ag-open-in-other-window'." 
  (if ag-reuse-window
      ;; prevent changing the window
      ;; (flet
      (cl-flet ((pop-to-buffer (buffer &rest args) 
                               (switch-to-buffer buffer))) 
        (compilation-next-error-function n reset))
    ;; just navigate to the results as normal
    (compilation-next-error-function n reset)))

(define-compilation-mode ag-mode "Ag" "Ag results compilation mode" 
  (let ((smbl  'compilation-ag-nogroup)
        ;; Note that we want to use as tight a regexp as we can to try and
        ;; handle weird file names (with colons in them) as well as possible.
        ;; E.g. we use [1-9][0-9]* rather than [0-9]+ so as to accept ":034:"
        ;; in file names.

        ;; (pttrn '("^\\([^:\n]+?\\):\\([1-9][0-9]*\\):\\([1-9][0-9]*\\):" 1 2 3)))
        (pttrn '("^\\([^:\n]+?\\):\\([1-9][0-9]*\\):\\([1-9][0-9]*\\):" 1 2 3)))
    ;; (pttrn '("^\\([1-9][0-9]*\\):\\([1-9][0-9]*\\):" 1 2 )))
    (set (make-local-variable 'compilation-error-regexp-alist) 
         (list smbl)) 
    (set (make-local-variable 'compilation-error-regexp-alist-alist) 
         (list (cons smbl pttrn)))) 
  (set (make-local-variable 'compilation-error-face) 'ag-hit-face) 
  (set (make-local-variable 'next-error-function) 'ag/next-error-function)

  ;; (set (make-local-variable 'ag-current-mark-local) 'ag-temp-current-marker)
  ;; (setq-local ag-current-mark-local (point-marker))
  (setq-local ag-current-mark-local ag-temp-current-marker) 
  (add-hook 'compilation-finish-functions 'ag-handle-finish-hook nil t)
  (add-hook 'compilation-filter-hook 'ag-filter nil t))

;; (define-key ag-mode-map (kbd "p") 'compilation-previous-error)
;; (define-key ag-mode-map (kbd "n") 'compilation-next-error)
(defun ag-handle-finish-hook (buf _how)
  ;; (highlight-phrase  ggtags-find-name )
  ;; (message "find %s" gz--find-thing)
  ;; (highlight-regexp  gz--find-thing 'hi-blue)
  (beginning-of-buffer)
  ;; (search-forward "default-directory:")
  ;; (insert "\n")
  (linum-mode 1)
  ;; (ring-insert gz--ring (point-marker))
)

;; (defun compile-goto-error-no-select ()
;;   ""
;;   (interactive )
;;   (let ((old-selected-window (selected-window)))
;;     (compile-goto-error)
;;     (select-window old-selected-window)))

;; (defun first-error-no-select ()
;;   ""
;;   (interactive )
;;   (let ((old-selected-window (selected-window)))
;;     (first-error)
;;     (select-window old-selected-window)))



;; (defun ag-compilation-next-file (n)
;;   (interactive "p")
;;   (compilation-next-file n)
;;   ;; (compile-goto-error)
;;   (compile-goto-error-no-select))


;; (defun ag-compilation-previous-file (n)
;;   (interactive "p")
;;   (compilation-previous-file n)
;;   (compile-goto-error-no-select))

;; (define-key ag-mode-map "n" 'next-error-no-select)
;; (define-key ag-mode-map "p" 'previous-error-no-select)
;; (define-key ag-mode-map "\M-n" 'ag-compilation-next-file)
;; (define-key ag-mode-map "\M-p" 'ag-compilation-previous-file)
;; (define-key ag-mode-map "\C-o" 'compile-goto-error)
;; (define-key ag-mode-map "a" 'first-error-no-select)
;; (define-key ag-mode-map "t" 'toggle-window-split)
(define-key ag-mode-map "[" 'ag/buffer-next)
(define-key ag-mode-map "]" 'ag/buffer-prev)
(define-key ag-mode-map "u" 'ag-pop-local-mark)




;; (define-key ag-mode-map "o" 'compile-goto-error-no-select)


;; (define-key ag-mode-map "k" 'ag-keep-lines)
;; (define-key ag-mode-map "k" 'ag-kill-other-buffers)

;; (define-key ag-mode-map "f" 'ag-flush-lines)
;; (define-key ag-mode-map "/" 'ag-filter-lines-undo)
;; (define-key ag-mode-map "o" (lambda () (interactive)
;;                               (compile-goto-error)
;;                               (other-window 1)
;;                               ))



(defvar ag/current-buffer-name nil)

(defun ag/buffer-name (search-string directory regexp) 
  (setq ag/current-buffer-name 
        (cond (ag-reuse-buffers "*ag*") 
              (regexp (format "*ag regexp:%s dir:%s*" search-string directory)) 
              (:else (format "*ag text:%s dir:%s*" search-string directory)))))




(defun ag/buffer-show-current () 
  (interactive) 
  (if (get-buffer ag/current-buffer-name) 
      (switch-to-buffer ag/current-buffer-name) 
    (ag/buffer-traversal  t)))


(defun ag/buffer-traversal (&optional to-next) 
  (let ((current-buffer (current-buffer)) 
        (buffer-list (buffer-list))) 
    (unless to-next 
      (setq buffer-list (nreverse buffer-list))) 
    (catch 'done 
      (dolist (buffer buffer-list) 
        (when (eq (buffer-local-value 'major-mode buffer) 'ag-mode) 
          (when (not (eq current-buffer buffer))
            ;; (message (buffer-name buffer))
            (setq ag/current-buffer-name (buffer-name buffer)) 
            (when to-next 
              (bury-buffer current-buffer)) 
            (switch-to-buffer buffer) 
            (throw 'done t)))) 
      (message "No gz buffer exist"))))


(defun ag/buffer-next () 
  (interactive)
  ;; (x-compilation-mode-traversal (buffer-local-value 'major-mode (current-buffer)) t))
  (ag/buffer-traversal  t))

(defun ag/buffer-prev () 
  (interactive) 
  (ag/buffer-traversal  ))

(defun ag/search (string directory &optional regexp) 
  "Run ag searching for the STRING given in DIRECTORY.
If REGEXP is non-nil, treat STRING as a regular expression." 
  (let ((default-directory (file-name-as-directory directory))
        (truncate-lines t)
        (arguments 
         (if regexp 
             ag-arguments
           (cons "--literal" ag-arguments)))) 
    (if ag-highlight-search 
        (setq arguments (append '("--color" "--color-match" "30;43") arguments)) 
      (setq arguments (append '("--nocolor") arguments)))
    ;; (setq arguments (append '("--all-text") arguments))
    (setq arguments (append '("--path-to-agignore" "~/.ag/cpp.agignore") arguments))


    (unless (file-exists-p default-directory) 
      (error 
       "No such directory %s"
       default-directory))

    (message "arguments=%s " arguments)

    ;; (setq arguments (append (list string) arguments))
    (setq arguments (append arguments (list string) ))
    (setq arguments (append arguments (list "\.") ))
    ;; (setq arguments (append arguments (list default-directory) ))
    ;; (setq arguments (append '("ag") arguments))
    (setq ag-temp-current-marker (point-marker)) 
    ;; (message "string=%s " string)
    (message "arguments=%s " arguments)
    (ring-insert ag-ring-global-mark ag-temp-current-marker)
    ;; (insert "test")
    (compilation-start (mapconcat 'shell-quote-argument
                                  ;; arguments
                                  (append '("ag") arguments ) " ") 'ag-mode 
                                  `(lambda (mode-name) 
                                     ,(ag/buffer-name string directory regexp)))))


;; (defun ag/search (string directory &optional regexp)
;;   "Run ag searching for the STRING given in DIRECTORY.
;; If REGEXP is non-nil, treat STRING as a regular expression."
;;   (let ((default-directory (file-name-as-directory directory))
;;         (arguments (if regexp
;;                        ag-arguments
;;                      (cons "--literal" ag-arguments))))
;;     (if ag-highlight-search
;;         (setq arguments (append '("--color" "--color-match" "30;43") arguments))
;;       (setq arguments (append '("--nocolor") arguments)))
;;     ;; (setq arguments (append '("--all-text") arguments))
;;     (setq arguments (append '("--path-to-agignore" "~/.ag/cpp.agignore") arguments))



;;     (unless (file-exists-p default-directory)
;;       (error "No such directory %s" default-directory))
;;     (compilation-start
;;      (mapconcat 'shell-quote-argument
;;                 (append '("ag") arguments (list string))
;;                 " ")
;;      'ag-mode
;;      `(lambda (mode-name) ,(ag/buffer-name string directory regexp)))))

;; (defvar ag-current-mark nil)

(defvar ag-temp-current-marker nil)
(defvar-local ag-current-mark-local nil)

(defvar ag-ring-global-mark (make-ring 32))

(defun ag-global-next-mark (&optional arg) 
  "Move to the next mark in the tag marker ring." 
  (interactive) 
  (or (> (ring-length ag-ring-global-mark) 1) 
      (user-error "No %s mark" 
                  (if arg 
                      "previous"
                    "next"))) 
  (let ((mark (or (and ag-current-mark 
                       (marker-buffer ag-current-mark) 
                       (funcall 
                        (if arg 
                            #'ring-previous
                          #'ring-next)
                        ag-ring-global-mark ag-current-mark)) 
                  (progn 
                    (ring-insert ag-ring-global-mark (point-marker)) 
                    (ring-ref ag-ring-global-mark 0))))) 
    (switch-to-buffer (marker-buffer mark)) 
    (goto-char mark) 
    (setq ag-current-mark mark)))

(defun ag-global-prev-mark () 
  (interactive) 
  (ag-global-next-mark 'previous))

(defun ag-clear-globl-mark () 
  (interactive) 
  (setq ag-ring-global-mark (make-ring 32)))

(defun ag-pop-local-mark () 
  " " 
  (interactive) 
  (let ((marker ag-current-mark-local)) 
    (switch-to-buffer (or (marker-buffer marker) 
                          (error 
                           "The marked buffer has been deleted"))) 
    (goto-char (marker-position marker))))
;; (set-marker marker nil nil)))


(defun ag/dwim-at-point () 
  "If there's an active selection, return that.
Otherwise, get the symbol at point." 
  (cond ((use-region-p) 
         (buffer-substring-no-properties 
          (region-beginning) 
          (region-end))) 
        ((symbol-at-point) 
         (substring-no-properties (symbol-name (symbol-at-point))))))

(defun ag/longest-string (&rest strings) 
  "Given a list of strings and nils, return the longest string." 
  (let ((longest-string nil)) 
    (dolist (string strings) 
      (cond ((null longest-string) 
             (setq longest-string string)) 
            ((stringp string) 
             (when (< (length longest-string) 
                      (length string)) 
               (setq longest-string string)))))
    longest-string))

(autoload 'vc-git-root "vc-git")
(autoload 'vc-svn-root "vc-svn")
(autoload 'vc-hg-root "vc-hg")

(defun ag/project-root (file-path) 
  "Guess the project root of the given FILE-PATH."
  (or (ag/longest-string (vc-git-root file-path) 
                         (vc-svn-root file-path) 
                         (vc-hg-root file-path)) 
      file-path))

;;;###autoload
(defun ag (string directory) 
  "Search using ag in a given DIRECTORY for a given search STRING,
with STRING defaulting to the symbol under point." 
  (interactive (list (read-from-minibuffer "ag Search string: " (ag/dwim-at-point)) 
                     (read-directory-name "Directory: "))) 
  (setq fg/ag-current-directory directory) 
  (if (assoc fg/ag-current-directory fg/ag-history-dir) 
      (delete fg/ag-current-directory fg/ag-history-dir))
  (setq fg/ag-history-dir (cons fg/ag-current-directory fg/ag-history-dir))
  (ag/search string directory))



(defun ag-regexp (string ) 
  "Search using ag in a given DIRECTORY for a given search STRING,
with STRING defaulting to the symbol under point." 
  (interactive (list (read-from-minibuffer "ag Search string: " (ag/dwim-at-point))
                     ;; (read-directory-name "Directory: ")
                     )) 
  ;; (message string) 
  (setq fg/ag-current-directory (ag-dir-is-valid-p fg/ag-current-directory))
  ;; (unless fg/ag-current-directory
  ;;   (setq fg/ag-current-directory (read-directory-name "Directory: ")    )
  ;;   )
  (ag/search string fg/ag-current-directory t))


(require 'qt-something)

;; (defun string-to-qt-class (str)

;;   ;; (format "class\[^a-z:\]\*%s\[^A-Za-z;:\]" str)
;;   ;; (format "^class\[^a-z:\]\*%s\[^A-Za-z;:$\]" str))
;;   (format "class\[^:\]\*\\b%s\\b\[^;\]" str))
;;   ;; (format "^class\[^a-z:\]\*\\b%s\\b\[^A-Za-z;:$\]" str))

;; (defun string-to-c-macro-define (str)

;;   ;; (format "class\[^a-z:\]\*%s\[^A-Za-z;:\]" str)
;;   ;; (format "^class\[^a-z:\]\*%s\[^A-Za-z;:$\]" str))
;;   (format "\\bdefine\\b.\*\\b%s\\b" str))


(defun ag-regexp-c-class (string ) 
  "Search using ag in a given DIRECTORY for a given search STRING,
with STRING defaulting to the symbol under point." 
  (interactive (list (read-from-minibuffer "ag Search string: " (string-to-c-qt-class
                                                                 (ag/dwim-at-point))
                                           ;; (read-directory-name "Directory: ")
                                           )))
  (setq fg/ag-current-directory (ag-dir-is-valid-p fg/ag-current-directory)) 
  (ag/search string fg/ag-current-directory t))


(defun ag-regexp-c-macro-define (string ) 
  "Search using ag in a given DIRECTORY for a given search STRING,
with STRING defaulting to the symbol under point." 
  (interactive (list (read-from-minibuffer "ag Search string: " (string-to-c-macro-define
                                                                 (ag/dwim-at-point))
                                           ;; (read-directory-name "Directory: ")
                                           )))
  (setq fg/ag-current-directory (ag-dir-is-valid-p fg/ag-current-directory)) 
  (ag/search string fg/ag-current-directory t))


;; ###autoload
(defun ag-regexp-old (string directory) 
  "Search using ag in a given directory for a given regexp." 
  (interactive "sSearch regexp: \nDDirectory: ") 
  (ag/search string directory t))

;;;###autoload

(defun ag-project-string (string) 
  "Guess the root of the current project and search it with ag
for the given regexp."
  ;; (interactive "sSearch regexp: " )
  (interactive (list (read-from-minibuffer "ag Search regexp: " (ag/dwim-at-point)))) 
  (setq ag-root-project-dir (ag-dir-is-valid-p ag-root-project-dir))
  ;; (ag/search regexp (ag/project-root default-directory) t))
  (ag/search string (ag/project-root ag-root-project-dir) ))


;; (defun ag-project (string)
;;   "Guess the root of the current project and search it with ag
;; for the given string."
;;   (interactive (list (read-from-minibuffer "Search string: " (ag/dwim-at-point))))
;;   (ag/search string (ag/project-root default-directory)))

;;;###autoload
(defun ag-project-regexp (regexp) 
  "Guess the root of the current project and search it with ag
for the given regexp."
  ;; (interactive "sSearch regexp: " )
  (interactive (list (read-from-minibuffer "ag Search regexp: " (ag/dwim-at-point))))
  (setq ag-root-project-dir (ag-dir-is-valid-p ag-root-project-dir))

  ;; (ag/search regexp (ag/project-root default-directory) t))
  (ag/search regexp (ag/project-root ag-root-project-dir) t))

(autoload 'symbol-at-point "thingatpt")

;;;###autoload
;; (defalias 'ag-project-at-point 'ag-project)

;;;###autoload
(defun ag-regexp-project-at-point (regexp) 
  "Same as ``ag-regexp-project'', but with the search regexp defaulting
to the symbol under point." 
  (interactive (list (read-from-minibuffer "ag Search regexp: " (ag/dwim-at-point)))) 
  (ag/search regexp (ag/project-root default-directory) t))



;; (require 'kill-buffers)

;; (defun kill-mode-buffers-ag-mode ()
;;   (interactive )
;;   (kill-mode-buffers 'ag-mode t)
;; )

;; ;;;###autoload
;; (defun ag-kill-buffers ()
;;   "Kill all ag-mode buffers."
;;   (interactive)
;;   (dolist (buffer (buffer-list))
;;     (when (eq (buffer-local-value 'major-mode buffer) 'ag-mode)
;;       (kill-buffer buffer))))

;; ;;;###autoload
;; (defun ag-kill-other-buffers ()
;;   "Kill all ag-mode buffers other than the current buffer."
;;   (interactive)
;;   (let ((current-buffer (current-buffer)))
;;     (dolist (buffer (buffer-list))
;;       (when (and (eq (buffer-local-value 'major-mode buffer) 'ag-mode)
;;                  (not (eq buffer current-buffer)))
;;         (kill-buffer buffer)))))

;; Taken from grep-filter, just changed the color regex.
(defun ag-filter () 
  "Handle match highlighting escape sequences inserted by the ag process.
This function is called from `compilation-filter-hook'." 
  (when ag-highlight-search 
    (save-excursion 
      (forward-line 0) 
      (let ((end (point)) beg) 
        (goto-char compilation-filter-start) 
        (forward-line 0) 
        (setq beg (point))
        ;; Only operate on whole lines so we don't get caught with part of an
        ;; escape sequence in one chunk and the rest in another.
        (when (< (point) end) 
          (setq end (copy-marker end))
          ;; Highlight ag matches and delete marking sequences.
          (while (re-search-forward "\033\\[30;43m\\(.*?\\)\033\\[[0-9]*m" end 1) 
            (replace-match (propertize (match-string 1) 'face nil 'font-lock-face 'ag-match-face) t
                           t))
          ;; Delete all remaining escape sequences
          (goto-char beg) 
          (while (re-search-forward "\033\\[[0-9;]*[mK]" end 1) 
            (replace-match "" t t)))))))


(defvar fg/ag-current-directory nil)
(defun fg/ag-set-directory (directory) 
  "" 
  (interactive (list (read-directory-name "Directory: ")))
  (setq fg/ag-current-directory directory)
  (if (assoc fg/ag-current-directory fg/ag-history-dir) 
      (delete fg/ag-current-directory fg/ag-history-dir))

  ;; (setq fg/ag-current-directory (concat "~/" (file-relative-name fg/ag-current-directory (getenv "HOME"))))
  (setq fg/ag-current-directory  (fg-change-homepath-to-short fg/ag-current-directory))
  (setq fg/ag-history-dir (cons fg/ag-current-directory fg/ag-history-dir)) 
  (message "current dir= %s" fg/ag-current-directory))

(defun ag-same (string ) 
  "Search using ag in a given DIRECTORY for a given search STRING,
with STRING defaulting to the symbol under point." 
  (interactive (list (read-from-minibuffer "ag Search string: " (ag/dwim-at-point))
                     ;; (read-directory-name "Directory: ")
                     )) 
  (setq fg/ag-current-directory (ag-dir-is-valid-p fg/ag-current-directory)) 
  (ag/search string fg/ag-current-directory))




(defvar fg/ag-history-dir nil)


(defun fg/ag-select-history () 
  (interactive) 
  (let (dir ) 
    (setq dir (completing-read "ag select history directory : " nil ;  fg/ag-history-dir
                               nil nil nil ;;(car (cdr fg/ag-history-dir))
                               ;; fg/ag-current-directory
                               'fg/ag-history-dir fg/ag-current-directory)) 
    (when dir 
      (setq fg/ag-current-directory  (fg-change-homepath-to-short dir))

      ;; (setq fg/ag-current-directory dir)
      (message "history select =%s" dir))))



;; (defun ag-filter-lines (regexp fun)
;;   ;; (save-excursion
;;     ;; (cscope-display-buffer) ; TODO error handling
;;     (when buffer-undo-list (setq buffer-undo-list nil))
;;     (let (buffer-read-only)
;;       (goto-line 5)
;;       (funcall fun regexp)
;;       ;; (print buffer-undo-list)
;;       ))

;; (defun ag-keep-lines (tokeep)
;;   "Only keep result lines that match regexp tokeep"
;;   (interactive
;;    (list (let (x) (setq x (read-from-minibuffer
;;                            "ag keep lines(Regexp): " nil)))))
;;   (setq tokeep (concat tokeep "\\|^\\*\\*\\* .*:$"))

;;   ;; (ag-filter-lines tokeep 'keep-lines)
;;   (ag-filter-lines tokeep 'keep-lines)
;;   ;; (keep-lines to-)
;; )


;; (defun ag-flush-lines (towash)
;;   "Flush lines match regexp towash"
;;   (interactive
;;    (list (let (x) (setq x (read-from-minibuffer
;;                            "ag flush lines(Regexp): " nil)))))
;;   (ag-filter-lines towash 'flush-lines)
;; )


;; (defun ag-filter-lines-undo ()
;;   (interactive)
;;   (let (buffer-read-only)
;;     (undo)))

;; (defun ag-filter-lines )



;; (add-hook
;;  'compilation-mode-hook
;;  (function
;;   (lambda ()
;;     (insert "testttt")
;;     ;; (setq truncate-lines t)
;; )

;; ))

(defun ag/dired-align-size-column ()
  (beginning-of-line)
  (when (looking-at "^  ")
    (forward-char 2)
    (search-forward " " nil t 4)
    (let* ((size-start (point))
           (size-end (search-forward " " nil t))
           (width (and size-end (- size-end size-start))))
      (when (and size-end
                 (< width 12)
                 (> width 1))
        (goto-char size-start)
        (insert (make-string (- 12 width) ? ))))))

(defun ag/dired-filter (proc string)
  "Filter the output of ag to make it suitable for `dired-mode'."
  (let ((buf (process-buffer proc))
        (inhibit-read-only t))
    (if (buffer-name buf)
        (with-current-buffer buf
          (save-excursion
            (save-restriction
              (widen)
              (let ((beg (point-max)))
                (goto-char beg)
                (insert string)
                (goto-char beg)
                (or (looking-at "^")
                    (progn
                      (ag/dired-align-size-column)
                      (forward-line 1)))
                (while (looking-at "^")
                  (insert "  ")
                  (ag/dired-align-size-column)
                  (forward-line 1))
                (goto-char beg)
                (beginning-of-line)

                ;; Remove occurrences of default-directory.
                (while (search-forward default-directory nil t)
                  (replace-match "" nil t))

                (goto-char (point-max))
                (if (search-backward "\n" (process-mark proc) t)
                    (progn
                      (dired-insert-set-properties (process-mark proc)
                                                   (1+ (point)))
                      (move-marker (process-mark proc) (1+ (point)))))))))
      (delete-process proc))))

(defun ag/escape-pcre (regexp)
  "Escape the PCRE-special characters in REGEXP so that it is
matched literally."
  (let ((alphanum "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))
    (apply 'concat
            (mapcar
             (lambda (c)
               (cond
                ((not (string-match-p (regexp-quote c) alphanum))
                 (concat "\\" c))
                (t c)))
             (mapcar 'char-to-string (string-to-list regexp))))))

(defun ag/dired-sentinel (proc state)
  "Update the status/modeline after the process finishes."
  (let ((buf (process-buffer proc))
        (inhibit-read-only t))
    (if (buffer-name buf)
        (with-current-buffer buf
          (let ((buffer-read-only nil))
            (save-excursion
              (goto-char (point-max))
              (insert "\n  ag " state)
              (forward-char -1)     ;Back up before \n at end of STATE.
              (insert " at " (substring (current-time-string) 0 19))
              (forward-char 1)
              (setq mode-line-process
                    (concat ":" (symbol-name (process-status proc))))
              ;; Since the buffer and mode line will show that the
              ;; process is dead, we can delete it now.  Otherwise it
              ;; will stay around until M-x list-processes.
              (delete-process proc)
              (force-mode-line-update)))
          (run-hooks 'dired-after-readin-hook)
          (message "%s finished." (current-buffer))))))

(defun ag-dired-regexp (dir regexp)
  "Recursively find files in DIR matching REGEXP.
REGEXP should be in PCRE syntax, not Emacs regexp syntax.

The REGEXP is matched against the full path to the file, not
only against the file name.

Results are presented as a `dired-mode' buffer with
`default-directory' being DIR.

See also `find-dired'."
  (interactive "DDirectory: \nsFile regexp: ")
  (let* ((dired-buffers dired-buffers) ;; do not mess with regular dired buffers
         (orig-dir dir)
         (dir (file-name-as-directory (expand-file-name dir)))
         (buffer-name (if ag-reuse-buffers
                          "*ag dired*"
                        (format "*ag dired pattern:%s dir:%s*" regexp dir)))
         (cmd (concat ag-executable " --nocolor -g '" regexp "' "
                      (shell-quote-argument dir)
                      " | grep -v '^$' | sed s/\\'/\\\\\\\\\\'/ | xargs -I '{}' ls "
                      dired-listing-switches " '{}' &")))
    (with-current-buffer (get-buffer-create buffer-name)
      (switch-to-buffer (current-buffer))
      (widen)
      (kill-all-local-variables)
      (if (fboundp 'read-only-mode)
          (read-only-mode -1)
        (setq buffer-read-only nil))
      (let ((inhibit-read-only t)) (erase-buffer))
      (setq default-directory dir)
      (run-hooks 'dired-before-readin-hook)
      (shell-command cmd (current-buffer))
      (insert "  " dir ":\n")
      (insert "  " cmd "\n")
      (dired-mode dir)
      (let ((map (make-sparse-keymap)))
        (set-keymap-parent map (current-local-map))
        (define-key map "\C-c\C-k" 'ag/kill-process)
        (use-local-map map))
      (set (make-local-variable 'dired-sort-inhibit) t)
      (set (make-local-variable 'revert-buffer-function)
           `(lambda (ignore-auto noconfirm)
              (ag-dired-regexp ,orig-dir ,regexp)))
      (if (fboundp 'dired-simple-subdir-alist)
          (dired-simple-subdir-alist)
        (set (make-local-variable 'dired-subdir-alist)
             (list (cons default-directory (point-min-marker)))))
      (let ((proc (get-buffer-process (current-buffer))))
        (set-process-filter proc #'ag/dired-filter)
        (set-process-sentinel proc #'ag/dired-sentinel)
        ;; Initialize the process marker; it is used by the filter.
        (move-marker (process-mark proc) 1 (current-buffer)))
      (setq mode-line-process '(":%s")))))

(defun fg/ag-dired ( pattern)
  "Recursively find files in DIR matching PATTERN.

The PATTERN is matched against the full path to the file, not
only against the file name.

The results are presented as a `dired-mode' buffer with
`default-directory' being DIR.

See also `ag-dired-regexp'."
  (interactive "sFile pattern: ")
  (let (
        (default-directory)
        )
  (setq default-directory (ag-dir-is-valid-p fg/ag-current-directory)) 
  ;; (message default-directory)
  (ag-dired-regexp default-directory (ag/escape-pcre pattern))
)

)




(provide 'fg-ag )

;;; ag.el ends here
