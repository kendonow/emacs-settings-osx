


(defface font-lock-dbg-face
  '((((class color) (background light)) (:foreground "DeepPink"))
    (((class color) (background dark)) (:foreground "Red3"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo Debug messages."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-dbg-face		'font-lock-dbg-face
  "Face name to use for OOo Debug messages.")

(defface font-lock-throws-face
  '((((class color) (background light)) (:foreground "Gray60"))
    (((class color) (background dark)) (:foreground "Gray80"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo THROWS statements."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-throws-face		'font-lock-throws-face
  "Face name to use for OOo THROWS statements.")

(defface font-lock-bugid-face
  '((((class color) (background light)) (:foreground "DarkGreen" :background "Wheat1"))
    (((class color) (background dark)) (:foreground "DarkRed" :background "Gray70"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo BugIDs."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-bugid-face		'font-lock-bugid-face
  "Face name to use for OOo BugIDs.")

(defface font-lock-sid-face
  '((((class color) (background light)) (:foreground "Aquamarine4"))
    (((class color) (background dark)) (:foreground "White"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo Slot IDs."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-sid-face		'font-lock-sid-face
  "Face name to use for OOo Slot IDs.")

(defface font-lock-brace-face
  '((((class color) (background light)) (:foreground "Red2"))
    (((class color) (background dark)) (:foreground "White"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for braces ()[]{} and the comma."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-brace-face		'font-lock-brace-face
  "Face name to use for braces.")

(defface font-lock-bool-face
  '((((class color) (background light)) (:foreground "forest green"))
    (((class color) (background dark)) (:foreground "lime green"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for boolean operators."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-bool-face		'font-lock-bool-face
  "Face name to use for boolean operators.")

(defface font-lock-exit-face
  '((((class color) (background light)) (:background "ivory1" :foreground "blue3"))
    (((class color) (background dark)) (:foreground "yellow"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for exit operations like return, break and exit."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-exit-face		'font-lock-exit-face
  "Face name to use for exit operations like return, break and exit.")

(defface font-lock-tag-face
  '((t (:foreground "dodger blue")))
  "Font Lock mode face used for tags in IDL files."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-tag-face		'font-lock-tag-face
  "Face name to use for tags in IDL files.")




;
;Keywords for Syntax Highlighting
;
;What is also useful are some keywords that can be used for syntax-highlighting (font-locking).
;Keywords for C++ Code
;

(defconst bm-throw-face-keywords
  (cons
   (regexp-opt
	(list
	 "SAL_CALL" "SAL_STATIC_CAST" "SAL_CONST_CAST" "SAL_REINTERPRET_CAST"
	 "__EXPORT" "NULL"
	 ) 'words)
   font-lock-throws-face
  ))
(defconst bm-additional-constant-keywords
  (cons
   (regexp-opt
	(list
	 "TRUE" "FALSE" "sal_True" "sal_False"
	 ) 'words)
   font-lock-constant-face
  ))
(defconst bm-strparam-keywords
  (cons
   (regexp-opt
	(list
	 "RTL_CONSTASCII_STRINGPARAM" "RTL_CONSTASCII_USTRINGPARAM"
	 "RTL_CONSTASCII_LENGTH" "RTL_TEXTENCODING_ASCII_US"
	 ) 'words)
   font-lock-constant-face
  ))
(defconst bm-exit-keywords
  (cons
   (regexp-opt
	(list
	 "return" "exit" "break" "continue" "goto"
	 ) 'words)
   font-lock-exit-face
  ))
(defconst bm-assert-keywords
  (cons
   (concat "\\<\\("
	(regexp-opt
	 (list
	  "OSL_DEBUG_ONLY" "OSL_TRACE" "OSL_ASSERT" "OSL_VERIFY" "OSL_ENSURE" "OSL_PRECOND" "OSL_POSTCOND"
	  ))
	"\\|DBG_\\sw+\\)\\>")
   font-lock-dbg-face
  ))
(defconst bm-const-keywords
  (list
   "\\<\\(\\(S\\|W\\)ID\\)_\\(\\sw+\\)"
   '(1 font-lock-sid-face)
   '(3 font-lock-constant-face)
  ))
(defconst bm-brace-keywords
  (cons
   "[][(){}]"
   font-lock-brace-face
  ))
(defconst bm-operator-keywords
  (cons
   "[|&]+"
   font-lock-bool-face
  ))

(font-lock-add-keywords
 'c++-mode
 (list
  bm-brace-keywords
  bm-operator-keywords
  bm-exit-keywords
  bm-additional-constant-keywords
  bm-const-keywords
  bm-throw-face-keywords
  bm-assert-keywords
  bm-strparam-keywords
  ))


;Keywords for IDL Files
(defconst bm-idl-keywords
  (cons
   (regexp-opt
	(list
	 "module" "interface" "service" "constants" "enum" "typedef" "struct"
	 "singleton" "exception" "raises" "property" "oneway"
	 ) 'words)
   font-lock-keyword-face
  ))
(defconst bm-idl-unused-keywords
  (cons
   (regexp-opt
	(list
	 "inout" "out" "observe" "needs" "attribute"
	 "union" "switch" "case" "array"
	 ) 'words)
   font-lock-throws-face
;   font-lock-keyword-face
  ))
(defconst bm-idl-types
  (cons
   (regexp-opt
	(list
	 "short" "long" "int" "hyper" "sequence" "boolean" "void" "string" "any"
	 "type" "float" "double" "byte" "unsigned"
	 ) 'words) font-lock-type-face ) )
(defconst bm-idl-builtin
  (cons
   (regexp-opt
	(list
	 "ifndef" "include" "endif" "define"
	 ) 'words)
   font-lock-builtin-face
  ))
(defconst bm-idl-property-flags
  (cons
   (regexp-opt
	(list
	 "readonly" "bound" "constrained" "maybeambiguous" "maybedefault"
	 "maybevoid" "optional" "removable" "transient" "in"
	 ) 'words)
   font-lock-constant-face
  ))
;
;;; Add the keyword groups you want to show
;(font-lock-add-keywords
; 'idl-mode
; (list
;  bm-idl-keywords
;  bm-idl-types
;  bm-idl-builtin
;  bm-brace-keywords
;  bm-idl-property-flags
;  bm-idl-unused-keywords
;))
;
;(font-lock-add-keywords
; 'idl-mode
; '(( "\\(</?\\)\\(atom\\|type\\|member\\|const\\|listing\\)\\(>\\)"
;	 (1 font-lock-tag-face)
;	 (2 font-lock-constant-face)
;	 (3 font-lock-tag-face))
;   ( "\\(<\\)\\(TRUE\\|FALSE\\|NULL\\|void\\)\\(/>\\)"
;	 (1 font-lock-tag-face)
;	 (2 font-lock-constant-face)
;	 (3 font-lock-tag-face))
;   ( "\\(@\\)\\(author\\|see\\|param\\|throws\\|returns?\\|version\\)"
;	 (1 font-lock-tag-face)
;	 (2 font-lock-constant-face))
; ))
;
(provide 'feigo-c-highlight)
