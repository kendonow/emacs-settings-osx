;;; bm-ext.el --- List all bookmarks in all buffers
;;
;; An extension for bm.el that adds a function that lists all bookmarks in all
;; buffers. 
;;
;; By Dan McKinley, 2008 - http://mcfunley.com or mcfunley at gmail.
;;
;; For the latest version of bm.el, visit: 
;;    http://www.nongnu.org/bm/
;;
;; For the latest version of this extension, visit:
;;    http://www.emacswiki.org/cgi-bin/wiki/VisibleBookmarks
;;
;; Revision history:
;; 08/16/2008 - Created (Dan McKinley)
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.
;;
(eval-when-compile (require 'cl))


;; Make sure the repository is loaded as early as possible
(setq bm-restore-repository-on-load t)
(require 'bm)

;; Loading the repository from file when on start up.
(add-hook 'after-init-hook 'bm-repository-load)

;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)

;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)

;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when Emacs is killed, so we
;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))

;; Update bookmark repository when saving the file.
(add-hook 'after-save-hook 'bm-buffer-save)

;; Restore bookmarks when buffer is reverted.
(add-hook 'after-revert-hook 'bm-buffer-restore)

(setq-default bm-buffer-persistence t)
(setq bm-cycle-all-buffers t)


(provide 'bm-ext)
