(require 'auto-complete)

(require 'popup)

(defun popup-next-page (popup) 
  "" 
  (let* ((height (popup-height popup)) 
         (cursor (+ height (popup-cursor popup))) 
         (scroll-top (popup-scroll-top popup)) 
         (length (length (popup-list popup)))) 
    (cond ((>= cursor length) 
           (setq cursor 0   scroll-top 0)) 
          ((>= cursor (+ scroll-top height)) ;;
           (setq scroll-top (min (+ height scroll-top) 
                                 (max (- length height) 0))))) 
    (setf (popup-cursor popup) cursor (popup-scroll-top popup) scroll-top) 
    (popup-draw popup)))


(defun popup-previous-page (popup) 
  "" 
  (let* ((height (popup-height popup)) 
         (cursor (- (popup-cursor popup) height)) 
         (scroll-top (popup-scroll-top popup)) 
         (length (length (popup-list popup)))) 
    (cond ((< cursor 0) ;; Go to last page
           (setq cursor (1- length) scroll-top (max (- length height) 0))) 
          ((<= cursor (1- scroll-top)) 
           (decf scroll-top height))) 
    (setf (popup-cursor popup) cursor (popup-scroll-top popup) scroll-top) 
    (popup-draw popup)))


(defun ac-next-page () 
  "Select next candidate." 
  (interactive) 
  (when (ac-menu-live-p) 
    (popup-next-page ac-menu) 
    (setq ac-show-menu t) 
    (if (eq this-command 'ac-next-page) 
        (setq ac-dwim-enable t))))

(defun ac-previous-page () 
  "Select previous candidate." 
  (interactive) 
  (when (ac-menu-live-p) 
    (popup-previous-page ac-menu) 
    (setq ac-show-menu t) 
    (if (eq this-command 'ac-previous-page) 
        (setq ac-dwim-enable t))))



(define-key ac-completing-map "\C-v" 'ac-next-page)
(define-key ac-completing-map "\M-v" 'ac-previous-page)
(define-key ac-completing-map "\C-e" 'ac-complete)

(provide 'auto-complete-popup+ )
