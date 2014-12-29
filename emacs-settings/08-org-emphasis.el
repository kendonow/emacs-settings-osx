




                                        ; for org-mode setting

(setq org-src-fontify-natively t)
(setq org-image-actual-width nil)

(eval-after-load 
    'ox-html
  '(add-to-list 'org-export-filter-final-output-functions 'fan/org-html-produce-inline-html))
(defun fan/org-html-produce-inline-html (string backend info) 
  "replace < to < and > to >" 
  (when (and (org-export-derived-backend-p backend 'html) 
             (string-match "!!!!!" string)) 
    (replace-regexp-in-string (rx  (= 5 "!") 
                                   (group (+? anything)) 
                                   (= 5 "@")) "<\\1>" string)))

(defun org-delete-!!! () 
  (interactive) 
  (goto-char (point-min)) 
  (while (re-search-forward "AAAAA" nil t) 
    (replace-match "<")) 
  (goto-char (point-min)) 
  (while (re-search-forward "BBBBB" nil t) 
    (replace-match ">")))
(add-hook 'org-export-html-final-hook 'org-delete-!!!)
(require 'cl)                           ; for delete*
(defun insert-org-emphasis (begin end char-emphasis) 
  (goto-char end)
  (insert (format "%s " char-emphasis)) 
  (goto-char begin) 
  (insert (format " %s" char-emphasis)))

(defun insert-org-emphasis-~ (begin end ) 
  (interactive "r") 
  (insert-org-emphasis begin end "~"))

(defun insert-org-emphasis-= (begin end ) 
  (interactive "r") 
  (insert-org-emphasis begin end "="))
(defun insert-org-emphasis-* (begin end ) 
  (interactive "r") 
  (insert-org-emphasis begin end "*"))

(defun insert-org-emphasis-/ (begin end ) 
  (interactive "r") 
  (insert-org-emphasis begin end "/"))

(defun insert-org-emphasis-_ (begin end ) 
  (interactive "r") 
  (insert-org-emphasis begin end "_"))

(defun insert-org-emphasis-+ (begin end ) 
  (interactive "r") 
  (insert-org-emphasis begin end "+"))

(defun org-define-key-insert-emphasis ()
  (define-key org-mode-map (kbd "C-z `") 'insert-org-emphasis-~) 
  (define-key org-mode-map (kbd "C-z ~") 'insert-org-emphasis-~) 
  (define-key org-mode-map (kbd "C-z +") 'insert-org-emphasis-+) 
  (define-key org-mode-map (kbd "C-z 1") 'insert-org-emphasis-+) 
  (define-key org-mode-map (kbd "C-z _") 'insert-org-emphasis-_) 
  (define-key org-mode-map (kbd "C-z -") 'insert-org-emphasis-_) 
  (define-key org-mode-map (kbd "C-z =") 'insert-org-emphasis-=) 
  ;; (define-key org-mode-map (kbd "C-z /") 'insert-org-emphasis-/) 
  (define-key org-mode-map (kbd "C-z 8") 'insert-org-emphasis-*))
(defun set-org-emphasis-alist-hook() 
  (setq org-emphasis-alist
        (cons '("+" '(:foreground "red")) 
              (delete* "+" org-emphasis-alist 
                       :key 'car 
                       :test 'equal))) 
  (setq org-emphasis-alist (cons '("=" '(:foreground "green")) 
                                 (delete* "=" org-emphasis-alist 
                                          :key 'car 
                                          :test 'equal)))
  (setq org-emphasis-alist (cons '("_" '(:foreground "gray" )) 
                                 (delete* "_" org-emphasis-alist 
                                          :key 'car 
                                          :test 'equal))) 
  (setq org-emphasis-alist (cons '("~" '( :foreground "#F000FF"  )) 
                                 (delete* "~" org-emphasis-alist 
                                          :key 'car 
                                          :test 'equal)))

  (setq org-emphasis-alist (cons '("/" '(:foreground "#00F0F0")) 
                                 (delete* "/" org-emphasis-alist 
                                          :key 'car 
                                          :test 'equal))) 
  (setq org-emphasis-alist (cons '("*" '(:foreground "#FFFF8D947477" )) 
                                 (delete* "*" org-emphasis-alist 
                                          :key 'car 
                                          :test 'equal))) 
  (org-define-key-insert-emphasis))
(add-hook 'org-mode-hook 'set-org-emphasis-alist-hook)



(provide '08-org-emphasis)
