; Add cmake listfile names to the mode list.
(require 'cmake-mode)

(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))


(autoload 'andersl-cmake-font-lock-activate "andersl-cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'andersl-cmake-font-lock-activate)

;; (autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t)

(provide '08-cmake)

