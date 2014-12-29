(require 'thingatpt+)
(require 'thing-cmds)

 (require 'smartparens)
;; (require 'thing-opt)




(defvar thing-mark-forward nil)
(defvar thing-mark-current-thing nil)

(defun bound-value (value1 value2 )
  (if (> value1  value2)
      (cons value2 value1)
    (cons value1 value2)))


(defun mark-select-thing-pos (begin end)
  (goto-char begin)
  (push-mark (point) t transient-mark-mode)
  (goto-char end))


(defun get-thing-forward (thing &optional arg)
  ;; (unless (bounds-of-thing-at-point thing)
      ;; (forward-thing thing 1))

  ;; (forward-thing thing)

  (let ((bounds (bounds-of-thing-at-point thing))
        (begin )
        (end ))
    (when bounds
      (setq begin (car bounds))
      (setq end (cdr bounds))
      (while (and (not (eobp))
                  (/= arg 1))
        (forward-thing thing)
        (setq bounds (bounds-of-thing-at-point thing))
        (setq end (cdr bounds))
        (setq arg (1- arg))))
    (if (null begin)
        nil
      (cons begin end))))





(defun mark-thing-forward (thing arg )
  (let (( bounds ;; (get-thing-forward thing arg)
                 )
        (this-cmd  this-command)
        (last-cmd  last-command)
        (begin )
        (end))
    (if  (eq this-cmd last-cmd)
        (forward-thing thing)
      (progn 
        (unless (bounds-of-thing-at-point thing)
          (forward-thing thing 1))
        )
      )
    (setq bounds (get-thing-forward thing arg))

    (setq thing-mark-current-thing thing)
    (when bounds
      (setq begin (car bounds))
      (setq end (cdr bounds))
      (when (or (eq this-cmd last-cmd)
                (region-active-p))
        (setq begin (region-beginning)))
      ;; (mark-select-thing-pos (car bounds ) (cdr bounds))
      (mark-select-thing-pos begin end))))

;; (defun mark-thing-forward-2 (thing get-fun arg )
;;   ;; ( funcall get-fun thing arg)
;;   (let (
;;         ( bounds ( funcall get-fun thing arg))
;;         (this-cmd  this-command)
;;         (last-cmd  last-command)
;;         (begin )
;;         (end)
;;         )
;;     (setq thing-mark-current-thing thing)

;;     (when bounds
;;       (setq begin (car bounds))
;;       (setq end (cdr bounds))
;;       (when (eq this-cmd last-cmd)
;;           (setq begin (region-beginning))
;;           )
;;       ;; (mark-select-thing-pos (car bounds ) (cdr bounds))
;;       (mark-select-thing-pos begin end)
;;       )
;;     ))




(defun thing-mark-symbol ( &optional arg)
  (interactive "p")
  (setq thing-mark-forward t)
  (mark-thing-forward 'symbol arg))


(defun thing-mark-word ( &optional arg)
  (interactive "p")
  ;; (test-point-forward 'word)
  ;; (beginning-of-thing 'word)
  (mark-thing-forward 'word arg))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-thing-forward-string ()
  (let ((ret nil))
    (while (and
            ;; (not ret)
            (not (tap-string-at-point))
            (not (eobp)))
      (search-forward "\"" ))
    (bounds-of-thing-at-point 'string)))



(defun get-thing-forward-block ()
  (let (    (beg )
            (end ))
    (progn
      (smart-goto-match-paren 1)
      (setq beg (point)))
    (progn
      (smart-goto-match-paren 1 )
      (setq end (point)))
    (cons beg end))
  ;; (bounds-of-thing-at-point 'block)
  )

(defun get-thing-forward-list ()
  ""
  (let ( beg end)
    (cond ( (looking-at "\\s\(")
            (setq beg (point))
            (forward-sexp )
            (setq end (point))
            (cons beg end)
            ;; (bounds-of-thing-at-point 'list  )
            )
          ( (looking-back "\\s\)" 1)
            (setq end (point))
            (backward-sexp )
            (setq beg (point))
            ;; (cons beg end)
            (cons  end beg)
            ;; (backward-char)
            ;; (bounds-of-thing-at-point 'list  )
            )
          (t ;; then test if )
           (with-demoted-errors
             (sp-down-sexp)
             (sp-up-sexp)
             (setq beg (point))
             (backward-sexp )
             (setq end (point))
             (cons beg end))

           ))))


(defun get-thing-forward-paragraph ()
  ""
  (let (beg end)
    (forward-paragraph)
    (setq end (point))
    (backward-paragraph )
    (when (= (string-match paragraph-separate (thing-at-point 'line)) 0)
      (forward-line))
    (setq beg (point))
    (cons beg end)))



(defun get-thing-forward-defun ()
  ""
  (let ((oldpoint (point)) beg end)
    (beginning-of-defun)
    (setq beg (point))
    (end-of-defun)
    (setq end (point))
    (while (looking-at "^\n")
      (forward-line 1))
    (if (> (point) oldpoint)
        (progn
          (cons beg end))
      (goto-char oldpoint)
      (end-of-defun)
      (setq end (point))
      (beginning-of-defun)
      (setq beg (point)))
    (cons beg end)
    ;; (re-search-backward "^\n" (- (point) 1) t))
    ))

(defun thing-mark-string()
  (interactive)
  (let ((bounds (get-thing-forward-string) ) beg end)
    (setq thing-mark-current-thing 'string)
    (if (eq this-command last-command)
        (progn
          ;; (setq beg (min (region-beginning) (region-end)))
          (forward-string-2)
          (setq bounds (get-thing-forward-string) )))
    (mark-select-thing-pos (car bounds)
                           (cdr bounds))))


(defun thing-parenthesis-jump()
  (interactive)
  (let ((old-point (point))
        (bounds (get-thing-forward-list )))
    (when bounds
      (cond ( (= (car bounds) old-point)
              (goto-char (cdr bounds))       )
            ( (= (cdr bounds) old-point)
              (goto-char (car bounds))       )
            ( (< (car bounds) old-point)
              (goto-char (car bounds))       )
            ( (> (car bounds) old-point)
              (goto-char (car bounds))       )
            (t (message "no do"))))))

(defvar thing-mark-list-bound nil)

(defun thing-mark-list-outer()
  (interactive)
  (let ((bounds  ) beg end)
    (when (eq this-command last-command)
      ;; (ignore-errors
      (condition-case nil
          (up-list)
        (error
         "no up-list again ")))
    (if thing-mark-list-bound
        (setq bounds thing-mark-list-bound)
      (setq bounds (get-thing-forward-list) )
      )
    (setq thing-mark-current-thing 'list)
    (when bounds
      (mark-select-thing-pos (- (car bounds) 1)
                             (+ (cdr bounds) 1)))))

(defun thing-mark-list()
  (interactive)
  (let ((bounds  ) beg end)
    (when (eq this-command last-command)
      ;; (ignore-errors
      (condition-case nil
          (up-list)
        (error
         "no up-list again ")))
    (setq bounds (get-thing-forward-list) )
    (setq thing-mark-current-thing 'list)
    (when bounds
      (setq thing-mark-list-bound bounds)
      (mark-select-thing-pos (car bounds)
                             (cdr bounds)))))


;; thing-mark-with-backward

;; (defun thing-mark-paragraph-with-backward()
;;   (interactive)
;;   (let ((bounds (get-thing-forward-paragraph) )
;;         (this-cmd  this-command)
;;         (last-cmd  last-command) beg end)
;;     (setq thing-mark-current-thing 'paragraph)

;;     (when bounds
;;       (setq beg (car bounds))
;;       (setq end (cdr bounds))
;;       (when (or (eq this-cmd last-cmd)
;;                 (region-active-p))
;;         (setq beg (region-beginning)))
;;       (forward-paragraph)
;;       (setq end (point))
;;       (mark-select-thing-pos beg end))
;; ))


(defun thing-mark-with-backward(thing get-thing-forward-op forward-op)
  ;; (interactive)
  (let ((bounds (funcall get-thing-forward-op) )
        (this-cmd  this-command)
        (last-cmd  last-command)
        beg end)
    (setq thing-mark-current-thing thing )
    (when bounds
      (setq beg (car bounds))
      (setq end (cdr bounds))
      (when (or (eq this-cmd last-cmd)
                (region-active-p))
        (setq beg (region-beginning));)
      ;; (end-of-defun )
      (funcall forward-op)
      (setq end (point)))
      (mark-select-thing-pos beg end))))


(defun thing-mark-paragraph-with-backward()
  (interactive)
  (thing-mark-with-backward 'paragraph 'get-thing-forward-paragraph 'forward-paragraph))


;; (defun thing-mark-with-backward(thing forward-op)
;;   ;; (interactive)
;;   (let ((bounds (get-thing-forward-defun) )
;;         (this-cmd  this-command)
;;         (last-cmd  last-command)
;;         beg end)
;;     (setq thing-mark-current-thing thing )
;;     (when bounds
;;       (setq beg (car bounds))
;;       (setq end (cdr bounds))
;;       (when (or (eq this-cmd last-cmd)
;;                 (region-active-p))
;;         (setq beg (region-beginning)))
;;       ;; (end-of-defun )
;;       (forward-op)
;;       (setq end (point))
;;       (mark-select-thing-pos beg end))
;;     ))


(defun thing-up-block()
  (cond ((looking-at "\\s\(")
         (backward-char 1))
        (t (backward-char 1)
           (cond ((looking-at "\\s\)")
                  (forward-char 2))
                 (t (message "nothing happen"))))))




(defun thing-mark-block()
  (interactive)
  (let ((bounds  (get-thing-forward-block)) beg end)
    (when (eq this-command last-command)
      (thing-up-block)
      (setq bounds  (get-thing-forward-block)))
    (when bounds
      (mark-select-thing-pos (car bounds)
                             (cdr bounds)))))

;; yank begin
(defun thing-mark-paragraph-2()
  ;; (interactive)
  (let ((bounds (get-thing-forward-paragraph) ) beg end)

    ;; (if ;(eq this-command last-command)
    (if (region-active-p)
        (progn
          (setq beg (min (region-beginning)
                         (region-end)))
          (setq end (max (region-beginning)
                         (region-end)))
          (forward-paragraph)
          ;; (end-of-defun )
          (setq end (point))
          (mark-select-thing-pos beg end))
      (mark-select-thing-pos (cdr bounds)
                             (car bounds)))))
;; yank end
(defun thing-mark-paragraph()
  (interactive)
  (let ((bounds (get-thing-forward-paragraph) ) beg end)
    (setq thing-mark-current-thing 'paragraph)
    (if (eq this-command last-command)
        (progn
          (setq beg (min (region-beginning)
                         (region-end)))
          (setq end (max (region-beginning)
                         (region-end)))
          (forward-paragraph)
          ;; (end-of-defun )
          (setq end (point))
          (mark-select-thing-pos beg end))
      (mark-select-thing-pos (cdr bounds)
                             (car bounds)))))

;; (defun thing-mark-paragraph-with-backward()
;;   (interactive)
;;   (let ((bounds (get-thing-forward-paragraph) )
;;         (this-cmd  this-command)
;;         (last-cmd  last-command) beg end)
;;     (setq thing-mark-current-thing 'paragraph)

;;     (when bounds
;;       (setq beg (car bounds))
;;       (setq end (cdr bounds))
;;       (when (or (eq this-cmd last-cmd)
;;                 (region-active-p))
;;         (setq beg (region-beginning)))
;;       (forward-paragraph)
;;       (setq end (point))
;;       (mark-select-thing-pos beg end))
;; ))


(defun thing-mark-defun-with-backword()
  (interactive)
  (thing-mark-with-backward 'defun 'get-thing-forward-defun 'end-of-defun)
  )

;; (defun thing-mark-defun-with-backword()
;;   (interactive)
;;   (let ((bounds (get-thing-forward-defun) )
;;         (this-cmd  this-command)
;;         (last-cmd  last-command)
;;         beg end)
;;     (setq thing-mark-current-thing 'defun) 
;;     (when bounds 
;;       (setq beg (car bounds)) 
;;       (setq end (cdr bounds)) 
;;       (when (or (eq this-cmd last-cmd) 
;;                 (region-active-p)) 
;;         (setq beg (region-beginning))   
;;         (end-of-defun )
;;         (setq end (point))) 
;;       (mark-select-thing-pos beg end))))

(defun thing-mark-defun()
  (interactive)
  (let ((bounds (get-thing-forward-defun) ) beg end)
    (setq thing-mark-current-thing 'defun)
    (if (eq this-command last-command)
        (progn
          (setq beg (min (region-beginning)
                         (region-end)))
          (setq end (max (region-beginning)
                         (region-end)))
          (end-of-defun )
          (setq end (point))
          (mark-select-thing-pos beg end))
      (mark-select-thing-pos (cdr bounds)
                             (car bounds)))))


(defun mark-thing-backward ()
  (interactive)
  (cond ( (eq thing-mark-current-thing 'word)
          (forward-word -1)
          (message "backword word"))
        ( (eq thing-mark-current-thing 'symbol)
          (forward-symbol -1)
          (message "backword symbol"))
        ( (eq thing-mark-current-thing 'paragraph)
          (backward-paragraph)
          (message "backword paragraph"))
        ( (eq thing-mark-current-thing 'list)
          (message "backword list"))
        ( (eq thing-mark-current-thing 'string)
          (message "backword string"))
        ( (eq thing-mark-current-thing 'defun)
          (beginning-of-defun))
        (t (message "none know thing"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'thing-mark)
