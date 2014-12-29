;; (add-to-list 'load-path "~/emacs-setting/org-8.2.7b/lisp")
;; (add-to-list 'load-path "~/emacs-setting/org-8.2.7b/contrib/lisp")

(require 'org-indent)

(setq org-html-postamble-format '(("en" "<p class=\"author\">Author: %a (%e)</p>
<p class=\"date\">Date: %T</p>
")))
(require 'org-latex-hack)

(org-babel-do-load-languages 'org-babel-load-languages '((dot . t)))

;(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; (setq org-latex-pdf-process '("xelatex -interaction nonstopmode %b"
;;                               "xelatex -interaction nonstopmode %b"))
(require 'tex-site)
(add-hook 'LaTeX-mode-hook 
          (lambda () 
            (setq TeX-auto-untabify t  ; remove all tabs before saving
                  TeX-engine 'xetex    ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil) 
            (imenu-add-menubar-index) 
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))








(message  "04-org-extend")
(provide '04-org-extend)
