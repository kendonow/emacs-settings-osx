
(require 'compilation-mode-x)

(require 'ggtags)

(add-hook 'c-mode-common-hook 
          (lambda () 
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode) 
              (ggtags-mode 1))))


(unless (fboundp 'ctrl-ggtags-global--map) 
  (define-prefix-command 'ctrl-ggtags-global--map) 
  (global-set-key "\C-xg" ctrl-ggtags-global--map))


(define-key ctrl-ggtags-global--map (kbd "o") 'ggtags-find-other-symbol)
(define-key ctrl-ggtags-global--map (kbd "s") 'ggtags-find-other-symbol)
(define-key ctrl-ggtags-global--map (kbd "p") 'ggtags-find-reference)
(define-key ctrl-ggtags-global--map (kbd "r") 'ggtags-find-reference)
(define-key ctrl-ggtags-global--map (kbd "f") 'ggtags-find-file)
(define-key ctrl-ggtags-global--map (kbd "u") 'ggtags-view-tag-history)
(define-key ctrl-ggtags-global--map (kbd "t") 'ggtags-view-tag-history)
(define-key ctrl-ggtags-global--map (kbd "D") 'ggtags-show-definition)
(define-key ctrl-ggtags-global--map (kbd "d") 'ggtags-find-definition)
(define-key ctrl-ggtags-global--map (kbd "e") 'ggtags-find-regex)
(define-key ctrl-ggtags-global--map (kbd "b") 'ggtags-buffer-show-current)



;; (define-key ctrl-ggtags-global--map (kbd "C-c C-g C") 'ggtags-create-tags)

;; (define-key ctrl-ggtags-global--map (kbd "M-,") 'pop-tag-mark)
(define-key ctrl-ggtags-global--map (kbd "u") 'pop-tag-mark)
(setq ggtags-global-window-height nil)


;; (add-to-list 'load-path "~/emacs-setting/helm-1.6.3/")
;; (add-to-list 'load-path "~/emacs-setting/helm-extend/")

(require 'helm-gtags)

(setq-local imenu-create-index-function #'ggtags-build-imenu-index)
(define-key ctrl-ggtags-global--map (kbd "h") 'helm-gtags-find-symbol)
(define-key ctrl-ggtags-global--map (kbd "p") 'helm-gtags-find-pattern)


(define-key ggtags-view-tag-history-mode-map "n" 'next-error-no-select)
(define-key ggtags-view-tag-history-mode-map "p" 'previous-error-no-select)



(defun ggtags-find-regex (pattern &optional invert-match) 
  "Grep for lines matching PATTERN.
Invert the match when called with a prefix arg \\[universal-argument]." 
  (interactive  (list (read-from-minibuffer "ggtags Search regex: " (ag/dwim-at-point)) )) 
  (ggtags-grep pattern invert-match))
  ;; (ggtags-find-tag 'grep (and invert-match 
  ;;                             "--invert-match") "--" (ggtags-quote-pattern pattern)))

;; (setq ggtags-executable-directory nil)

(defun ggtags-buffer-show-current () 
  (interactive) 
  (if (get-buffer ggtags-global-last-buffer) 
      (switch-to-buffer ggtags-global-last-buffer) 
    ))

(provide 'ggtags-config)
