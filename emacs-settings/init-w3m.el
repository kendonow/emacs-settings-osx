

;(add-to-list 'load-path "~/emacs-setting/apel-10.8")
;(add-to-list 'load-path "~/emacs-setting/emacs-w3m")
;(add-to-list 'load-path "~/emacs-setting/flim")

;; (add-to-list 'load-path "~/emacs-w3m/")
;; (setq 
(require 'w3m)
(require 'w3m-load)
(require 'mime-w3m)
(autoload 'w3m "w3m" "interface for w3m on emacs" t) 

;; 设置w3m主页
(setq w3m-home-page "http://74.125.104.67")


;; (setenv http_proxy http://proxy.hogege.com:8000/)

(setq w3m-command-arguments
              (nconc w3m-command-arguments
                     '("-o" "http_proxy=http://10.10.77.136:808/")))


;; 默认显示图片
(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)

;; 使用cookies
(setq w3m-use-cookies t)

;;设定w3m运行的参数，分别为使用cookie和使用框架  
(setq w3m-command-arguments '("-cookie" "-F"))               

;; 使用w3m作为默认浏览器
(setq browse-url-browser-function 'w3m-browse-url)                
(setq w3m-view-this-url-new-session-in-background t)


;;显示图标                                                      
(setq w3m-show-graphic-icons-in-header-line t)                  
(setq w3m-show-graphic-icons-in-mode-line t) 

;;C-c C-p 打开，这个好用                                        
(setq w3m-view-this-url-new-session-in-background t)  

          
(add-hook 'w3m-fontify-after-hook 'remove-w3m-output-garbages)                                    

(defun remove-w3m-output-garbages ()                            
  "去掉w3m输出的垃圾."                                            
  (interactive)                                                   
  (let ((buffer-read-only))                                       
    (setf (point) (point-min))                                      
    (while (re-search-forward "[\200-\240]" nil t)                  
      (replace-match " "))                                            
    (set-buffer-multibyte t))                                       
  (set-buffer-modified-p nil))



(require 'color-theme-buffer-local)
(require 'color-theme-solarized)

(add-hook 'w3m-fontify-after-hook (lambda () 
                                    (linum-mode 1)
                                    (color-theme-buffer-local 'color-theme-solarized-dark (current-buffer))
))





;;  ;; w3m

;; ;load & init 





;; (autoload 'w3m "w3m" "interface for w3m on emacs" t)

;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; (autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)



;; ;settings

;; (setq w3m-use-cookies t)

;; (setq w3m-home-page "http://www.google.com")



;; (require 'mime-w3m) 

;; (setq w3m-default-display-inline-image t) 

;; (setq w3m-default-toggle-inline-images t)



(define-key w3m-lynx-like-map "\C-o" 'w3m-previous-anchor)
(define-key w3m-lynx-like-map "\C-j" 'w3m-previous-anchor)

(provide 'init-w3m)
