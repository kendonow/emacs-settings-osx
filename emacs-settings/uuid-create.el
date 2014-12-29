
;;;  -*- coding: utf-8; mode: emacs-lisp; -*-
;;; uuid.el ---
(defun uuid-create ()
  "Return a newly generated UUID. This uses a simple hashing of variable data."
  (let ((s (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                        (user-uid)
                        (emacs-pid)
                        (system-name)
                        (user-full-name)
                        user-mail-address
                        (current-time)
                        (emacs-uptime)
                        (garbage-collect)
                        (random)
                        (recent-keys)))))
    (format "%s-%s-%s-%s-%s"
            (substring s 0 8)
            (substring s 8 12)
            (substring s 12 16)
            (substring s 16 20)
            (substring s 20 32))))
;;This returns a string containing the UUID.
;;Next, make an interactive function to wrap it,
(defun uuid-insert ()
  "Inserts a new UUID at the point."
  (interactive)
  (insert (uuid-create)))


(defun uuid-convert-bit-to-hexstr (s)
  "convert uuid bit format to hex format."
;  (interactive)
  (save-excursion

(insert 
 (format "\n{0x%s,\
0x%s,\
0x%s,\
{0x%s,0x%s,\
0x%s,0x%s,\
0x%s,0x%s,\
0x%s,0x%s}}"
            (substring s 0 8)
 ;-
            (substring s 9 13)
;-
            (substring s 14 18)
;--

            (substring s 19 21)
            (substring s 21 23 )



            (substring s 24 26)
            (substring s 26 28 )

            (substring s 28 30)
            (substring s 30 32 )

            (substring s 32 34)
            (substring s 21 23 )

))

 ) 
 ; (insert (uuid-create))

)


(provide 'uuid-create)
