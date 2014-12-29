
(require 'auto-complete)
(eval-when-compile
  (require 'cl))


(add-to-list 'ac-modes 'graphviz-dot-mode)


(defun graphviz-dot-mode-setup ()
  (setq ac-sources '(
                     ;; ac-source-yasnippet
                     ac-source-dictionary
                     ac-source-words-in-buffer))
  (auto-complete-mode 1)
)

(remove-hook 'graphviz-dot-mode-hook 'graphviz-dot-mode-setup)
(add-hook 'graphviz-dot-mode-hook 'graphviz-dot-mode-setup)
(add-to-list 'ac-dictionary-directories "~/emacs-setting/auto-complete/dict")



(require 'auto-complete-popup+ )

(provide 'auto-complete-dot )

