(require 'compile)


(defun x-compilation-last-error () 
  (interactive)
  (when 
      (setq next-error-last-buffer (next-error-find-buffer)) 
    (with-current-buffer next-error-last-buffer 
      (goto-char (point-max)) 
      (compilation-previous-error 1) 
      (compile-goto-error)))
)

(defun x-compilation-goto-error-no-select () 
  "" 
  (interactive ) 
  (let ((old-selected-window (selected-window))) 
    (compile-goto-error) 
    (select-window old-selected-window)))

(defun x-compilation-first-error-no-select () 
  "" 
  (interactive ) 
  (let ((old-selected-window (selected-window))) 
    (first-error) 
    (select-window old-selected-window)))


(defun x-compilation-last-error-no-select () 
  (interactive)
  (let ((old-selected-window (selected-window))) 
    (goto-char (point-max)) 
    (compilation-previous-error 1) 
    (compile-goto-error)
    ;; (first-error)
    (select-window old-selected-window)))
;; (ggtags-ensure-global-buffer


;; (defun x-compilation-goto-error-no-select ()
;;   ""
;;   (interactive )
;;   (let ((old-selected-window (selected-window)))
;;     (compile-goto-error)
;;     (select-window old-selected-window)))


(defun x-compilation-next-file (n) 
  (interactive "p") 
  (compilation-next-file n)
  ;; (compile-goto-error)
  (x-compilation-goto-error-no-select))


(defun x-compilation-previous-file (n) 
  (interactive "p") 
  (compilation-previous-file n) 
  (x-compilation-goto-error-no-select))


(defun x-compilation-filter-lines (regexp fun)
  ;; (save-excursion
  ;; (cscope-display-buffer) ; TODO error handling
  (when buffer-undo-list 
    (setq buffer-undo-list nil)) 
  (let (buffer-read-only) 
    (goto-line 5) 
    (funcall fun regexp)
    ;; (print buffer-undo-list)
    ))


(defun x-compilation-keep-lines (tokeep) 
  "Only keep result lines that match regexp tokeep" 
  (interactive (list 
                (let (x) 
                  (setq x (read-from-minibuffer "compilation keep lines(Regexp): " nil))))) 
  (setq tokeep (concat tokeep "\\|^\\*\\*\\* .*:$"))

  ;; (compilation-filter-lines tokeep 'keep-lines)
  (x-compilation-filter-lines tokeep 'keep-lines)
  ;; (keep-lines to-)
  )


(defun x-compilation-flush-lines (towash) 
  "Flush lines match regexp towash" 
  (interactive (list 
                (let (x) 
                  (setq x (read-from-minibuffer "compilation flush lines(Regexp): " nil))))) 
  (x-compilation-filter-lines towash 'flush-lines))


(defun x-compilation-filter-lines-undo () 
  (interactive) 
  (let (buffer-read-only) 
    (undo)))


;; (defun x-compilation-mode-traversal (major-mode-type &optional to-next)
;;   (let ((current-buffer (current-buffer))
;;         (buffer-list (buffer-list)))
;;     (unless to-next
;;       (setq buffer-list (nreverse buffer-list)))
;;     (catch 'done
;;       (dolist (buffer buffer-list)
;;         (when (eq (buffer-local-value 'major-mode buffer) major-mode-type)
;;           (when (not (eq current-buffer buffer))
;;             ;; (setq ag/current-buffer-name (buffer-name buffer))
;;             (when to-next
;;               (bury-buffer current-buffer))
;;             (switch-to-buffer buffer)
;;             (throw 'done t))))
;;       ;; (message "No gz buffer exist")
;; )))

(defun x-compilation-buffer-kill-current () 
  (interactive) 
  (let ((buffer (current-buffer))) 
    (when (derived-mode-p (buffer-local-value 'major-mode buffer) 'compilation-mode) 
      (kill-buffer buffer))))

;; (derived-mode-p (buffer-local-value 'major-mode buffer)))))))
(defun x-compilation-toggle-visible-mode()
  (interactive)
  (if visible-mode
  (visible-mode -1)
  (visible-mode 1)
)
)

(define-key compilation-mode-map "k" 'x-compilation-keep-lines)
(define-key compilation-mode-map "f" 'x-compilation-flush-lines)
(define-key compilation-mode-map "/" 'x-compilation-filter-lines-undo)

(define-key compilation-mode-map "j" 'x-compilation-goto-error-no-select)
(define-key compilation-mode-map "a" 'x-compilation-first-error-no-select)
(define-key compilation-mode-map "e" 'x-compilation-last-error-no-select)
(define-key compilation-mode-map "p" 'previous-error-no-select)
(define-key compilation-mode-map "n" 'next-error-no-select)
(define-key compilation-mode-map "o" 'compile-goto-error)
(define-key compilation-mode-map "v" 'x-compilation-toggle-visible-mode)

(define-key compilation-mode-map "\M-n" 'x-compilation-next-file)
(define-key compilation-mode-map "\M-p" 'x-compilation-previous-file)
(define-key compilation-mode-map "t" 'toggle-window-direction_old)
(define-key compilation-mode-map "Q" 'x-compilation-buffer-kill-current)
;; (define-key compilation-mode-map "e" 'wgrep-change-to-wgrep-mode)
(define-key compilation-mode-map "\C-c\C-e" 'wgrep-change-to-wgrep-mode)

(defun fg-change-homepath-to-short(dir-or-file) 
  (if (eq system-type 'windows-nt) 
      dir-or-file
      (concat "~/" (file-relative-name dir-or-file (getenv "HOME"))))
)


(require 'buffer-extension)

(define-key compilation-mode-map "K" 'kill-current-mode-buffers-except-current)


(provide 'compilation-mode-x)
