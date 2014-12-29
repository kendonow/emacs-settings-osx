

;(add-to-list 'load-path "~/emacs-setting/auto-complete/")
(require 'auto-complete-config)

(require 'auto-complete-global)

(defun ac-cc-mode-setup ()
  (ac-config-default)
  (setq ac-sources (append '( ac-source-yasnippet ac-source-acg/global  ) ac-sources))
)

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

(setq ac-use-quick-help nil)
(setq ac-quick-help-delay 5)

(setq acg/global-environment-dbpath '("~/Qt5.2.0/5.2.0/Src"))

;; (require 'auto-complete-c-headers)
;; (add-to-list 'ac-sources 'ac-source-c-headers)
;; (add-to-list 'achead:include-directories "~/Qt5.2.0/5.2.0/clang_64/include/")



(provide 'fg-auto-complete-config)
