(defun string-to-c-qt-class (str)
  ;; (format "^class\[^a-z:\]\*\\b%s\\b\[^A-Za-z;:$\]" str))
  ;; (format "class.\*\\b%s\\b\[^;\]" str))
  ;; (format "class\[^:\]\*\\b%s\\b\[^;\]" str))
  ;; (format "class\[\\s-\\]\*\\%s\\b\[\\s-\]\*\[^;\]" str))
  ;; (format "class\[\\s-\]\*\\b%s\\b\[\\s-\]\*\[^;\]" str))
  (format "\\bclass\\b\.\*EXPORT\.\*\\b%s\\b" str))
  ;; (format "\\bclass\\b\.\*\\b%s\\b[^;]+" str))



(defun string-to-c-macro-define (str)

  (format "\\bdefine\\b.\*\\b%s\\b" str))
;; 
;; 
;; ;; (setenv "QTDIR" "~/Qt5.1.1/5.1.1/")
;; (setq qt-base-directory "~/Qt5.1.1/5.1.1/")
;; ;; (setenv "PATH" (concat (concat (getenv "QTDIR") "bin" ) "; " (getenv "PATH")))
;; ;; (setenv "PATH" (concat (concat qt-base-directory "mingw\\bin") ";" (getenv "PATH")))
;; ;; (setenv "PATH" (concat (concat qt-base-directory "Desktop\\Qt\\4.7.3\\mingw\\lib")
;; ;; 		        ";" (getenv "PATH")))
;; 
;; 
;; 
;; (require 'semantic/bovine/c)
;; 
;; (setq qt-source-directory (expand-file-name "Src" 
;; 					    qt-base-directory)
;;       qt-include-directory (expand-file-name "clang_64/include" 
;; 					     qt-base-directory))
;; (add-to-list 'auto-mode-alist (cons qt-source-directory 'c++-mode)) 
;; (add-to-list 'cc-search-directories qt-source-directory)
;; 
;; (add-to-list 'auto-mode-alist (cons qt-include-directory 'c++-mode))
;; (dolist (file (directory-files qt-include-directory))
;;   (let ((path (expand-file-name file qt-include-directory)))
;;     (when (and (file-directory-p path) 
;; 	       (not (or (equal file ".") (equal file ".."))))
;;       (progn
;; 	(semantic-add-system-include path 'c++-mode)
;; 	(add-to-list 'cc-search-directories path)))))
;; 
;; (dolist (file (list "QtCore/qconfig.h" "QtCore/qconfig-dist.h" "QtCore/qconfig-large.h"
;; 		    "QtCore/qconfig-medium.h" "QtCore/qconfig-minimal.h" "QtCore/qconfig-small.h"
;; 		    "QtCore/qglobal.h"))
;;   (add-to-list 'semantic-lex-c-preprocessor-symbol-file (expand-file-name file qt-include-directory)))
;; 


(provide 'qt-something)
