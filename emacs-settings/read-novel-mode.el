(defun toggle-read-novel-mode ()
  "Setup current window to be suitable for reading long novel/article text.

• Line wrap at word boundaries. 
• Set a right margin.
• line spacing is increased.
• variable width font is used.

Call again to toggle back."
  (interactive)
  (if (eq (get this-command 'state-on-p) nil)
      (progn
        (set-window-margins nil 0 
                            (if (> fill-column (window-body-width) )
                                0
                              (progn
                                (- (window-body-width) fill-column) )  
                              ))
        (variable-pitch-mode 1)
        (setq line-spacing 0.4)
        (setq word-wrap t)
        (put this-command 'state-on-p t)
        )
    (progn
      (set-window-margins nil 0 0)
      (variable-pitch-mode 0)
      (setq line-spacing nil)
      (setq word-wrap nil)
      (put this-command 'state-on-p nil)
      ) )
  (redraw-frame (selected-frame)) )

(provide 'read-novel-mode)
