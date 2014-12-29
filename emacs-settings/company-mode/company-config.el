;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(require 'company)
(add-to-list 'company-backends 'company-gtags)
(add-hook 'c-mode-hook '(lambda () (company-mode)))
(setq company-idle-delay nil)


(defun company-select-next-page ()
  "Select the next candidate in the list."
  (interactive)
  (when (company-manual-begin)
    (company-set-selection (+ 10 company-selection))))

(defun company-select-previous-page ()
  "Select the previous candidate in the list."
  (interactive)
  (when (company-manual-begin)
    (company-set-selection (- company-selection 10))))

(define-key company-active-map (kbd "M-v") 'company-select-previous-page)
(define-key company-active-map (kbd "C-v") 'company-select-next-page)

(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-n") 'company-select-next)


(global-company-mode)
(define-key company-mode-map (kbd "C-\\") 'company-complete)



(global-set-key [(control tab)] 'company-complete) 
(defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))

  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))

  (defun tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
          (if (check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))

  (global-set-key [tab] 'tab-indent-or-complete)

(require 'gtags-update)

(provide 'company-config )

;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
