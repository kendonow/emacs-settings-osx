(require 'fg-god-mode )




(add-to-list 'god-exempt-major-modes 'dired-mode)
(add-to-list 'god-exempt-major-modes 'eshell-mode)




;; (define-key god-local-mode-map [remap self-insert-command] 'my-god-mode-self-insert)

;; (defun my-god-mode-self-insert ()
;;   (interactive)
;;   (if (and (bolp)
;;            (eq major-mode 'org-mode))
;;       (call-interactively 'org-self-insert-command)
;;     (call-interactively 'god-mode-self-insert)))



(defun c/god-mode-update-cursor ()
  (let ((limited-colors-p (> 257 (length (defined-colors)))))
    (cond (god-local-mode (progn
                           ;; (set-face-background 'mode-line (if limited-colors-p "white" "#e9e2cb"))
                           ;; (set-face-background 'mode-line-inactive (if limited-colors-p "white" "#e9e2cb"))
                             (set-cursor-color "white")
                            ))
          (t (progn
              ;; (set-face-background 'mode-line (if limited-colors-p "black" "#0a2832"))
              ;; (set-face-background 'mode-line-inactive (if limited-colors-p "black" "#0a2832"))
              )
                             (set-cursor-color "red")
))))


(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      original-cursor-type)))

(add-hook 'god-mode-enabled-hook 'c/god-mode-update-cursor)
(add-hook 'god-mode-disabled-hook 'c/god-mode-update-cursor)

;; (add-hook 'god-mode-enabled-hook 'my-update-cursor)
;; (add-hook 'god-mode-disabled-hook 'my-update-cursor)




(require '08-god-mode-key)

(provide '08-god-mode-setting)
