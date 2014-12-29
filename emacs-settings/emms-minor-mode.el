
(require 'emms-extension)


;; (defvar emms-mior-keymap nil)
(defvar emms-mior-keymap-flag nil)




;; (if emms-mior-keymap
;;     nil
;;   (setq emms-mior-keymap (make-keymap))
;;   (suppress-keymap emms-mior-keymap)
;;   (define-key emms-mior-keymap "n"    'emms-next )
;;   (define-key emms-mior-keymap "p"    'emms-previous )
;;   (define-key emms-mior-keymap " "    'emms-pause )
;;   (define-key emms-mior-keymap "s"    'emms-stop )
;;   (define-key emms-mior-keymap "\C-s"    'emms-start )

;;   ;; (define-key  emms-mior-keymap  "'" 'emms-seek-forward-30)
;;   ;; (define-key  emms-mior-keymap  ";" 'emms-seek-backward-30)
;;   (define-key  emms-mior-keymap  "." 'emms-seek-forward-10)
;;   (define-key  emms-mior-keymap  "," 'emms-seek-backward-10)


;;   (define-key  emms-mior-keymap  "'" '(lambda () (interactive) (emms-seek +30)))
;;   (define-key  emms-mior-keymap  ";" '(lambda () (interactive) (emms-seek -30)))

;;   (define-key  emms-mior-keymap  ">" '(lambda () (interactive) (emms-seek +60)))
;;   (define-key  emms-mior-keymap  "<" '(lambda () (interactive) (emms-seek -60)))

;;   (define-key  emms-mior-keymap  "a" 'emms-seek-begin)

;;   (define-key  emms-mior-keymap  "l" 'emms-play-playlist)
;;   (define-key  emms-mior-keymap  "k" 'emms-random)

;;   (define-key  emms-mior-keymap  "b" 'emms-playlist-mode-go)
;;   (define-key  emms-mior-keymap  "m" 'emms-playlist-mode-go-popup)
;;   (define-key  emms-mior-keymap  "t" 'emms-play-directory-tree)
;;   (define-key  emms-mior-keymap  "y" 'emms-shuffle)
;;   (define-key  emms-mior-keymap  "r" 'emms-toggle-repeat-track)
;;   (define-key  emms-mior-keymap  "\C-r" 'emms-toggle-repeat-playlist)

;;   (define-key emms-mior-keymap "\C-g" 'toggle-off-emms-minor-mode)
;;   ;; (define-key emms-mior-keymap "g" 'toggle-off-emms-minor-mode)
;;   ;; (define-key emms-mior-keymap "q" 'toggle-off-emms-minor-mode)

;; )


;; (require 'emms-config)

(define-minor-mode emms-minor-key-mode
  "Doc description, emms key mode."
  nil
  "EmmsKeyMode"
  ;; emms-mior-keymap
  emms-playlist-mode-map
;; emms-x-e-map
   :global nil
   :after-hook (if emms-mior-keymap-flag
                   (message "emms minor mode toggle on")
                (message "emms minor mode toggle off"))
)





(defun toggle-off-emms-minor-mode ( )
  (interactive)
  (setq emms-mior-keymap-flag nil)
  (emms-minor-key-mode -1) 
)


(defun toggle-emms-minor-mode ()
  " toggle emms minor mode"
  (interactive)
  (if emms-mior-keymap-flag
      (progn (setq emms-mior-keymap-flag nil)
             (emms-minor-key-mode -1)  )
    (progn (setq emms-mior-keymap-flag t)
           (emms-minor-key-mode 1)  )
    )
  )



(provide 'emms-minor-mode)
