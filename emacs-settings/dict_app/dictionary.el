

(require 'feigo-function)

(defvar dictionary-history-list nil)
(defvar dictionary-history-dir "~/.dict_history/")

(unless (file-exists-p dictionary-history-dir)
  (make-directory dictionary-history-dir)
)

(defun dictionary-buffer-word( word &optional to-history)
  "dictionary.app"
  (let (
        (win (selected-window))
        (coding-system-for-read 'utf-8-mac)
        (coding-system-for-write 'utf-8-mac)
        (split-window-preferred-function
         ;; #'(lambda (window) (split-window (selected-window)  28 'below)))
         ;; #'(lambda (window) (split-window (selected-window)  105 'right)))
         #'(lambda (window) (split-window (selected-window)  92 'right)))
        ;; (split-width-threshold nil)
        (split-height-threshold nil)
        (tmpbuf " * dict-process *")
        (ret))
    (pop-to-buffer tmpbuf nil)
    ;; (pop-to-buffer tmpbuf t)
    (erase-buffer)
    ;; (insert word "\n")
    ;; (beginning-of-buffer)
    ;; (insert "----------------------------------------\n")
    ;; (insert "\n")

    ;; (start-process "dict-process" tmpbuf "/Users/zhangshengfei/emacs-setting/dict_app/dict.py" word)
    (setq ret (call-process "~/dept/learning/emacs/emacs-setting/dict_app/dict.py" nil tmpbuf nil word) )
    (when (and to-history (= ret 0))
      (let (
            (hist_name
             (concat dictionary-history-dir 
                     (format-time-string "%Y-%m-%d" 
                                         (current-time)))    ))
      (append-to-file "----------------------------------------\n" nil hist_name)
      (append-to-file nil nil hist_name)
      )    )   
    (beginning-of-buffer)
    (select-window win)
    ;; (message "ret= %d" ret)    
    ret) 
   )

(defun dictionary-get-no-word()
  (read-string "Dictionary: " )
  )

(defun dictionary-get-word(arg)
  (if arg
      (read-string "Dictionary: " (thing-at-point 'word) )
    (thing-at-point 'word) )
  )



(defun dictionary-buffer-no-word( &optional arg)
  "dictionary buffer"
  (interactive "P")
  (let ( (word (dictionary-get-no-word ))
         (ret-process nil )
         )         
    (setq ret-process (dictionary-buffer-word word t))
    (when (= ret-process 0)
      (progn
      (setq dictionary-history-list (remove word dictionary-history-list))
      (add-to-list 'dictionary-history-list word)   
      )   )    )
  )

(defun dictionary-buffer( &optional arg)
  "dictionary buffer"
  (interactive "P")
  (let ( (word (substring-no-properties (dictionary-get-word arg ) )
               )
         (ret-process nil )
         )
    (setq ret-process (dictionary-buffer-word word t))
    (when (= ret-process 0)
      (progn
      (setq dictionary-history-list (remove word dictionary-history-list))
      (add-to-list 'dictionary-history-list word)   
      )   )    )
  )



(defun dictionary-buffer-history-clear()
  (interactive)
  ;; (setq dictionary-history-index 0)
  (setq dictionary-history-list nil)
  )

;; (defun dictionary-buffer-forward(arg)
;;   (interactive "p")
;;   (if (length dictionary-history-list)
;;       (progn 
;;          ;; (car (nthcdr n list)))
;;         ;; (dictionary-buffer-word (car (last dictionary-history-list)))
;;         (dictionary-buffer-word (car (last dictionary-history-list arg)))
;;         (setq dictionary-history-list 
;;               (append (last dictionary-history-list arg ) 
;;                       (nbutlast dictionary-history-list arg)
;;                       ))
;;         ))
;;   )

(defun dictionary-buffer-forward()
  (interactive)
  (if (length dictionary-history-list)
      (progn 
         ;; (car (nthcdr n list)))
        (dictionary-buffer-word (car (last dictionary-history-list)))
        (setq dictionary-history-list 
              (append (last dictionary-history-list ) 
                      (nbutlast dictionary-history-list )
                      ))
        ))
  )

;; (defun dictionary-buffer-backward(arg )
;;   (interactive "p")
;;   (if (length dictionary-history-list)
;;       (progn 
;;         ;; (dictionary-buffer-word (cadr dictionary-history-list))
;;         (dictionary-buffer-word (nth arg dictionary-history-list))
;;         (setq dictionary-history-list 
;;               (append (nthcdr arg dictionary-history-list ) (list (cadr dictionary-history-list ) )))
;;         ))
;; )

(defun dictionary-buffer-backward()
  (interactive)
  (if (length dictionary-history-list)
      (progn 
        (dictionary-buffer-word (cadr dictionary-history-list))
        (setq dictionary-history-list 
              (append (cdr dictionary-history-list ) (list (car dictionary-history-list ) )))
        ))
)


(defun dictionary ()
  "dictionary.app"
  (interactive)
  (let ((word (if (and transient-mark-mode mark-active)
                  (buffer-substring-no-properties (region-beginning) (region-end))
                (read-string "Dictionary: " (thing-at-point 'word))))
        (cur-buffer (current-buffer))
        (tmpbuf " * dict-process *"))
    (set-buffer (get-buffer-create tmpbuf))
    (erase-buffer)
    (insert word "\n")
    (let ((coding-system-for-read 'utf-8-mac)
          (coding-system-for-write 'utf-8-mac))
      (call-process "/Users/zhangshengfei/emacs-setting/dict_app/dict.py" nil tmpbuf nil word)
;; specify full pass of dict.py
      (let ((str (buffer-substring (point-min) (- (point-max) 2))))
        (set-buffer cur-buffer)
        (popup-tip str :scroll-bar t))
      )))




(defun mac-open-dictionary (the-word)
    "Open Dictionary.app for the-word"
    ;; (interactive "sDictionary Lookup: ")
    (shell-command (concat "open \"dict:///" (replace-regexp-in-string "\"" "\\\\\"" the-word) "\"")))

(defun mac-open-dictionary-word ()
    "Open Dictionary.app for the-word"
    (interactive)
    (mac-open-dictionary (thing-at-point 'word))
)

;; (define-key global-map (kbd "C-c f") 
;;   (lambda ( ) (interactive ) (feigo-repeat-command 'dictionary-buffer-forward)))

;; (define-key global-map (kbd "C-c b") 
;;   (lambda ( ) (interactive ) (feigo-repeat-command 'dictionary-buffer-backward)))

;; (define-key global-map (kbd "C-c u") 'dictionary-buffer-history-clear)

;; (define-key global-map (kbd "C-c d")  'dictionary-buffer)
;; (global-set-key [f5]  'dictionary-buffer)

;; (define-key  global-map  "\C-cw" '(lambda () (interactive) (dictionary-buffer 1)))
;; (define-key  global-map  "\C-c\C-w" '(lambda () (interactive) (dictionary-buffer-no-word 1)))
;; (define-key global-map (kbd "C-c g") 'mac-open-dictionary-word)


(define-prefix-command 'ctrl-c-dict-map)
;; (global-set-key    "\C-cd" ctrl-c-dict-map)
(global-set-key    "\C-cd" ctrl-c-dict-map)
(define-key ctrl-c-dict-map "d"     ' dictionary-buffer )
(define-key ctrl-c-dict-map "g"     ' mac-open-dictionary-word )
(define-key ctrl-c-dict-map "w"     '(lambda () (interactive) (dictionary-buffer 1)))

;; (define-intercept-key (kbd "C-c d") 'dictionary-buffer)
;; (define-key global-map (kbd "C-c d") 'dictionary-buffer)

;; (require 'key-next-prev)

;; (define-key-lexical-3  '("\C-ctb" "\C-ctf") '(
;;        (?b  dictionary-buffer-backward)
;;        (?f  dictionary-buffer-forward)) )

;; (define-key ctrl-c-dict-map "b"        (lambda ( ) (interactive ) (feigo-repeat-command 'dictionary-buffer-backward)))
;; (define-key ctrl-c-dict-map "f"        (lambda ( ) (interactive ) (feigo-repeat-command 'dictionary-buffer-forward)))

(provide 'dictionary)
