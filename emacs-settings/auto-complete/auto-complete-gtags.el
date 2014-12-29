(require 'auto-complete)

(defvar ac-gtags-modes
  '(c-mode cc-mode c++-mode java-mode))

(setq ac-ya-gtags-dbpath "~/Qt5.2.0/5.2.0/Src/")
(defvar gtags-list-table nil)
(defun ac-gtags-candidate-test()
  ;; (message ac-prefix)
  (let ((temp default-directory)
        ;; (default-directory ac-ya-gtags-dbpath)
        ;; (gtags-list-table )
        )
      (cd ac-ya-gtags-dbpath)
      (setq gtags-list-table (ac-gtags-candidate))
      ;; (message ac-ya-gtags-dbpath)
      ;; (setq ac-ya-gtags-completion-table
      ;;     (split-string (shell-command-to-string (format "global -c")) "\n"))
      (cd temp)
      ;; (print gtags-list-table)
      gtags-list-table)
  )

(defun ac-gtags-candidate ()
  ;; (message "ac-gtags-candidate")
  ;; (if (memq major-mode ac-gtags-modes)
      (ignore-errors
        (with-temp-buffer
          (when (eq (call-process "global" nil t nil "-ci" ac-prefix) 0)
            (message "call-process")
            (goto-char (point-min))
            (let (candidates)
              (while (and (not (eobp))
                          (push (buffer-substring-no-properties (line-beginning-position) (line-end-position)) candidates)
                          (eq (forward-line) 0)))
              (nreverse candidates))))))
;; )

(defface ac-gtags-candidate-face
  '((t (:background "lightgray" :foreground "navy")))
  "Face for gtags candidate")

(defface ac-gtags-selection-face
  '((t (:background "navy" :foreground "white")))
  "Face for the gtags selected candidate.")


(ac-define-source gtags
  '((candidates . ac-gtags-candidate-test)
    (candidate-face . ac-gtags-candidate-face)
    (selection-face . ac-gtags-selection-face)
    (requires . 2)
    (symbol . "gs")))

;; (defvar ac-source-gtags
;;   '((candidates . ac-gtags-candidate-test)
;;     (candidate-face . ac-gtags-candidate-face)
;;     (selection-face . ac-gtags-selection-face)
;;     (requires . 1)
;;     (symbol . "gs")
;;     )
;;   "Source for gtags.")

(provide 'auto-complete-gtags)
