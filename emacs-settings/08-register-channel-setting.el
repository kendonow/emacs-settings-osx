

(require 'register-channel)


(require 'better-registers)
(better-registers-install-save-registers-hook)
(load better-registers-save-file)

(unless (fboundp 'ctrl-j-thing) 
  (define-prefix-command 'ctrl-j-thing) 
  (global-set-key "\C-j" ctrl-j-thing))

(defun register-channel-default-keymap () 
  (let ((map (make-sparse-keymap)))

    (unless (fboundp 'ctrl-j-map) 
      ;; (define-prefix-command 'ctrl-j-map) 
      (define-prefix-command 'ctrl-r-map) 
      (define-prefix-command 'ctrl-c-s-map) 
      ;; (global-set-key "\C-j" ctrl-j-map) 
      ;; (global-set-key "\C-r" ctrl-r-map) 
      (global-set-key "\C-js" ctrl-c-s-map) 
      (global-set-key "\C-jr" ctrl-r-map) 
      ;; (define-key  ctrl-j-map "s" ctrl-j-s-map)
      )
    ;; (global-set-key "\C-js" 'point-to-register) 
    ;; (define-key map (kbd "C-j s") 'point-to-register) 

    ;; ;; TODO: more customization; maybe define a prefix key.
    ;; (define-key map (kbd "C-c s 1") 'register-channel-save-point) 
    ;; (define-key map (kbd "C-c s 2") 'register-channel-save-point) 
    ;; (define-key map (kbd "C-c s 3") 'register-channel-save-point) 
    ;; (define-key map (kbd "C-c s 4") 'register-channel-save-point) 
    ;; (define-key map (kbd "C-c s 5") 'register-channel-save-point) 
    ;; (define-key map (kbd "C-c s 6") 'register-channel-save-window-configuration) 
    ;; (define-key map (kbd "C-c s 7") 'register-channel-save-window-configuration) 
    ;; (define-key map (kbd "C-c s 8") 'register-channel-save-window-configuration)

    ;; TODO: more customization; maybe define a prefix key.
    ;; (define-key map (kbd "C-j s `") 'register-channel-save-point) 

    (define-key map (kbd "C-j s 1") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 2") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 3") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 4") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 5") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 6") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 7") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 8") 'register-channel-save-point)
    (define-key map (kbd "C-j s 9") 'register-channel-save-point) 
    (define-key map (kbd "C-j s 0") 'register-channel-save-point) 
    (define-key map (kbd "C-j s -") 'register-channel-save-point) 
    (define-key map (kbd "C-j s =") 'register-channel-save-point) 




    ;; TODO: use register-channel-backup-register.
    ;; (define-key map (kbd "C-j `") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-j `") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 1") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 2") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 3") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 4") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 5") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 6") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 7") 'register-channel-dwim) 
    (define-key map (kbd "C-j r 8") 'register-channel-dwim)
    (define-key map (kbd "C-j r 9") 'register-channel-dwim)
    (define-key map (kbd "C-j r 0") 'register-channel-dwim)
    (define-key map (kbd "C-j r -") 'register-channel-dwim)
    (define-key map (kbd "C-j r =") 'register-channel-dwim)

    ;; TODO: use register-channel-backup-register.
    ;; (define-key map (kbd "C-c `") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-c 1") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-c 2") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-c 4") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-c 5") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-c 6") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-c 7") 'register-channel-dwim) 
    ;; (define-key map (kbd "C-c 8") 'register-channel-dwim)


    map))

(setq register-channel-mode-map (register-channel-default-keymap))

;;;###autoload
(define-minor-mode register-channel-mode
  "Toggle register-channel mode"
  :keymap register-channel-mode-map
  :global t)

(register-channel-mode 1)


;; (global-set-key "\C-jj" 'jump-to-register) 

(global-set-key "\C-ja" 'jump-to-register) 
;; (global-set-key "\C-jl" 'list-registers) 
(global-set-key "\C-js" 'point-to-register) 





;; (global-set-key "\C-js" 'point-to-register)
;; (global-set-key "\C-jj" 'jump-to-register) 
;; (global-set-key "\C-jl" 'list-registers) 

(provide '08-register-channel-setting)
