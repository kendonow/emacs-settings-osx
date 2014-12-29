;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-04-10 22:34:30 Saturday by ahei>

(require 'recent-jump)
(require 'recent-jump-small)

(setq rj-mode-line-format nil)
(setq rjs-mode-line-format nil)

(recent-jump-mode)
(recent-jump-small-mode)

(global-set-key (kbd "M-,") 'recent-jump-backward)
(global-set-key (kbd "M-.") 'recent-jump-forward)
;;(global-set-key (kbd "C-x ,") 'recent-jump-small-backward)
;;(global-set-key (kbd "C-x .") 'recent-jump-small-forward)

(provide 'recent-jump-settings)
