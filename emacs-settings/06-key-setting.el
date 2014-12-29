(require 'smart-repeat-mode)


(unless (fboundp 'ctrl-ggtags-global--map) 
  (define-prefix-command 'ctrl-ggtags-global--map) 
  (global-set-key "\C-xg" ctrl-ggtags-global--map))

(unless (fboundp 'ctrl-z-thing) 
  (define-prefix-command 'ctrl-z-thing) 
  (global-set-key "\C-z" ctrl-z-thing))


(unless (fboundp 'ctrl-j-thing) 
  (define-prefix-command 'ctrl-j-thing) 
  (global-set-key "\C-j" ctrl-j-thing))

(require 'ace-window)
(setq aw-scope 'frame)
(global-set-key  "\C-xo" 'ace-window)
(setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9))

(global-set-key  "\C-zo" 'other-frame)
(global-set-key  "\C-z\C-o" 'next-multiframe-window)
(global-set-key  "\C-zO" 'next-multiframe-window)
(global-set-key  "\C-z2" 'make-frame-command)
(global-set-key  "\C-z1" 'delete-other-frames)
(global-set-key  "\C-z0" 'delete-frame)
(global-set-key (kbd "C-z z")     'repeat)
(require 'buffer-extension)
(require 'jump)

(global-set-key [(control x) 
                 (k)] 'kill-this-buffer)
(global-set-key "\C-zk" 'kill-current-mode-buffers)
(global-set-key "\C-z\C-k" 'kill-current-mode-buffers-except-current)
(global-set-key "\C-zK" 'kill-other-window-buffer)
(define-prefix-command 'ctrl-t-map)
(global-set-key    "\C-t" ctrl-t-map)
(define-key ctrl-t-map "t" 'transpose-chars)
(define-key ctrl-t-map "l" 'transpose-lines)
(define-key ctrl-t-map "w" 'transpose-words)
(define-key ctrl-t-map "s" 'transpose-sexps)
(require 'highlight-symbol+)
(defun c-beginning-of-defun-to-funName () 
  (interactive) 
  (search-forward-regexp "::") 
  (setq smart-kill-flag t) 
  (smart-symbol-kill  1) 
  (setq this-command 'c-beginning-of-defun))
(defun smart-c-common-hook () 
  (sr-define-alist  '("\C-ce" "\C-ca") 
                              '(("e" c-end-of-defun    ) 
                                ("a"   c-beginning-of-defun) 
                                ("w"   copy-c-defun-name) 
                                ("p" backward-paragraph) 
                                ("n" forward-paragraph)) nil c-mode-base-map) 
  (define-key c-mode-base-map "\C-cf" 'astyle-this-buffer))
(add-hook 'c-mode-common-hook 'smart-c-common-hook)
(defun smart-lisp-common-hook () 
  (sr-define-alist  '("\C-ce" "\C-ca") 
                              '(("e" end-of-defun    ) 
                                ("a"   beginning-of-defun) 
                                ("p" backward-paragraph) 
                                ("n" forward-paragraph)) ) 
  (define-key emacs-lisp-mode-map "\C-cf" 'elisp-format-buffer))
(add-hook 'emacs-lisp-mode-hook 'smart-lisp-common-hook)
(require 'jump-to-punctuation)
(sr-define-alist  '(   "\C-ct") 
                            '(("r" ergoemacs-backward-open-bracket    ) 
                              ("y" ergoemacs-forward-close-bracket    ) 
                              ("t" thing-parenthesis-jump-repeat)))

(require 'top-bottom+)
(sr-define-alist  '("\C-l" ) 
                            '(("l"    . recenter-move-half-top-bottom ) 
                              ("\C-l" . recenter-top-bottom) 
                              ("b"    . recenter-move-half-bottom ) 
                              ("t"   . recenter-move-half-top) 
                              ("m" 
                               (lambda () 
                                 (interactive) 
                                 (setq recent-move-direction nil)))))

(sr-define-alist-prefix "\C-c" '(("p" backward-paragraph) 
                                                ("n" forward-paragraph) 
                                                ("e" end-of-defun    ) 
                                                ("a"   beginning-of-defun) 
                                                ("b" recent-jump-backward    )) )
(require 'key-nxml)
(require 'dictionary)
(sr-define-alist '("\C-cdb" "\C-cdf"  ) 
                           '(("b" dictionary-buffer-backward) 
                             ("f" dictionary-buffer-forward)) )
(sr-define-alist '("\C-xa" "\C-xe"  ) 
                           '(("a" beginning-of-buffer) 
                             ("e" end-of-buffer) 
                             ("p" backward-paragraph) 
                             ("n" forward-paragraph)) )
(global-set-key  "\C-za" 'align-regexp)
(global-set-key  "\C-zA" 'align-regexp-repeat)
(global-set-key  "\C-ze" 'align-entire)
(global-set-key  "\C-zR" 'buffer-ext-move-buffer-file)
(global-set-key  "\C-zr" 'buffer-ext-rename-buffer-file)
(require 'thing-mark-key)
(require 'hide-region+)

(sr-define-alist  '( 
                              "\C-cb" 
                              "\C-cu") 
                            '(
                              ("b" recent-jump-backward    ) 
                              ("f"   recent-jump-forward) 
                              ("u"  ace-jump-mode-pop-mark)))




(sr-define-alist  '(   "\C-xde" "\C-xd\C-e")
                            '(("[" switch-same-mode-buffer-prev    )
                              ("]"   switch-same-mode-buffer-next)
                              ("e"   multi-eshell-switch)
                              ("\C-e" multi-eshell  )
                              ))



(sr-define-alist  '( "\C-cv"  ) 
                            '(("c" scroll-up-command    ) 
                              ("v"   scroll-down-command) 
                              ("\C-v"   scroll-up-command)))


(global-set-key (kbd "C-x M-e") 'eval-region)



(defun compile-parent (command) 
  (interactive 
   (let* ((make-directory (locate-dominating-file (buffer-file-name) "Makefile")) 
          (command (concat "make -k -C " (shell-quote-argument make-directory))))
     (list  command)))
  (compile command))


(defun my-compilation-mode-hook () 
  (setq truncate-lines t) ;; automatically becomes buffer local
  (set (make-local-variable 'truncate-partial-width-windows) nil)
  )
(add-hook 'compilation-mode-hook 'my-compilation-mode-hook)

(global-set-key "\C-xdl" 'compile-parent)
(global-set-key "\C-xdj" 'linum-relative-toggle)

(setq compilation-read-command nil)

(global-set-key (kbd "C-,")     ctl-x-4-map)









(require 'init-smartrep)


(require  'switch-same-mode-buffer)


(sr-define-alist  '( "\C-c," "\C-c.") ' ((","   switch-same-mode-buffer-prev) 
                                                   ("."  switch-same-mode-buffer-next )
                                                   ("<" previous-buffer )
                                                   (">"  next-buffer)
                                                   ))

(sr-define-alist  '( "\C-c[" "\C-c]") ' (("["   switch-same-mode-buffer-prev) 
                                                   ("]"  switch-same-mode-buffer-next )
                                                   ("{" previous-buffer )
                                                   ("}"  next-buffer)
                                                   ))


(sr-define-alist  '( "\C-zb" "\C-z\C-b") ' (("b" previous-buffer ) 
                                                   ("\C-b"  next-buffer)))


(require 'ctrl-j-key )

(require '08-god-mode-setting)


(provide '06-key-setting)
