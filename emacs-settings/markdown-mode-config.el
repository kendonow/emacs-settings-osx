(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

 (require 'color-theme-twilight)
;; ;; (require 'color-theme-molokai)

(require 'color-theme-buffer-local)

(defun markdown-common-hook-theme-local () 
  (color-theme-buffer-local 'color-theme-twilight (current-buffer)))
  ;; (color-theme-buffer-local 'color-theme-molokai (current-buffer)))

(add-hook 'markdown-mode-hook 'markdown-common-hook-theme-local)

(unless (fboundp 'ctrl-t-map) 
      (define-prefix-command 'ctrl-t-map) 
)


(defun key-markdown-mode-hook ()

 
  (define-key markdown-mode-map    "\C-ct" ctrl-t-map)


  (sr-define-alist-prefix "\C-c" '(("n" outline-next-visible-heading) 
                                                  ("p" outline-previous-visible-heading) 
                                                  ("f" outline-forward-same-level) 
                                                  ("b" outline-backward-same-level) 
                                                  ("u" outline-up-heading)) nil markdown-mode-map)

  (define-key markdown-mode-map "\C-cal" 'markdown-insert-link) 
  (define-key markdown-mode-map "\C-caL" 'markdown-insert-reference-link-dwim) 
  (define-key markdown-mode-map "\C-cau" 'markdown-insert-uri) 
  (define-key markdown-mode-map "\C-caf" 'markdown-insert-footnote) 
  (define-key markdown-mode-map "\C-caw" 'markdown-insert-wiki-link)
  
  (define-key markdown-mode-map "\C-cii" 'markdown-insert-image) 
  (define-key markdown-mode-map "\C-ciI" 'markdown-insert-reference-image)

  (define-key markdown-mode-map "\C-cth" 'markdown-insert-header-dwim) 
  (define-key markdown-mode-map "\C-ctH" 'markdown-insert-header-setext-dwim) 
  (define-key markdown-mode-map "\C-ct1" 'markdown-insert-header-atx-1) 
  (define-key markdown-mode-map "\C-ct2" 'markdown-insert-header-atx-2) 
  (define-key markdown-mode-map "\C-ct3" 'markdown-insert-header-atx-3) 
  (define-key markdown-mode-map "\C-ct4" 'markdown-insert-header-atx-4) 
  (define-key markdown-mode-map "\C-ct5" 'markdown-insert-header-atx-5) 
  (define-key markdown-mode-map "\C-ct6" 'markdown-insert-header-atx-6) 


  ;; (define-key markdown-mode-map "\C-ct!" 'markdown-insert-header-setext-1) 
  ;; (define-key markdown-mode-map "\C-ct@" 'markdown-insert-header-setext-2)

  (define-key markdown-mode-map "\C-ct9" 'markdown-insert-header-setext-1) 
  (define-key markdown-mode-map "\C-ct0" 'markdown-remove-header)

  (define-key markdown-mode-map "\C-ctb" 'markdown-insert-bold) 
  (define-key markdown-mode-map "\C-cti" 'markdown-insert-italic) 
  (define-key markdown-mode-map "\C-ctc" 'markdown-insert-code) 
  (define-key markdown-mode-map "\C-ctq" 'markdown-insert-blockquote) 
  (define-key markdown-mode-map "\C-ct\C-q" 'markdown-blockquote-region) 
  (define-key markdown-mode-map "\C-ctp" 'markdown-insert-pre) 
  (define-key markdown-mode-map "\C-ct\C-p" 'markdown-pre-region) 
  (define-key markdown-mode-map "\C-cth" 'markdown-insert-hr)



  ;; Element insertion (deprecated)
  (define-key markdown-mode-map "\C-ctr" 'markdown-insert-reference-link-dwim) 
  (define-key markdown-mode-map "\C-ctt" 'markdown-insert-header-setext-1) 
  (define-key markdown-mode-map "\C-cts" 'markdown-insert-header-setext-2)

  ;; Element removal
  (define-key markdown-mode-map (kbd "C-c t k") 'markdown-kill-thing-at-point)
  ;; Promotion, Demotion, Completion, and Cycling
  (define-key markdown-mode-map (kbd "C-c t -") 'markdown-promote) 
  (define-key markdown-mode-map (kbd "C-c t =") 'markdown-demote) 
  (define-key markdown-mode-map (kbd "C-c t ]") 'markdown-complete)
  ;; Following and Jumping
  (define-key markdown-mode-map (kbd "C-c t o") 'markdown-follow-thing-at-point) 
  (define-key markdown-mode-map (kbd "C-c t j") 'markdown-jump)
  ;; Indentation
  (define-key markdown-mode-map (kbd "C-m") 'markdown-enter-key) 
  (define-key markdown-mode-map (kbd "<backspace>") 'markdown-exdent-or-delete) 
  (define-key markdown-mode-map (kbd "C-c t >") 'markdown-indent-region) 
  (define-key markdown-mode-map (kbd "C-c t <") 'markdown-exdent-region)
  ;; Visibility cycling
  (define-key markdown-mode-map (kbd "<tab>") 'markdown-cycle) 
  (define-key markdown-mode-map (kbd "<S-iso-lefttab>") 'markdown-shifttab) 
  (define-key markdown-mode-map (kbd "<S-tab>")  'markdown-shifttab) 
  (define-key markdown-mode-map (kbd "<backtab>") 'markdown-shifttab)
  ;; Header navigation
  (define-key markdown-mode-map (kbd "C-c C-n") 'outline-next-visible-heading) 
  (define-key markdown-mode-map (kbd "C-c C-p") 'outline-previous-visible-heading) 
  (define-key markdown-mode-map (kbd "C-c C-f") 'outline-forward-same-level) 
  (define-key markdown-mode-map (kbd "C-c C-b") 'outline-backward-same-level) 
  (define-key markdown-mode-map (kbd "C-c C-u") 'outline-up-heading)
  ;; Buffer-wide commands

  (define-key markdown-mode-map (kbd "C-c c m") 'markdown-other-window) 
  (define-key markdown-mode-map (kbd "C-c c p") 'markdown-preview) 
  (define-key markdown-mode-map (kbd "C-c c e") 'markdown-export) 
  (define-key markdown-mode-map (kbd "C-c c v") 'markdown-export-and-preview) 
  (define-key markdown-mode-map (kbd "C-c c o") 'markdown-open) 
  (define-key markdown-mode-map (kbd "C-c c w") 'markdown-kill-ring-save) 
  (define-key markdown-mode-map (kbd "C-c c c") 'markdown-check-refs) 
  (define-key markdown-mode-map (kbd "C-c c n") 'markdown-cleanup-list-numbers) 
  (define-key markdown-mode-map (kbd "C-c c ]") 'markdown-complete-buffer)

  ;; List editing
  (define-key markdown-mode-map (kbd "M-<up>") 'markdown-move-up) 
  (define-key markdown-mode-map (kbd "M-<down>") 'markdown-move-down) 
  (define-key markdown-mode-map (kbd "M-<left>") 'markdown-promote) 
  (define-key markdown-mode-map (kbd "M-<right>") 'markdown-demote) 
  (define-key markdown-mode-map (kbd "M-<return>") 'markdown-insert-list-item)

  ;; Movement
  (define-key markdown-mode-map (kbd "M-{") 'markdown-backward-paragraph) 
  (define-key markdown-mode-map (kbd "M-}") 'markdown-forward-paragraph) 
  (define-key markdown-mode-map (kbd "M-n") 'markdown-next-link) 
  (define-key markdown-mode-map (kbd "M-p") 'markdown-previous-link)
  ;; Alternative keys (in case of problems with the arrow keys)

  (define-key markdown-mode-map (kbd "C-c t u") 'markdown-move-up) 
  (define-key markdown-mode-map (kbd "C-c t d") 'markdown-move-down) 
  (define-key markdown-mode-map (kbd "C-c t l") 'markdown-promote) 
  (define-key markdown-mode-map (kbd "C-c t r") 'markdown-demote) 
  (define-key markdown-mode-map (kbd "C-c t m") 'markdown-insert-list-item)
)

(add-hook 'markdown-mode-hook 'key-markdown-mode-hook)


(require 'pandoc-mode)
(add-hook 'markdown-mode-hook 'turn-on-pandoc)

(provide 'markdown-mode-config)
