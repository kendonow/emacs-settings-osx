


;; (defun replace-myregex-eq-add (begin end  eq-num format-msg)
;;   (let (
;;         (num1 )
;;         (num2 )
;;         (total )
;;         (replace-str )
;;         )

;;     (goto-char begin)
;;     (save-excursion
;;       (save-restriction
;;         (narrow-to-region begin end)
;;         (while (and(< (point) end)
;;                     (re-search-forward "\\([0-9]\\)\\([0-9]\\)\\(\\w+\\)\\s-*|" nil t)  )
;;           (setq num1 (string-to-number (match-string 1)))
;;           (setq num2 (string-to-number (match-string 2)))
;;           (setq total (+ num1 num2))
;;           (when (eq eq-num total)
;;             (setq replace-str (format format-msg num1 num2 (match-string 3)))
;;             (replace-match replace-str  t nil)
;;             )
;;           )
;;         ))
    
;;     )
;;   (setq deactivate-mark t)
;;   (goto-char end)
;;   )



;; (defun replace-myregex-eq-sub (begin end  eq-num format-msg)
;;   (let (
;;         (num1 )
;;         (num2 )
;;         (subnum )
;;         (replace-str )
;;         )

;;     (goto-char begin)

;;     (save-excursion
;;       (save-restriction
;;         (narrow-to-region begin end)
;;         (while (and ;(< (point) end)
;;                     (re-search-forward "\\([0-9]\\)\\([0-9]\\)\\(\\w+\\)\\s-*|" nil t)  )
;;           (setq num1 (string-to-number (match-string 1)))
;;           (setq num2 (string-to-number (match-string 2)))
;;           (setq subnum (- num1 num2))
;;           (when (or (eq eq-num subnum) (eq eq-num subnum))
;;             (setq replace-str (format format-msg num1 num2 (match-string 3)))
;;             (replace-match replace-str  t nil)
;;             )
;;           )
;;         )
;;  )

;;     )
;;   ;; (setq deactivate-mark t)
;;   )




(defun replace-myregex-eq-add (begin end  eq-num format-msg)
  (let (
        (num1 )
        (num2 )
        (total )
        (replace-str )
        )

    (goto-char begin)
    ;; (save-excursion
    ;;   (save-restriction
    ;;     (narrow-to-region begin end)
        (while (and ;(< (point) end)
                    (re-search-forward "\\([0-9]\\)\\([0-9]\\)\\(\\w+\\)\\s-*|" nil t)  )
          (setq num1 (string-to-number (match-string 1)))
          (setq num2 (string-to-number (match-string 2)))
          (setq total (+ num1 num2))
          (when (eq eq-num total)
            (setq replace-str (format format-msg num1 num2 (match-string 3)))
            (replace-match replace-str  t nil)
            )
          )
        ;; ))
    
    )
  ;; (setq deactivate-mark t)
  ;; (goto-char end)
  )



(defun replace-myregex-eq-sub (begin end  eq-num format-msg)
  (let (
        (num1 )
        (num2 )
        (subnum )
        (replace-str )
        )

    (goto-char begin)

    ;; (save-excursion
    ;;   (save-restriction
    ;;     (narrow-to-region begin end)
        (while (and ;(< (point) end)
                    (re-search-forward "\\([0-9]\\)\\([0-9]\\)\\(\\w+\\)\\s-*|" nil t)  )
          (setq num1 (string-to-number (match-string 1)))
          (setq num2 (string-to-number (match-string 2)))
          (setq subnum (- num1 num2))
          (when (or (eq eq-num subnum) (eq eq-num subnum))
            (setq replace-str (format format-msg num1 num2 (match-string 3)))
            (replace-match replace-str  t nil)
            )
        ;;   )
        ;; )
 )

    )
  ;; (setq deactivate-mark t)
  )


(defun test-myregex (begin end )
  (interactive "r")


  ; "{{{clr(blue,%s)}}}"
  (message "begin=%s end=%s" begin end)
    (save-excursion
      (save-restriction
        (narrow-to-region begin end)

  (replace-myregex-eq-sub begin end 0 "{{{clr(red,%d%d%s)}}}|")
  ;; (replace-myregex-eq-sub begin end 4 "{{{clr(red,%d%d%s)}}}|")
  ;; (replace-myregex-eq-sub begin end -4 "{{{clr(red,%d%d%s)}}}|")

  (replace-myregex-eq-add begin end 9 "{{{clr(blue,%d%d%s)}}}|")
  ;; (replace-myregex-eq-add begin end 5 "{{{clr(blue,%d%d%s)}}}|")
  ;; (replace-myregex-eq-add begin end 13 "{{{clr(blue,%d%d%s)}}}|")
))
)

;»¹Ô­
(defun remove-myregex-old (begin end )
  (interactive "r")
    ;; (save-excursion
    ;;   (save-restriction
    ;;     (narrow-to-region begin end)

  (replace-regexp "{{{clr([a-z]*[,\\s-]*\\([0-9]*[^}]*\\))}}}" "\\1" nil begin end)

        ;; ))
)


(defun insert-org-RGB (begin end RGB)
  ;; (interactive "r")
  (interactive "r\nsRGB: ")
  
  (goto-char end)
  (insert ")}}}")

  (goto-char begin)
  (insert (format "{{{clr(%s," RGB))

    ;; (save-excursion
    ;;   (save-restriction
    ;;     (narrow-to-region begin end)

  ;; (replace-regexp "{{{clr([a-z]*[,\\s-]*\\([0-9]*[^}]*\\))}}}" "\\1" nil begin end)

        ;; ))
)

