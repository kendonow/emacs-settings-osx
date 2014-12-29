;;; gtags-z.el --- GNU Global source code tagging system -*- lexical-binding: t; -*-

;; Copyright (C) 2013  Free Software Foundation, Inc.

;; Author: zhsfei
;; Version: 0.6.7
;; Keywords: tools, convenience
;; Created: 2013-10-25
;; URL:

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

;; A package to integrate GNU Global source code tagging system
;; (http://www.gnu.org/software/global) with Emacs.
;;
;; Usage:
;;


;;; Code:

(require 'compilation-mode-x)


(eval-when-compile 
  (require 'cl))
(require 'compile)


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

(eval-and-compile 
  (unless (fboundp 'user-error) 
    (defalias 'user-error 'error)))


;; (defmacro gz--ensure-global-buffer (&rest body)
;;   (declare (indent 0))
;;   `(progn
;;      (or (and (buffer-live-p compilation-last-buffer)
;;               (with-current-buffer compilation-last-buffer
;;                 (derived-mode-p 'gz--global-mode)))
;;          (error "No global buffer found"))
;;      (with-current-buffer compilation-last-buffer ,@body)))


(defvar gz--ring (make-ring 20))

;; (defcustom gz--global-output-format 'grep
;;   "The output format for the 'global' command."
;;   :type '(choice (const path)
;;                  (const ctags)
;;                  (const ctags-x)
;;                  (const grep)
;;                  (const cscope))
;;   :group 'ggtags)

;; (defvar gz--global-error-regexp-alist-alist
;;   (append
;;    '((path "^\\(?:[^/\n]*/\\)?[^ )\t\n]+$" 0)
;;      ;; ACTIVE_ESCAPE	src/dialog.cc	172
;;      (ctags "^\\([^ \t\n]+\\)[ \t]+\\(.*?\\)[ \t]+\\([0-9]+\\)$"
;;             2 3 nil nil 2 (1 font-lock-function-name-face))
;;      ;; ACTIVE_ESCAPE     172 src/dialog.cc    #undef ACTIVE_ESCAPE
;;      (ctags-x "^\\([^ \t\n]+\\)[ \t]+\\([0-9]+\\)[ \t]+\\(\\(?:[^/\n]*/\\)?[^ \t\n]+\\)"
;;               3 2 nil nil 3 (1 font-lock-function-name-face))
;;      ;; src/dialog.cc:172:#undef ACTIVE_ESCAPE
;;      (grep "^\\(.+?\\):\\([0-9]+\\):\\(?:[^0-9\n]\\|[0-9][^0-9\n]\\|[0-9][0-9].\\)"
;;            1 2 nil nil 1)
;;      ;; src/dialog.cc ACTIVE_ESCAPE 172 #undef ACTIVE_ESCAPE
;;      (cscope "^\\(.+?\\)[ \t]+\\([^ \t\n]+\\)[ \t]+\\([0-9]+\\).*\\(?:[^0-9\n]\\|[^0-9\n][0-9]\\|[^:\n][0-9][0-9]\\)$"
;;              1 3 nil nil 1 (2 font-lock-function-name-face)))
;;    compilation-error-regexp-alist-alist))


;; (defcustom gz--global-abbreviate-filename 35
;;   "Non-nil to display file names abbreviated such as '/u/b/env'."
;;   :type '(choice (const :tag "No" nil)
;;                  (const :tag "Always" t)
;;                  integer)
;;   :group 'gz-gtags)

;; (defun gz--abbreviate-files (start end)
;;   (goto-char start)
;;   (let* ((error-re (cdr (assq gz--global-output-format
;;                               gz--global-error-regexp-alist-alist)))
;;          (sub (cadr error-re)))
;;     (when (and gz--global-abbreviate-filename error-re)
;;       (while (re-search-forward (car error-re) end t)
;;         (when (and (or (not (numberp gz--global-abbreviate-filename))
;;                        (> (length (match-string sub))
;;                           gz--global-abbreviate-filename))
;;                    ;; Ignore bogus file lines such as:
;;                    ;;     Global found 2 matches at Thu Jan 31 13:45:19
;;                    (get-text-property (match-beginning sub) 'compilation-message))
;;           (gz--abbreviate-file (match-beginning sub) (match-end sub)))))))

(defun gz--ring-clear () 
  ""
  ;; (interactive)
  ;; (setq rjs-index 0)
  ;; (setq rjs-position-pre-command nil)
  ;; (setq rjs-position-before nil)
  (setq gz--current-mark nil) 
  (while (not (ring-empty-p gz--ring)) 
    (ring-remove gz--ring)))

(defvar gz--find-thing)

(defvar gz--work-src-dir nil)

(defvar gz--global-for-cur-dir t)


;; (defun gz--compile-goto-error-no-select ()
;;   ""
;;   (interactive )
;;   (let ((old-selected-window (selected-window)))
;;     (compile-goto-error)
;;     (select-window old-selected-window)))

;; (defun gz--first-error-no-select ()
;;   ""
;;   (interactive )
;;   (let ((old-selected-window (selected-window)))
;;     (first-error)
;;     (compile-goto-error)

;;     (select-window old-selected-window)))




;; (defun gz--compilation-next-file (n)
;;   (interactive "p")
;;   (compilation-next-file n)
;;   (gz--compile-goto-error-no-select))

;; (defun gz--compilation-previous-file (n)
;;   (interactive "p")
;;   (compilation-previous-file n)
;;   (gz--compile-goto-error-no-select))


(defvar-local gz-current-mark-local nil)
(defvar gz-temp-current-marker nil)

(defvar gz--reuse-buffers nil)
(defvar gz--current-buffer-name nil)

(defun gz-pop-local-mark () 
  " " 
  (interactive) 
  (let ((marker gz-current-mark-local)) 
    (switch-to-buffer (or (marker-buffer marker) 
                          (error 
                           "The marked buffer has been deleted"))) 
    (goto-char (marker-position marker))))
;; (set-marker marker nil nil)))

(defun gz--buffer-name (search-string directory ) 
  (setq gz--current-buffer-name 
        (cond (gz--reuse-buffers "*gz*")
              ;; (regexp (format "*g-z:%s dir:%s*" search-string directory))
              (:else (format "*gz:%s dir:%s*" search-string directory)))))

(defvar gz--global-mode-font-lock-keywords 
  '(("^Global \\(exited abnormally\\|interrupt\\|killed\\|terminated\\)\\(?:.*with code \\([0-9]+\\)\\)?.*"
     (1 'compilation-error) 
     (2 'compilation-error nil t)) 
    ("^Global found \\([0-9]+\\)" (1 compilation-info-face))))
(defun gz--global-filter () 
  "Called from `compilation-filter-hook' (which see)."
  (ansi-color-apply-on-region compilation-filter-start (point)))

(define-compilation-mode gz--global-mode "Global Z" "A mode for showing outputs from gnu global."
  ;; (setq-local compilation-error-regexp-alist
  ;;             (list gz--global-output-format))
  ;; (add-hook 'compilation-start-hook )
  (add-hook 'compilation-start-hook 'gz--handle-start-hook nil t) 
  (setq-local compilation-auto-jump-to-first-error t)
  ;;             ggtags-auto-jump-to-first-match)
  (setq-local compilation-scroll-output 'first-error) 
  (setq-local compilation-disable-input t) 
  (setq-local compilation-always-kill t) 
  (setq-local compilation-error-face 'compilation-info) 
  (setq-local compilation-exit-message-function 'gz--exit-message-function) 
  (setq-local truncate-lines t)

  ;; (jit-lock-register #'gz--abbreviate-files)
  ;; (linum-mode 1)
  (add-hook 'compilation-filter-hook 'gz--global-filter nil 'local) 
  (add-hook 'compilation-finish-functions 'gz--handle-finish-hook nil t)

  ;; (define-key gz--global-mode-map "j" 'gz--compile-goto-error-no-select)
  ;; (define-key gz--global-mode-map "a" 'gz--first-error-no-select)
  ;; ;; (define-key gz--global-mode-map "u" 'gz--next-mark)
  ;; (define-key gz--global-mode-map "p" 'previous-error-no-select)
  ;; (define-key gz--global-mode-map "n" 'next-error-no-select)
  ;; (define-key gz--global-mode-map "\M-n" 'gz--compilation-next-file)
  ;; (define-key gz--global-mode-map "\M-p" 'gz--compilation-previous-file)
  (define-key gz--global-mode-map "K" 'kill-current-mode-buffers-except-current)
  ;; (define-key gz--global-mode-map "t" 'toggle-window-split)
  ;; (define-key gz--global-mode-map "k" 'gz--keep-lines)
  ;; (define-key gz--global-mode-map "f" 'gz--flush-lines)
  ;; (define-key gz--global-mode-map "/" 'gz--lines-undo)
  (define-key gz--global-mode-map "]" 'gz--buffer-next) 
  (define-key gz--global-mode-map "[" 'gz--buffer-prev) 
  (define-key gz--global-mode-map "u" 'gz-pop-local-mark) 
  (define-key gz--global-mode-map "Q" 'gz--buffer-kill-current)
  ;; (define-key gz--global-mode-map "v" 'visible-mode)
  )

(defvar gz--current-mark nil)

;; (defun gz--next-mark (&optional arg)
;;   "Move to the next mark in the tag marker ring."
;;   (interactive)
;;   (or (> (ring-length gz--ring) 1)
;;       (user-error "No %s mark" (if arg "previous" "next")))
;;   (let ((mark (or (and gz--current-mark
;;                        (marker-buffer gz--current-mark)
;;                        (funcall (if arg #'ring-previous #'ring-next)
;;                                 gz--ring gz--current-mark)
;;                        )
;;                   ;; (progn
;;                   ;;   (ring-insert gz--ring (point-marker))
;;                   ;;   (ring-ref gz--ring 0))
;;                   )))
;;     (switch-to-buffer (marker-buffer mark))
;;     (goto-char mark)
;;     (setq gz--current-mark mark)
;;     ))

;; (defun gz--prev-mark ()
;;   (interactive)
;;   (gz--next-mark 'previous))



(defun gz--find-same-grep  (    ) 
  "" 
  (interactive )
  ;; (setq gz--find-thing
  ;;       (read-string
  ;;        prompt
  ;;        (thing-at-point 'symbol)))
  (gz--check-src-directory) 
  (let ( ;; (split-window-preferred-function ggtags-split-window-function)
        (default-directory gz--work-src-dir)) 
    (gz--compilation-start find-arg-str gz--find-thing (gz--global-options))))




(defun gz--compilation-start-same-last ( filter-grep ) 
  (cd default-directory) 
  (setq last-global-command-str (concat last-global-command-str filter-grep)) 
  (compilation-start
   ;; (format "global  %s \"%s\"   %s  " find-type find-thing global-option)
   last-global-command-str 'gz--global-mode 
   `(lambda (mode-name) 
      ,(gz--buffer-name gz--find-thing default-directory )))
  ;; (eval-and-compile
  ;;   (require 'etags))
  (setq gz-temp-current-marker (point-marker)) 
  (ring-insert gz--ring gz-temp-current-marker)

  ;; (ring-insert gz--ring (point-marker))
  )

(defun gz--test-grep  () 
  (interactive) 
  (let (filter-grep) 
    (setq filter-grep (read-string "input grep filter" "| grep -v ")) 
    (gz--compilation-start-same-last filter-grep)))

(defun gz--test-2 () 
  (interactive)
  (let ((current-buffer (current-buffer))) 
    (catch 'done 
      (dolist (buffer (nreverse (buffer-list))) 
        (when (eq (buffer-local-value 'major-mode buffer) 'gz--global-mode) 
          (when (not (eq current-buffer buffer)) 
            (message (buffer-name buffer))

            ;; (bury-buffer current-buffer)
            (switch-to-buffer buffer) 
            (throw 'done nil)))))))



(defun gz--buffer-kill-current () 
  (interactive) 
  (let ((buffer (current-buffer))) 
    (when (eq (buffer-local-value 'major-mode buffer) 'gz--global-mode) 
      (kill-buffer buffer))))

(defun gz--buffer-traversal (&optional to-next) 
  (let ((current-buffer (current-buffer)) 
        (buffer-list (buffer-list))) 
    (unless to-next 
      (setq buffer-list (nreverse buffer-list))) 
    (catch 'done 
      (dolist (buffer buffer-list) 
        (when (eq (buffer-local-value 'major-mode buffer) 'gz--global-mode) 
          (when (not (eq current-buffer buffer))
            ;; (message (buffer-name buffer))
            (setq gz--current-buffer-name (buffer-name buffer)) 
            (when to-next 
              (bury-buffer current-buffer)) 
            (switch-to-buffer buffer) 
            (throw 'done t)))) 
      (message "No gz buffer exist"))))


(defun gz--buffer-next () 
  (interactive) 
  (gz--buffer-traversal  t))


(defun gz--buffer-show-current () 
  (interactive) 
  (if (get-buffer gz--current-buffer-name) 
      (switch-to-buffer gz--current-buffer-name) 
    (gz--buffer-traversal  t)
    ;; (message "No gz buffer exist")
    ))

(defun gz--buffer-prev () 
  (interactive) 
  (gz--buffer-traversal  ))


;; (require 'kill-buffers)

;; (defun kill-mode-buffers-gtags-z ()
;;   (interactive )

;;   (kill-special-mode-buffers-internal major-mode t)
;;   ;; (kill-mode-buffers 'gz--global-mode t)
;; )

;; (defun gz--kill-all-gz-buffers ()
;;   "Kill all gz- buffers."
;;   (interactive)
;;   (gz--ring-clear)
;; ;; (setq gz--ring nil)
;;   (dolist (buffer (buffer-list))
;;     (when (eq (buffer-local-value 'major-mode buffer) 'gz--global-mode)
;;       (kill-buffer buffer))))

;; ;;;###autoload
;; (defun gz--kill-other-gz-buffers ()
;;   "Kill all gz- buffers other than the current buffer."
;;   (interactive)
;;   (let ((current-buffer (current-buffer)))
;;     (dolist (buffer (buffer-list))
;;       (when (and (eq (buffer-local-value 'major-mode buffer) 'gz--global-mode)
;;                  (not (eq buffer current-buffer)))
;;         (kill-buffer buffer)))))


(defvar last-global-command-str nil)

(defun gz--compilation-start ( find-type find-thing global-option ) 
  (cd default-directory) 
  (setq last-global-command-str (format "global  %s \"%s\"   %s  " find-type find-thing
                                        global-option)) 
  (compilation-start
   ;; (format "global  %s \"%s\"   %s  " find-type find-thing global-option)
   last-global-command-str 'gz--global-mode 
   `(lambda (mode-name) 
      ,(gz--buffer-name find-thing default-directory )))
  ;; (eval-and-compile
  ;;   (require 'etags))
  (setq gz-temp-current-marker (point-marker)) 
  (ring-insert gz--ring gz-temp-current-marker))




(defun gz--check-src-directory () 
  (unless gz--work-src-dir 
    (setq gz--work-src-dir (read-directory-name "First Set GTAGS Src Work Dir: " default-directory))))

(defun gz--toggle--global-l () 
  (interactive) 
  (if gz--global-for-cur-dir 
      (progn 
        (setq gz--global-for-cur-dir nil) 
        (message "global -l is toggle off")) 
    (setq gz--global-for-cur-dir t) 
    (message "global -l is toggle on")))

(defun gz--set-work-directory (cs-id) 
  "" 
  (interactive "DGGtags Initial Work Directory: ") 
  (setq gz--work-src-dir cs-id)
  (when (assoc gz--work-src-dir gz--history-dir) 
    (delete gz--work-src-dir gz--history-dir))
  ;; (message "test ==%s"
  ;;         (concat "~/" (file-relative-name gz--work-src-dir (getenv "HOME")))
  ;;         )
  (setq gz--work-src-dir  (fg-change-homepath-to-short gz--work-src-dir))
  ;; (setq gz--work-src-dir (concat "~/" (file-relative-name gz--work-src-dir (getenv "HOME"))))
  (setq gz--history-dir (cons gz--work-src-dir gz--history-dir))
  ;; (message "current gz work dir= %s" gz--work-src-dir)

  ;; (setq ggtags-root-directory nil)
  ;; (ggtags-ensure-root-directory)
  ;; (message "%s" cs-id)
  )


(defun gz--global-options () 
  (concat " -v --result=grep  --color=always --path-style=shorter "
          ;; (and gz--global-has-color " --color")
          ;; (and gz--global-has-path-style " --path-style=shorter")
          (and  gz--global-for-cur-dir 
                " -l")))

(defun gz--find-base-regex (prompt find-arg-str   )
  ""
  ;; (interactive )
  (setq gz--find-thing (read-string prompt (thing-at-point 'symbol)))
  (gz--check-src-directory)
  (let ( ;; (split-window-preferred-function ggtags-split-window-function)
        (default-directory gz--work-src-dir))
    (gz--compilation-start find-arg-str gz--find-thing (gz--global-options))))

(defun gz--find-base (prompt find-arg-str   ) 
  ""
  ;; (interactive )
  (setq gz--find-thing (thing-at-point 'symbol)) 
  (unless gz--find-thing 
    (setq gz--find-thing (read-string prompt ))
    ) 
  (gz--check-src-directory) 
  (let ( ;; (split-window-preferred-function ggtags-split-window-function)
        (default-directory gz--work-src-dir)) 
    (gz--compilation-start find-arg-str gz--find-thing (gz--global-options))))

(defun gz--find-base-qt-str (prompt find-arg-str   string-to-c) 
  ""
  ;; (interactive )
  (let  ((qt-some-str)) 
    (setq qt-some-str (funcall string-to-c (thing-at-point 'symbol))) 
    (setq gz--find-thing (read-string prompt
                                      ;; (string-to-c (thing-at-point 'symbol))
                                      qt-some-str) ) 
    (gz--check-src-directory) 
    (let ( ;; (split-window-preferred-function ggtags-split-window-function)
          (default-directory gz--work-src-dir)) 
      (gz--compilation-start find-arg-str gz--find-thing (gz--global-options)))))


(defvar-local gz--global-exit-status nil)

(defun gz--exit-message-function (_process-status exit-status msg) 
  (setq gz--global-exit-status exit-status) 
  (let ((count 
         (save-excursion 
           (goto-char (point-max)) 
           (if (re-search-backward "^\\([0-9]+\\) \\w+ located" nil t) 
               (string-to-number (match-string 1))
             0)))) 
    (cons 
     (if (> exit-status 0) 
         msg
       (format "found %d %s" count 
               (if (= count 1) 
                   "match"
                 "matches")))
     exit-status)))


(defun gz--handle-start-hook (process) 
  (setq-local gz-current-mark-local gz-temp-current-marker) 
  (linum-mode 1))

(defun gz--handle-finish-hook (buf _how)
  ;; (highlight-regexp  gz--find-thing 'hi-blue)
  )

(defun gz--filter-lines (regexp fun) 
  (when (eq (buffer-local-value 'major-mode (current-buffer)) 'gz--global-mode) 
    (when buffer-undo-list 
      (setq buffer-undo-list nil)) 
    (let (buffer-read-only) 
      (goto-line 6) 
      (funcall fun regexp))))
(defun gz--keep-lines (tokeep) 
  "Only keep result lines that match regexp tokeep" 
  (interactive (list 
                (let (x) 
                  (setq x (read-from-minibuffer "keep lines(Regexp): " nil))))) 
  (setq tokeep (concat tokeep "\\|^\\*\\*\\* .*:$")) 
  (gz--filter-lines tokeep 'keep-lines))

(defun gz--lines-undo () 
  (interactive) 
  (let (buffer-read-only) 
    (undo)))

(defun gz--flush-lines (towash) 
  "Flush lines match regexp towash" 
  (interactive (list 
                (let (x) 
                  (setq x (read-from-minibuffer "flush lines(Regexp): " nil))))) 
  (gz--filter-lines towash 'flush-lines))

(require 'qt-something)


(defvar gz--history-dir nil)

(defun gz--select-history () 
  (interactive) 
  (let (dir ) 
    (setq dir (completing-read "gz- select history directory : " nil ;  gz--history-dir
                               nil nil nil ;; (car (cdr gz--history-dir))
                               ;; current-directory
                               'gz--history-dir gz--work-src-dir)) 
    (when dir

      ;; (setq gz--work-src-dir dir)
      (setq gz--work-src-dir  (fg-change-homepath-to-short dir))

      ;; (concat "~/" (file-relative-name dir (getenv "HOME")))
      ;; ))
      (message "history select =%s"  gz--work-src-dir ))))


(defun gz--regexp-c-macro () 
  "" 
  (interactive ) 
  (gz--find-base-qt-str "gz-tags Input Grep: " "-g" 'string-to-c-macro-define))

(defun gz--regexp-c-class () 
  "" 
  (interactive ) 
  (gz--find-base-qt-str "gz-tags Input Grep: " "-g" 'string-to-c-qt-class))

(defun gz--regexp () 
  "" 
  (interactive ) 
  (gz--find-base-regex "gz-tags Input Grep: " "-g"))


(defun gz--define () 
  "" 
  (interactive ) 
  (gz--find-base "gz-tags Input Define : " "-d"))
(defun gz--reference () 
  "" 
  (interactive ) 
  (gz--find-base "gz-tags Input Define : " "-r"))
(defun gz--symbol () 
  "" 
  (interactive ) 
  (gz--find-base "gz-tags Input Define : " "-s"))
(defun gz--literal () 
  "" 
  (interactive ) 
  (gz--find-base "gz-tags Input Define : " "-g --literal"))

(defun gz--generate-gtags-db () 
  "Generate gtags reference file for global." 
  (interactive) 
  (unless gz--work-src-dir 
    (setq gz--work-src-dir (read-from-minibuffer "directory: " default-directory))) 
  (cd gz--work-src-dir) 
  (message "create GTAGS file at dir=%s, please wait" gz--work-src-dir) 
  (shell-command "/usr/local/bin/gtags --gtagslabel gtags") 
  (message "Finish Generate at dir=%s" gz--work-src-dir))





(define-prefix-command 'ctrl-gz--map)
(global-set-key    "\C-cg" ctrl-gz--map)



(define-key ctrl-gz--map "g" 'gz--generate-gtags-db   )
(define-key ctrl-gz--map "t" 'gz--toggle--global-l    )
(define-key ctrl-gz--map "v" 'gz--set-work-directory  )
(define-key ctrl-gz--map "l" 'gz--select-history      )
(define-key ctrl-gz--map "e" 'gz--regexp              )
(define-key ctrl-gz--map "d" 'gz--define              )
(define-key ctrl-gz--map "r" 'gz--reference           )
(define-key ctrl-gz--map "s" 'gz--symbol              )
(define-key ctrl-gz--map "a" 'gz--literal             )
(define-key ctrl-gz--map "k" 'kill-current-mode-buffers )

(define-key ctrl-gz--map "c" 'gz--regexp-c-class      )
(define-key ctrl-gz--map "m" 'gz--regexp-c-macro      )

(define-key ctrl-gz--map "b" 'gz--buffer-show-current )
(define-key ctrl-gz--map "]" 'gz--buffer-next)
(define-key ctrl-gz--map "[" 'gz--buffer-prev)



(require 'smart-repeat-mode)

(sr-define-alist   '("\C-cgp" "\C-cgn") 
                             '(("n"  next-error  ) 
                               ("p"  previous-error) 
                               ("e"  x-compilation-last-error) 
                               ("a"  first-error)))



;; (setenv "GTAGSLIBPATH"  "~/Qt5.2.0/5.2.0/Src;")


(provide 'gtags-z)
