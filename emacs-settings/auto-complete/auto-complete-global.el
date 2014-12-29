(require 'auto-complete)

(require 'auto-complete-popup+ )

(require 'gtags-update)

(defconst acg/global-not-found-message "global: GTAGS not found.")

(defvar acg/gtags-modes '(c-mode cc-mode c++-mode java-mode))

(defvar acg/global-environment-dbpath '())

(defvar acg/global-complete-list-table nil)

(defvar  acg/global-cur-dbpath nil)


(defun acg/global-get-curdir-path () 
  (let ((cur-dbpath)) 
    (setq cur-dbpath (car (split-string (shell-command-to-string "global -p") "\n"))) 
    (when (string= cur-dbpath acg/global-not-found-message) 
      (setq cur-dbpath nil))
    cur-dbpath))



(defun acg/global-candidate()
  ;; (message "acg/global-candidates")
  (let ((candidates) 
        (cur-dbpath) 
        (environment-dbpath acg/global-environment-dbpath)) 
    (setq cur-dbpath (acg/global-get-curdir-path)) 
    (when cur-dbpath 
      (setq acg/global-cur-dbpath cur-dbpath) 
      (setq environment-dbpath (add-to-list 'environment-dbpath cur-dbpath))) 
    (dolist (db-path environment-dbpath)
      (setq candidates (append candidates (acg/global-candidate-one-dbpath db-path ac-prefix)))) 
    (setq acg/global-complete-list-table    candidates  ))
  ;; (print acg/global-complete-list-table)
)
(defun acg/global-candidate-one-dbpath(dbpath prefix-target) 
  (let (( default-directory dbpath) cmd-str complete-list-table-internal)
    (cd default-directory) 
    (setq cmd-str (format "global -c  %s " prefix-target)) 
    (setq complete-list-table-internal (split-string (shell-command-to-string cmd-str ) "\n"))
    (when (string= acg/global-cur-dbpath dbpath) 
      (setq cmd-str (format "global -cs  %s " prefix-target)) 
      (setq complete-list-table-internal (append (split-string (shell-command-to-string cmd-str )
                                                               "\n"))))
    complete-list-table-internal))

(defface acg/global-candidate-face '((t (:background "lightgray" 
                                                     :foreground "navy"))) 
  "Face for gtags candidate")
(defface acg/global-selection-face '((t (:background "red" 
                                                     :foreground "white"))) 
  "Face for the gtags selected candidate.")
(ac-define-source acg/global '((candidates . acg/global-candidate) 
                               (candidate-face . acg/global-candidate-face) 
                               (selection-face . acg/global-selection-face) 
                               (requires . 2) 
                               (symbol . "gs")))




;; (setq acg/global-environment-dbpath '())


(provide 'auto-complete-global)
