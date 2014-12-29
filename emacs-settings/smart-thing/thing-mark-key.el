

(require 'thing-mark-repeat)

(defvar thing-mark-keymap nil)
(defvar thing-mark-old-point nil)
(defvar thing-mark-count  nil)

(defun toggle-off-thing-mark-mode ( )
  (thing-mark-mode -1))

(defun thing-mark-mode-after-hook () 
  (setq thing-mark-old-point (point))
  )

(defun close-thing-mark-mode ( ) 
  (interactive)
  (thing-mark-mode -1) 
  (push last-command-event unread-command-events) 
  (message "thing mark  mode toggle off")
  )

(defun quit-thing-mark-mode ( ) 
  (interactive) 
  (goto-char thing-mark-old-point) 
  (thing-mark-mode -1) 
  (deactivate-mark)
  )


(if thing-mark-keymap 
    nil 
  (setq thing-mark-keymap (make-keymap)) 
  (set-char-table-range (nth 1 thing-mark-keymap) t 'close-thing-mark-mode)
  (suppress-keymap thing-mark-keymap)
  (define-key thing-mark-keymap "w"    'thing-mark-word) 
  (define-key thing-mark-keymap "s"    'thing-mark-symbol) 
  (define-key thing-mark-keymap "q"    'thing-mark-string) 
  (define-key thing-mark-keymap "h"    'thing-mark-paragraph) 
  (define-key thing-mark-keymap "f"    'thing-mark-defun) 
  (define-key thing-mark-keymap "h"    'thing-mark-paragraph)
  (define-key thing-mark-keymap "b"    'mark-thing-backward)
  (define-key thing-mark-keymap "l"    'thing-mark-list)
  (define-key thing-mark-keymap "L"    'thing-mark-list-outer)

  (define-key thing-mark-keymap "d"    'thing-mark-line-repeat)
  (define-key thing-mark-keymap "\C-g"    'quit-thing-mark-mode    ))


(define-minor-mode thing-mark-mode "Doc description " 
  nil
  "Thing Mark"
  thing-mark-keymap 
  :global nil 
  :after-hook (thing-mark-mode-after-hook))

(unless (fboundp 'ctrl-z-thing)
  (define-prefix-command 'ctrl-z-thing)
  (global-set-key "\C-z" ctrl-z-thing)
)

(global-set-key (kbd "C-z m")     'thing-mark-mode)

(global-set-key (kbd "C-z s")     'thing-mark-symbol-repeat)
(global-set-key (kbd "C-z h")     'thing-mark-paragraph-repeat)
(global-set-key (kbd "C-z w")     'thing-mark-word-repeat)
(global-set-key (kbd "C-z f")     'thing-mark-defun-repeat)
(global-set-key (kbd "C-z q")     'thing-mark-string-repeat)
(global-set-key (kbd "C-z l")     'thing-mark-list-repeat)
(global-set-key (kbd "C-z d")     'thing-mark-line-repeat)
(global-set-key (kbd "C-z b")     'thing-mark-backward-start)

(global-set-key (kbd "M-h")     'thing-mark-paragraph)
(global-set-key (kbd "M-[")     'thing-parenthesis-jump-repeat)
(global-set-key (kbd "M-]")     'thing-parenthesis-jump-repeat)

(provide 'thing-mark-key)
