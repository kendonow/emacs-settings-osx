(require 'window-numbering)

(setq window-numbering-assign-func
      (lambda ()
        (when (equal (buffer-name) "*Calculator*")
          9)))




  ;; (global-set-key "\C-c0" 'select-window-0)
  (global-set-key "\C-c1" 'select-window-1)
  (global-set-key "\C-c2" 'select-window-2)
  (global-set-key "\C-c3" 'select-window-3)
  (global-set-key "\C-c4" 'select-window-4)
  ;; (global-set-key "\C-c5" 'select-window-5)
  ;; (global-set-key "\C-c6" 'select-window-6)
  ;; (global-set-key "\C-c7" 'select-window-7)
  ;; (global-set-key "\C-c8" 'select-window-8)
  ;; (global-set-key "\C-c9" 'select-window-9)
(window-numbering-mode 1)

  ;; (define-key window-numbering-keymap "\C-c`" 'select-window-0)
  (define-key window-numbering-keymap "\C-c1" 'select-window-1)
  (define-key window-numbering-keymap "\C-c2" 'select-window-2)
  (define-key window-numbering-keymap "\C-c3" 'select-window-3)
  ;; (define-key window-numbering-keymap "\C-c4" 'select-window-4)
  ;; (define-key window-numbering-keymap "\C-c5" 'select-window-5)
  ;; (define-key window-numbering-keymap "\C-c6" 'select-window-6)
  ;; (define-key window-numbering-keymap "\C-c7" 'select-window-7)
  ;; (define-key window-numbering-keymap "\C-c8" 'select-window-8)
  ;; (define-key window-numbering-keymap "\C-c9" 'select-window-9)


(provide '08-window-numbering-setting)
