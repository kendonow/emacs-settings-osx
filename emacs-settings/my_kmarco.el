

(fset 'add-front-5*
   [?\C-a ?\M-w ?y ?\C-5 ?* ?  ?\C-n ?\C-a tab ?\C-n ?\C-a])

(fset 'remove-org-emphasis
   [?\M-f ?\M-b ?\C-2 backspace ?  ?\M-f ?\C-d])


(kmacro-push-ring (list 'add-front-5* 0 "%d"))
(kmacro-pop-ring)

(fset 'remove-org-emphasis-2
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote (
[?\M-f ?\M-b ?\C-2 backspace ?  ?\M-f ?\C-d]
;; [134217830 134217826 67108914 backspace 32 134217830 4]
 0 "%d")) arg)))


;; (fset 'add-memory-red-font
;;    [?\{ ?\{ ?\{ ?c ?l ?r ?\( ?r ?e ?d ?, tab ?\M-b ?\M-f ?\) ?\} ?\} ?\} tab])


(fset 'add-memory-red-font
      (lambda (&optional arg) "Keyboard macro." (interactive "p") 
        (kmacro-exec-ring-item 
         (quote (
                 [?\{ ?\{ ?\{ ?c ?l ?r ?\( ?r ?e ?d ?, tab ?\M-b ?\M-f ?\) ?\} ?\} ?\} tab])
                0 "%d")) arg))

(fset 'add-memory-blue-font
      (lambda (&optional arg) "Keyboard macro." (interactive "p") 
        (kmacro-exec-ring-item 
         (quote (
                 [?\{ ?\{ ?\{ ?c ?l ?r ?\( ?b ?l ?u ?d ?, tab ?\M-b ?\M-f ?\) ?\} ?\} ?\} tab])
                0 "%d")) arg))

(fset 'add-memory-blue-font
   [?\{ ?\{ ?\{ ?c ?l ?r ?\( ?b ?l ?u ?e ?, tab ?\M-b ?\M-f ?\) ?\} ?\} ?\} tab])

(kmacro-push-ring (list 'add-memory-red-font 0 "%d"))
(kmacro-pop-ring)
