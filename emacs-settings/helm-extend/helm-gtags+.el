
(require 'helm-gtags)

;; (defcustom helm-gtags-system-directory nil)

(defvar hg--history-dir nil)


(defvar hg--work-src-dir nil)

(defun hg--select-dir-history ()
  (interactive)
  (let (dir )
    (setq dir (completing-read
               "select history directory : "
               nil;  gz--history-dir
               nil
               nil
               (car (cdr hg--history-dir))
               ;; current-directory
               'hg--history-dir
               hg--work-src-dir))
    (when dir
      (setq hg--work-src-dir dir))
    (message "history dir select =%s" dir)))



(defun hg--set-work-directory (cs-id)
  ""
  (interactive "DGGtags Initial Work Directory: ")
  (setq hg--work-src-dir cs-id)


  (if (assoc hg--work-src-dir hg--history-dir)
      (delete hg--work-src-dir hg--history-dir))

  (setq hg--history-dir (cons hg--work-src-dir hg--history-dir))
  (message "current helm-gtags+ work dir= %s" hg--work-src-dir)

  )


(defun helm-gtags-common (srcs)
  (let ((helm-quit-if-no-candidate t)
        (helm-execute-action-at-once-if-one t)
        (buf (get-buffer-create helm-gtags-buffer))
        ;; (dir (helm-gtags-searched-directory))
        (dir hg--work-src-dir)
        (src (car srcs)))
    (when (symbolp src)
      (setq src (symbol-value src)))
    (when (helm-gtags--using-other-window-p)
      (setq helm-gtags-use-otherwin t))
    (helm-attrset 'helm-gtags-base-directory dir src)
    (helm-attrset 'name
                  (format "Searched at %s" (or dir default-directory))
                  src)
    (helm :sources srcs :buffer buf)))



(provide 'helm-gtags+)
