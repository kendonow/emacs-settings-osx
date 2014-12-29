



(defvar astyle-cmd "~/bin/astyle")


(defun astyle-region (pmin pmax) 
  (shell-command-on-region pmin pmax astyle-cmd (current-buffer) t (get-buffer-create
                                                                    "*Astyle Errors*") t))

(defun astyle-this-buffer ()
  (interactive )
  (let ((pos (point)))
    (astyle-region (point-min) (point-max))
    (goto-line (line-number-at-pos pos))
    ;; (goto-char pos)
    ))


(defun astyle-this-region (&optional start end)
  (interactive )
  (let ((pos (point)))

(unless (and start
                   end)
        ;; Get format area.
        (if mark-active
            ;; Get activate mark region.
            (progn
              (setq start (region-beginning))
              (setq end (region-end))
              (deactivate-mark))
          ;; Or get current function.
          (setq start
                (progn
                  (beginning-of-defun)
                  (point)))
          (setq end
                (progn
                  (end-of-defun)
                  (point)))))

    (astyle-region start end)
    (goto-line (line-number-at-pos pos))
    ;; (goto-char pos)
)
)
  ;; (shell-command-on-region pmin pmax
  ;;                          "~/bin/astyle" ;; add options here...
  ;;                          (current-buffer) t
  ;;                          (get-buffer-create "*Astyle Errors*") t)



(provide 'astyle)
