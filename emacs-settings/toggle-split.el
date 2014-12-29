
(require 'repeat)

(defun --repeat-command (command)
  "Repeat COMMAND."
  (setq last-repeatable-command  command)
  (repeat nil)
)

(defun toggle-window-direction_old ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))


        (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
          (progn
           (setq split-height-threshold nil)
           (setq split-width-threshold 80)
           )
          (progn 
           (setq split-height-threshold 80)
           (setq split-width-threshold nil)
            )
            )

	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))


(defun toggle-window-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)  (up . left)(left . up)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window neighbour-dir next-win)))))
          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))


;; Toggle between split windows and a single window
(defun toggle-windows-split()
  "Switch back and forth between one window and whatever split of windows we might have in the frame. The idea is to maximize the current buffer, while being able to go back to the previous split of windows in the frame simply by calling this command again."
  (interactive)
  (if (not (window-minibuffer-p (selected-window)))
      (progn
        (if (< 1 (count-windows))
            (progn
              (window-configuration-to-register ?u)
              (delete-other-windows))
          (jump-to-register ?u))))
  (my-iswitchb-close))
 
;; (define-key global-map (kbd "C-|") 'toggle-windows-split)
 
 
;; Note: you may also need to define the my-iswitchb-close function 
;; created by Ignacio as well: http://emacswiki.org/emacs/IgnacioPazPosse
(defun my-iswitchb-close()
 "Open iswitchb or, if in minibuffer go to next match. Handy way to cycle through the ring."
 (interactive)
 (if (window-minibuffer-p (selected-window))
    (keyboard-escape-quit)))


(defun toggle-window-split/repeat()
  (interactive)
  (--repeat-command 'toggle-windows-split)
)

(defun toggle-window-direction/repeat()
  (interactive)
  (--repeat-command 'toggle-window-direction)
  ;; (--repeat-command 'toggle-window-direction_old)
)

(global-set-key (kbd "C-x T") 'toggle-window-split/repeat)
(global-set-key (kbd "C-x t") 'toggle-window-direction/repeat)

;; (require 'ace-window)

;; (defun ace-swap-window/repeat()
;;   (interactive)
;;   (--repeat-command 'ace-swap-window)
;; )

;; (global-set-key (kbd "C-x T") 'ace-swap-window/repeat)

(provide 'toggle-split)
