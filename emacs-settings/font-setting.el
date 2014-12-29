


;; Fonts setting
;; �����������������һ�����ĵ�һ��Ӣ�ĵ�
;; ֮�������������С����Ϊ�е����ĺ�Ӣ����ͬ�ֺŵ���ʾ��С��һ������Ҫ�ֶ�����һ�¡�
(defvar cjk-font-size 14)
(defvar ansi-font-size 14)
;
;; ����һ�����弯���õ���create-fontset-from-fontset-spec���ú���
;; ����һ�����壬Ӣ��һ�������ࡣ��ʾЧ���ܺá�
(defun set-font()
  (interactive)
  (create-fontset-from-fontset-spec
   (concat
    "-*-fixed-medium-r-normal-*-*-*-*-*-*-*-fontset-myfontset," 
    (format "ascii:-outline-Consolas-normal-normal-normal-mono-%d-*-*-*-c-*-iso8859-1," ansi-font-size)
    (format "unicode:-microsoft-Microsoft YaHei-normal-normal-normal-*-%d-*-*-*-*-0-iso8859-1," cjk-font-size)
    (format "chinese-gb2312:-microsoft-Microsoft YaHei-normal-normal-normal-*-%d-*-*-*-*-0-iso8859-1," cjk-font-size)
    ;; (format "unicode:-outline-��Ȫ��ȿ�΢�׺�-normal-normal-normal-sans-*-*-*-*-p-*-gb2312.1980-0," cjk-font-size)
    ;; (format "chinese-gb2312:-outline-��Ȫ��ȿ�΢�׺�-normal-normal-normal-sans-*-*-*-*-p-*-gb2312.1980-0," cjk-font-size)
    )))

;; ������������ÿ������2���ֺţ����48��
(defun increase-font-size()
  "increase font size"
  (interactive)
  (if (< cjk-font-size 48)
      (progn
        (setq cjk-font-size (+ cjk-font-size 2))
        (setq ansi-font-size (+ ansi-font-size 2))))
  (message "cjk-size:%d pt, ansi-size:%d pt" cjk-font-size ansi-font-size)
  (set-font)
  (sit-for .5))

;; ������������ÿ�μ�С2���ֺţ���С2��
(defun decrease-font-size()
  "decrease font size"
  (interactive)
  (if (> cjk-font-size 2)
      (progn 
        (setq cjk-font-size (- cjk-font-size 2))
        (setq ansi-font-size (- ansi-font-size 2))))
  (message "cjk-size:%d pt, ansi-size:%d pt" cjk-font-size ansi-font-size)
  (set-font)
  (sit-for .5))

;; �ָ���Ĭ�ϴ�С16��
(defun default-font-size()
  "default font size"
  (interactive)
  (setq cjk-font-size 16)
  (setq ansi-font-size 16)
  (message "cjk-size:%d pt, ansi-size:%d pt" cjk-font-size ansi-font-size)
  (set-font)
  (sit-for .5))

;; ֻ��GUI�����Ӧ�����塣Consoleʱ�����ն����塣
(if window-system
    (progn
      (set-font)
      ;; ����������弯���ó�Ĭ������
      ;; ���������ʹ����create-fontset-from-fontset-spec�����ĵ�һ�е���������ֶ�
      (set-frame-font "fontset-myfontset")

      ;; ����ݼ���
;      (global-set-key '[C-wheel-up] 'increase-font-size)
;      (global-set-key '[C-wheel-down] 'decrease-font-size)
;      ;; ���̿�ݼ���
 
     (global-set-key (kbd "C--") 'decrease-font-size) ;Ctrl+-
      (global-set-key (kbd "C-0") 'default-font-size)  ;Ctrl+0
      (global-set-key (kbd "C-=") 'increase-font-size) ;Ctrl+=
      ))



(provide 'font-setting)


