;; -*- Emacs-Lisp -*-

;; Time-stamp: <2009-11-12 01:38:10 Thursday by ahei>

;; ʹ��
;; (setq rjs-ring-length 10000)
;; (require 'recent-jump)
;; (global-set-key (kbd "C-x ,") 'recent-jump-small-backward)
;; (global-set-key (kbd "C-x .") 'recent-jump-small-forward)

(require 'desktop)
(require 'recent-jump)

(defvar rjs-line-threshold 1 "*The line threshold of a big-jump")
(defvar rjs-column-threshold 1 "*The column threshold of a big-jump")
(defvar rjs-ring-length 10000 "*The length of `rjs-ring'")

(defvar rjs-ring (make-ring rjs-ring-length) "��Ź����������λ�õĻ�")
(defvar rjs-index 0 "`recent-jump-small-backward'��ʱ��ǰλ����`rjs-ring'�е����")
(defvar rjs-position-before nil "��ǰ������ڵ�λ��")
(defvar rjs-position-pre-command nil "����ִ��ǰ������ڵ�λ��")
(defvar rjs-command-ignore
  '(recent-jump-backward
    recent-jump-forward
    recent-jump-small-backward
    recent-jump-small-forward))

(defvar rjs-mode-line-format " RJS" "*Mode line format of `recent-jump-small-mode'.")

(defun rjs-pre-command ()
  "ÿ������ִ��ǰִ���������"
  (unless (or (active-minibuffer-window) isearch-mode)
    (unless (memq this-command rjs-command-ignore)
      (let ((position (list (buffer-file-name) (current-buffer) (point))))
        (unless rjs-position-before
          (setq rjs-position-before position))
        (setq rjs-position-pre-command position))
      (if (memq last-command '(recent-jump-small-backward recent-jump-small-forward))
          (progn
            (let ((index (1- rjs-index)) (list nil))
              (while (> index 0)
                (push (ring-ref rjs-ring index) list)
                (setq index (1- index)))
              (while list
                (ring-insert rjs-ring (car list))
                (pop list))))))))

(defun rjs-post-command ()
  "ÿ������ִ�к�ִ���������"
  (let ((position (list (buffer-file-name) (current-buffer) (point))))
    (if (or (and rjs-position-pre-command
                 (rj-insert-big-jump-point rjs-ring rjs-line-threshold rjs-column-threshold rjs-position-pre-command position rjs-position-pre-command))
            (and rjs-position-before
                 (rj-insert-big-jump-point rjs-ring rjs-line-threshold rjs-column-threshold rjs-position-before position rjs-position-before)))
        (setq rjs-position-before nil)))
  (setq rjs-position-pre-command nil))

(defun recent-jump-small-backward (arg)
  "��������ִ��ǰ��λ��"
  (interactive "p")
  (let ((index rjs-index)
        (last-is-rjs (memq last-command '(recent-jump-small-backward recent-jump-small-forward))))
    (if (ring-empty-p rjs-ring)
        (message (if (> arg 0) "Can't backward, ring is empty" "Can't forward, ring is empty"))
      (if last-is-rjs
          (setq index (+ index arg))
        (setq index arg)
        (let ((position (list (buffer-file-name) (current-buffer) (point))))
          (setq rj-position-before nil)
          (unless (rj-insert-big-jump-point rjs-ring rjs-line-threshold rjs-column-threshold (ring-ref rjs-ring 0) position)
            (ring-remove rjs-ring 0)
            (ring-insert rjs-ring position))))
      (if (>= index (ring-length rjs-ring))
          (message "Can't backward, reach bottom of ring")
        (if (<= index -1)
            (message "Can't forward, reach top of ring")
          (let* ((position (ring-ref rjs-ring index))
                (file (nth 0 position))
                (buffer (nth 1 position)))
            (if (not (or file (buffer-live-p buffer)))
                (progn
                  (ring-remove rjs-ring index)
                  (message "Ҫ��ת��λ�����ڵ�bufferΪ���ļ�����buffer, ����buffer�ѱ�ɾ��"))
              (if file
                  (find-file (nth 0 position))
                (assert (buffer-live-p buffer))
                (switch-to-buffer (nth 1 position)))
              (goto-char (nth 2 position))
              (setq rjs-index index))))))))

(defun recent-jump-small-forward (arg)
  "���������ղŵ�λ��"
  (interactive "p")
  (recent-jump-small-backward (* -1 arg)))

(defun rjs-clean ()
  "�����ر���"
  (interactive)
  (setq rjs-index 0)
  (setq rjs-position-pre-command nil)
  (setq rjs-position-before nil)
  (while (not (ring-empty-p rjs-ring))
    (ring-remove rjs-ring)))

(define-minor-mode recent-jump-small-mode
  "Toggle `recent-jump-small' mode."
  :lighter rjs-mode-line-format
  :global t
  (let ((hook-action (if recent-jump-small-mode 'add-hook 'remove-hook)))
    (funcall hook-action 'pre-command-hook 'rjs-pre-command)
    (funcall hook-action 'post-command-hook 'rjs-post-command)))

(dolist (var (list 'rjs-ring 'rjs-index 'rjs-position-before))
  (add-to-list 'desktop-globals-to-save var))

(provide 'recent-jump-small)