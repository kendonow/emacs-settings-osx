;;Nero is a fast text-based web browser that runs under emacs.  It is
;;much faster than emacs/w3 and it is also faster than emacs/w3m.
;;In fact, it might be the fastest web browser I've ever used.
;;
;;No effort has been made to make the browser fully functional!  Future
;;releases of the browser will have more features, but I don't
;;anticipate it ever having anything close to the full functionality of
;;Lynx (which it uses to do display).
;;
;;However, it has two indispensible features that I've already
;;mentioned: it runs inside Emacs and it is fast!
;;
;;BTW, in case you were wondering about the name (which is of course
;;entirely subject to change) -- this program is inspired by the
;;Mozilla-based browser "conkeror" and "Nero" is short for "conqueriNg
;;hERO".
;;
;;; nero.el --- a fast Lynx-based browser for Emacs

;; Copyright (C) 2005 Joe Corneli <jcorneli <at> math.utexas.edu>

;; Time-stamp: <jac -- Mon Mar 21 10:14:25 CST 2005>

;; This file is not part of GNU Emacs, but it is distributed under
;; the same terms as GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 2, or (at your
;; option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Nero is a fast interactive web browser that runs under Emacs.  It
;; uses 'lynx -dump' to generate page content.  Navigation is done via
;; numbered links, a la Conkeror.

;; Not yet present in this version, better-than-just-browsing
;; interaction with various useful web services will be done via
;; Elvis, a la surfraw.

;; Example usage:
;;
;; M-x nero-browse-url RET http://www.roman-emperors.org/nero.htm RET
;; l 7 RET
;; b
;; l 11
;; ...

;; Features to add in the future:

;; Typing numbers should should automatically start things moving, and
;; we need some Elvis.

;;; Code:

;; pure opulence
(require 'cl)

(defvar nero-old-layout nil "Browser windows are currently all
fullscreen.  This variable saves the window layout that was
active before browsing started.  The old layout is restored when
either `nero-hide' or `nero-finished' runs.")

(defvar nero-history nil "We maintain a record of the pages visited.
We save the contents of pages we've visited to speed navigation.
See also `nero-future'.")

(defvar nero-future nil "We maintain a record of the pages visited.
We save the contents of pages we've visited to speed navigation.
See also `nero-history'.")

(defvar nero-mode-hook nil
  "*Functions to run when `nero-mode' runs.")

(defvar nero-fullscreen t
  "Whether or not running nero should delete other windows.")

(defvar nero-mode-map
  (eval-when-compile
    (let ((map (make-keymap)))
      (suppress-keymap map)
      (define-key map "b" 'nero-back)
      (define-key map "f" 'nero-forward)
      (define-key map "r" 'nero-reload)
      (define-key map "g" 'nero-browse-url)
      (define-key map "l" 'nero-follow-link)
      (define-key map "u" 'nero-kill-ring-save-current-url)
      (define-key map "c" 'nero-revisionism)
      (define-key map "t" 'nero-toggle-display-of-links)
      (define-key map "q" 'nero-finished)
      (define-key map "
" 'nero-follow-current-link)
      (define-key map [tab] 'nero-move-to-next-link)
      (define-key map "\C-c\C-c" 'nero-follow-current-link)
      (define-key map "\C-c\C-b" 'nero-hide)
      map))
  "Keymap for nero major mode.")

(defvar nero-mode-syntax-table
  (let ((nero-mode-syntax-table text-mode-syntax-table))
    nero-mode-syntax-table))

(defconst nero-font-lock-keywords
  (eval-when-compile
    (list '("[^[]\\(\\[[0-9]+\\]\\)" 1 font-lock-keyword-face))))

(defun nero-mode ()
  "Major mode for browsing the web.
Commands:
\\{nero-mode-map}
Entry to this mode calls the value of `nero-mode-hook'
if that value is non-nil."
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table nero-mode-syntax-table)
  (use-local-map nero-mode-map)
  (setq major-mode 'nero-mode)
  (set (make-local-variable 'font-lock-defaults)
       '(nero-font-lock-keywords))
  (setq major-mode 'nero-mode)
  (setq mode-name "nero")
  ;; run hook before beginning
  (run-hooks 'nero-mode-hook))

;; useful for debugging
(defun nero-revisionism ()
  "Reinitialize nero's history and other state variables."
  (interactive)
  (setq nero-old-layout nil
        nero-history nil
        nero-future nil))

; (nero-revisionism)

(defun nero-browse-url (URL)
  "URL is a web address or path to a file.
Running this command displays a rendered version of the URL in
the *Nero* buffer."
  (interactive "MURL: ")
  ;; set up environment
  (unless nero-old-layout
    (setq nero-old-layout (current-window-configuration))
    (set-buffer (get-buffer-create "*Nero*"))
    (nero-mode))
  (switch-to-buffer (get-buffer-create "*Nero*"))
  ;; we should save the current location of the point to the history
  ;; for this page -- but it is important to get straight which of
  ;; the pages histories should be affected...
  (let ((curpoint (point)))
    (delete-region (point-min) (point-max))
    (when nero-fullscreen
      (delete-other-windows))
    (insert (shell-command-to-string (concat "lynx -dump \"" URL "\"")))
    (save-excursion
      (when (search-backward-regexp "^References" nil t)
        (let ((nero-references (buffer-substring-no-properties 
                                (match-beginning 0) (point-max))))
          (delete-region (match-beginning 0) (point-max))
          (set-buffer (get-buffer-create " *Nero References*"))
          (delete-region (point-min) (point-max))
          (insert nero-references))))
    (goto-char (point-min))
    ;; update appropriate history cells
    (unless (equal (caar nero-history) URL)
      (setq nero-history (cons (list URL
                                     (save-excursion 
                                       (set-buffer "*Nero*")
                                       (buffer-string))
                                     (save-excursion 
                                       (set-buffer " *Nero References*")
                                       (buffer-string))
                                     1)
                               nero-history)))
    (when (second nero-history)
      (setcar (nthcdr 3 (second nero-history)) curpoint))
    ;; update future as needed
    (if (equal (caar nero-future) URL)
        (setq nero-future (cdr nero-future))
      (setq nero-future nil))))

(defun nero-reload ()
  "Reload the current url.
This is useful if you suspect its contents might have changed."
  (interactive)
  (nero-browse-url (caar nero-history)))

(defun nero-restore-page (page)
  "Utility to display a page that has been saved in nero's history."
  (switch-to-buffer (get-buffer-create " *Nero References*"))
  (delete-region (point-min) (point-max))
  (insert (third page))
  (switch-to-buffer (get-buffer-create "*Nero*"))
  (delete-region (point-min) (point-max))
  (insert (second page))
  (goto-char (fourth page)))

(defun nero-back ()
  "Display the previous page you visited."
  (interactive)
  (if (eq (length nero-history) 1)
      (message "Already at beginning of history.")
    (setq nero-future (cons (car nero-history) nero-future)
          nero-history (cdr nero-history))
    (nero-restore-page (car nero-history))))

(defun nero-forward ()
  "Display the next page you visited."
  (interactive)
  (if (not nero-future)
      (message "Already at end of future.")
    (setq nero-history (cons (car nero-future) nero-history)
          nero-future (cdr nero-future))
    (nero-restore-page (car nero-history))))

;; Eventually want to set this up so that just typing a number will
;; result in getting the command rolling.
(defun nero-follow-link (number)
  "Read in the NUMBER of a link and display the page it leads to."
  (interactive "Mlink number: ")
  (set-buffer (get-buffer-create " *Nero References*"))
  (save-excursion 
    (goto-char (point-min))
    (when (search-forward-regexp 
           (concat " +" number "\\. \\(.*\\)") nil t)
      (nero-browse-url (match-string-no-properties 1)))))

(defun nero-kill-ring-save-current-url ()
  "Copy the current url to the kill ring.
If `x-select-enable-clipboard' is non-nil and you are running
Emacs under X, this makes it easy to paste the url into other programs."
  (interactive)
  (with-temp-buffer
    (insert (caar nero-history))
    (kill-ring-save (point-min) (point-max)))
  (message "Current URL copied to kill-ring."))

(defvar nero-links-visible t)

(defun nero-toggle-display-of-links ()
  "Toggle whether or not the links visible in the current page.
Even if the links are not visible, you can still follow them
using `nero-follow-link', and they will still be copied to
another buffer if you select and copy text that contains them."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (setq nero-links-visible (not nero-links-visible))
    (if nero-links-visible 
        (remove-text-properties (point-min) (point-max) 
                                '(invisible t
                                  intangible t))
      (while (re-search-forward "\\[\\([0-9]+\\)\\]" nil t)
        (set-text-properties 
         (match-beginning 0)
         (match-end 0)
         '(invisible t
           intangible t))))))

(defun nero-follow-current-link ()
  "Open the page linked to by the next link in the buffer.
See `nero-move-to-next-link' for the definition of \"next link\"."
  (interactive)
  (while (and (looking-at "[0-9]*\\]")
              (not (bobp)))
    (backward-char 1))
  (when (search-forward-regexp "\\[\\([0-9]+\\)\\]" nil t)
    (nero-follow-link (match-string-no-properties 1))))

(defun nero-move-to-next-link ()
  "Position the cursor on the next link that appears in the buffer.
The \"next link\" is any link such that the cursor is not past
the the right brace that denotes the link's end, and is not
before the right brace of any other link."
  (interactive)
  (search-forward-regexp "\\[\\([0-9]+\\)\\]" nil t)
  (backward-char 1))

(defun nero-hide ()
  "Restore the window configuration that was active before nero first ran."
  (interactive)
  (set-window-configuration nero-old-layout))

(defun nero-finished ()
  "Kill nero's associated buffers, restoring all windows and variables."
  (interactive)
  (kill-buffer "*Nero*")
  (kill-buffer " *Nero References*")
  (set-window-configuration nero-old-layout)
  (nero-revisionism))

;;; nero.el ends here
