


(require 'nxml-mode)

(require 'smart-repeat-mode)


;; (sr-define-alist '("\C-f" "\C-b")
;;                            '(
;;                              ("\C-b" backward-word)
;;                              ("b" backward-char)
;;                              ("f" forward-char)
;;                              ("\C-f" forward-word)
;;                              ) )

(defun nxml-backward-balanced-item (&optional arg)
  (interactive "p")
  (nxml-forward-balanced-item (- 0 arg))
)

(defun my-nxml-mode-hook()




(sr-define-alist  '("\C-ce" "\C-ca" "\C-cn" "\C-cp") 
    '(
      ;; (("e" "n") nxml-forward-element    ) 
      ;; (("a"  "p")   nxml-backward-element)) 
      ("e" nxml-forward-balanced-item)
      ("a" nxml-backward-balanced-item)
      ;; ("d" nxml-backward-down-element)
      ;; ("b" nxml-down-element)
      ;; ("f" nxml-up-element)
      ;; ("u" nxml-backward-up-element)
      ("n" nxml-forward-balanced-item)
      ("p" nxml-backward-balanced-item)
      )

    nil nxml-mode-map)



(define-key nxml-mode-map (kbd "C-z e")     'er/mark-nxml-containing-element)
(define-key nxml-mode-map (kbd "C-z i")     'er/mark-nxml-inside-element)
(define-key nxml-mode-map (kbd "C-z d")     'er/mark-nxml-tag)

(define-key nxml-mode-map (kbd "C-z l")     'er/mark-nxml-element)
(define-key nxml-mode-map (kbd "M-h")     'er/mark-nxml-element)

)

 (add-hook 'nxml-mode-hook 'my-nxml-mode-hook)


(provide 'key-nxml)
