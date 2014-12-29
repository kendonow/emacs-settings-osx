





;; (add-to-list 'load-path "~/emacs-setting/emms/lisp/")
;(add-to-list 'load-path "~/emacs-setting/emms-4.0/lisp/")

(require 'feigo-function)




(require 'emms-extension)


(require 'emms-i18n)
(require 'emms-setup)
(emms-standard)
(emms-default-players)


(setq emms-info-mp3info-coding-system 'euc-cn
emms-lyrics-coding-system 'gbk)

(require 'emms-player-mplayer)
(add-to-list 'emms-player-list 'emms-player-mplayer)

;; Show the current track each time EMMS
;; starts to play a track with "NP : "
;; (add-hook 'emms-player-started-hook 'emms-show)

(setq emms-show-format "NP: %s")

;; 调整音量
;; no cli volume setup tools in windows
(require 'emms-volume)
;; 给音乐打分
(require 'emms-score)
(emms-score 1)
;; 自动识别音乐标签的编码
(require 'emms-i18n)
;; 自动保存和导入上次的播放列表
;; (require 'emms-history)
;;; My musics
(setq emms-source-file-default-directory "~/Music/m3u/")


;; my customizable playlist format
(defun bigclean-emms-info-track-description (track)
  "Return a description of the current track."
  (let ((artist (emms-track-get track 'info-artist))
        (title (emms-track-get track 'info-title))
        (album (emms-track-get track 'info-album))
        (ptime (emms-track-get track 'info-playing-time)))
    (if title
        (format
         "%-35s %-40s %-35s %5s:%-5s"
         (if artist artist "")
         (if title title "")
         (if album album "")
         (/ ptime 60)
         (% ptime 60)))))

;; (setq emms-track-description-function
;;       'bigclean-emms-info-track-description) 
;; ;; format current track,only display title in mode line


(defun bigclean-emms-mode-line-playlist-current ()
  "Return a description of the current track."
  (let* ((track (emms-playlist-current-selected-track))
         (type (emms-track-type track))
         (title (emms-track-get track 'info-title)))
    (format "[ %s ]"
            (cond ((and title)
                   title)))))

;; (setq emms-mode-line-mode-line-function
;; 'bigclean-emms-mode-line-playlist-current)

;; global key-map
;; all global keys prefix is C-c e
;; compatible with emms-playlist mode keybindings
;; you can view emms-playlist-mode.el to get details about
;; emms-playlist mode keys map

(define-prefix-command 'emms-x-e-map)
;; (global-set-key "\C-x" emms-x-e-map)
;; (define-key ctl-x-map   "e" emms-x-e-map)
(define-key ctl-x-map   "\\" emms-playlist-mode-map)





;; playlist-mode-map
(define-key emms-playlist-mode-map (kbd "SPC") 
 (lambda ( ) (interactive ) (feigo-repeat-command 'emms-pause)))

(define-key emms-playlist-mode-map (kbd "r") 'emms-toggle-repeat-track)
(define-key  emms-playlist-mode-map  "R" 'emms-toggle-repeat-playlist)

(define-key emms-playlist-mode-map (kbd "y") 'emms-shuffle)
(define-key emms-playlist-mode-map (kbd "+") 'emms-mac-volume-raise)
(define-key emms-playlist-mode-map (kbd "-") 'emms-mac-volume-lower)
(define-key emms-playlist-mode-map  "l" 'emms-play-playlist)

(define-key  emms-playlist-mode-map  "g" 'emms-playlist-set-playlist-buffer)
(define-key  emms-playlist-mode-map  "L" 'emms-add-playlist)
(define-key  emms-playlist-mode-map  "T" 'emms-add-directory-tree)
(define-key  emms-playlist-mode-map  "b" 'emms-playlist-mode-go)
(define-key  emms-playlist-mode-map  "j" 'emms-jump-to-file)
(define-key emms-playlist-mode-map  "i" 'emms-insert-file)
(define-key emms-playlist-mode-map  "I" 'emms-insert-directory)




(define-key emms-playlist-mode-map (kbd ".")
 (lambda ( ) (interactive ) (feigo-repeat-command 'emms-seek-forward-5)))

(define-key emms-playlist-mode-map (kbd ",")
 (lambda ( ) (interactive ) (feigo-repeat-command 'emms-seek-backward-5)))



(define-key emms-playlist-mode-map (kbd "'")
   (lambda ( ) (interactive ) (feigo-repeat-command 'emms-seek-forward-10)))



(define-key emms-playlist-mode-map (kbd ";")
  (lambda ( ) (interactive ) (feigo-repeat-command 'emms-seek-backward-10)))




(define-key emms-playlist-mode-map (kbd "]")
  (lambda ( ) (interactive ) (feigo-repeat-command 'emms-seek-forward-15)))


(define-key emms-playlist-mode-map (kbd "[")
  (lambda ( ) (interactive ) (feigo-repeat-command 'emms-seek-backward-15)))

(define-key emms-playlist-mode-map (kbd "n")
  (lambda ( ) (interactive ) (feigo-repeat-command 'emms-next)))

(define-key emms-playlist-mode-map (kbd "p")
  (lambda ( ) (interactive ) (feigo-repeat-command 'emms-previous)))




(define-key  emms-playlist-mode-map  "a" 'emms-seek-begin)
(define-key  emms-playlist-mode-map  "t" 'emms-play-directory-tree)
;; (define-key emms-playlist-mode-map  "T" 'emms-add-playlist-directory)
(define-key emms-playlist-mode-map  "i" 'emms-add-playlist-directory)
(define-key emms-playlist-mode-map  "I" 'emms-add-playlist-directory-tree)

(define-key  emms-playlist-mode-map  "k" 'emms-random)


(global-set-key [f8]  'emms-pause)
(global-set-key [f9]  'emms-seek-forward-10)
(global-set-key [f7]  'emms-seek-backward-10)






(require 'emms-minor-mode)
(define-key  emms-x-e-map  "e" 'toggle-emms-minor-mode)


;; (add-hook 'emms-player-started-hook 'emms-show)
;; (setq emms-info-mp3info-coding-system 'chinese-gbk
      ;; emms-lyrics-coding-system 'chinese-gbk
;; (setq emms-info-mp3info-coding-system 'utf-8
;;       emms-lyrics-coding-system 'utf-8
;;       emms-cache-file-coding-system 'utf-8)

;; (setq emms-last-played-format-alist
;;       '(((emms-last-played-seconds-today) . "%a %H:%M")
;;     (604800                           . "%a %H:%M") ; this week
;;     ((emms-last-played-seconds-month) . "%d")
;;     ((emms-last-played-seconds-year)  . "%m/%d")
;;     (t                                . "%Y/%m/%d")))

(require 'emms-lyrics)

(setq emms-lyrics-dir "~/Music/lyric")
(setq emms-lyrics-display-on-minibuffer t)
(setq emms-lyrics-display-buffer nil)
(setq emms-lyrics-display-on-modeline nil)
(emms-lyrics 1)
;; (require 'emms-extension)


(provide 'emms-config)
