

(require 'color-moccur)




; (load "color-moccur")
 (setq *moccur-buffer-name-exclusion-list*
       '(".+TAGS.+" "*Completions*" "*Messages*"
         "newsrc.eld" ".bbdb"))

 (setq moccur-split-word t)
 (setq dmoccur-use-list t)
 (setq dmoccur-use-project t)
 (setq dmoccur-list
       '(
         ("custom-dir" default-directory (".*") dir)
         ("work" "~/work/src_work/" ("\\.h" "\\.cpp$") nil)
         ("emacs" "~/emacs-setting/"  ("\\.js" "\\.el$") nil)
;;         ("1.99" "d:/unix/Meadow2/1.99a6/" (".*") sub)
         ))
; (global-set-key "\C-x\C-o" 'occur-by-moccur
; (global-set-key "\C-x q o" 'occur-by-moccur)

 (defadvice moccur-edit-change-file
  (after save-after-moccur-edit-buffer activate)
  (save-buffer))


;; (define-prefix-command 'moccur-x-map)
;; (global-set-key "\C-z" moccur-x-map)
;; (global-set-key "\M-z" moccur-x-map)
;; (global-set-key [(control tab)]  'moccur-x-map)

;; ;(global-set-key (kbd "C-\.") 'moccur-x-map)
;; (global-set-key [f18]  'moccur-x-map)

;; (define-key moccur-x-map  "u" 'multi-occur     )
;; (define-key moccur-x-map  "i" 'occur)           

;; (define-key moccur-x-map  "p" 'moccur          )
;; (define-key moccur-x-map  "o" 'occur-by-moccur )
;; (define-key moccur-x-map  "l" 'dmoccur         )


;; (define-key moccur-x-map "a"    'anything-c-moccur-occur-by-moccur)
;; (define-key moccur-x-map "d"    'anything-c-moccur-dmoccur)









(provide 'color-moccur-setting)

