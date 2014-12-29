(defmacro repeat-key-fun (list-fun-2)
  ""
  ( list 'global-set-key (list 'kbd (list 'car list-fun-2) ) 
                  (lambda ( )(interactive )
                          (thing-mark-test-keybinding (list 'cdr, list-fun-2))
                          )
)
)



(defun test-lambda (key-define key-list)
  (message "test lambda")
  ( global-set-key (kbd key-define ) 'key-list)
)
(defmacro repeat-key-fun-5 (list-fun-2)
  ""
  '(let (
        (,key-list (cdr list-fun-2))
        )
  ( list 'global-set-key (list 'kbd (list 'car list-fun-2) ) 
                  (lambda ( )(interactive )
                          ( funcall ,key-list)
                          )
)
))

;; (repeat-key-fun-5 '("C-z p" ) )
(repeat-key-fun-5 '("C-z p" #'test-lambda) )


(defmacro repeat-key-fun-4 (list-fun-2)
  ""
  ( list 'global-set-key (list 'kbd (list 'car list-fun-2) ) 
                  (lambda ( )(interactive )
                          (thing-mark-test-keybinding (list 'cdr list-fun-2))
                          )
)
)
(repeat-key-fun-4 '("C-z p" (?n . forward-list) (?p . backward-list) ))


(defmacro repeat-key-fun-3 (key-define list-fun-2)
  ""
  (list 'global-set-key (list 'kbd (key-define)) 
                  (lambda ( )(interactive )
                          (thing-mark-test-keybinding @list-fun-2)
                          )
                  
)
)


(repeat-key-fun-3 '"C-z p" '((?n . forward-list) (?p . backward-list) ))

(macroexpand '(repeat-key-fun-3 '"C-z p" '((?n . forward-list) (?p . backward-list) )))


(defun repeat-key-fun-2 (list-fun-2)
  ""
  (let (
        (key-define (car list-fun-2) )
        (key-list  (cdr list-fun-2))
        )

    ;; (message (apply #'string key-list))
    (global-set-key (kbd key-define )
                    
                    #'(lambda ((list key-list) )(interactive )
                      (thing-mark-test-keybinding  (list key-list))
                      )
)    ))

(repeat-key-fun-2 '("C-z p"  (?n . forward-list) (?p . backward-list) ))
(macroexpand '(repeat-key-fun-2 '"C-z p" '((?n . forward-list) (?p . backward-list) )))


(defvar key-alist-test-2 nil)
(setq key-alist-test-2 '
      ("C-z n" (?n . forward-list) (?p . backward-list) )
)

(repeat-key-fun  '("C-z p" (?n . forward-list) (?p . backward-list) ))
(macroexpand '(repeat-key-fun  ("C-z p" (?n . forward-list) (?p . backward-list) )))



(macroexpand '(repeat-key-fun-6  "C-z p" '( (?n . forward-list) (?p . backward-list) )))
(macroexpand )

(repeat-key-fun-6  "C-z p" ( (?n . forward-list) (?p . backward-list) ))
(defmacro repeat-key-fun-6 (key-define list-fun-2)
  ""
  (list 'global-set-key (list 'kbd key-define) ;(list 'kbd (list ,key-define) )
        (lambda ( )(interactive )
           ;; (message "112")
                          (list 'thing-mark-test-keybinding  ,list-fun-2))
                          )
                  
)


`(lambda () (interactive)
			  (semantic-symref-symbol ,str))

 ;; (defmacro command-test (&rest body) 
 ;;   '(lambda (interactive) ,@body))

(command-test thing-mark-test-keybinding '(?n . forward-list) (?p . backward-list) )

(macroexpand '(command-test thing-mark-test-keybinding '(?n . forward-list) (?p . backward-list) ))


(command-test  "C-z p" '( (?n . forward-list) (?p . backward-list) ))
 
(defmacro command-test (key-define key-list)
  `(lexical-let* ((key ,key-define)
                  (fun-key ,key-list)
                  )
     (global-set-key (kbd key)) 
                  (lambda ( )(interactive )
                          (thing-mark-test-keybinding fun-key)
                          )
))
       


;; (defun global-setter (arg1 arg2)
;;   (lexical-let ((arg1 arg1) (arg2 arg2))
;;     (global-set-key arg1 (lambda ()
;;                            (interactive)
;;                            (concat "example" arg1 arg2)))))

(setq lexical-binding t)
(defun global-setter (arg1 arg2)
    (global-set-key arg1 (lambda ()
                         (interactive)
                         (next-prev-command  arg2)))
  )

;; (defun global-setter-2 (arg1 arg2)
;;   (lexical-let ((arg1 arg1) (arg2 arg2))

;;     (global-set-key arg1 (lambda ()
;;                          (interactive)
;;                          (next-prev-command  arg2))))
;;   )

;; (global-setter-2  "\C-zp" '( (?n  forward-list) (?p  backward-list) ))
(global-setter  "\C-zp" '( (?n  forward-list) (?p  backward-list) ))


     



