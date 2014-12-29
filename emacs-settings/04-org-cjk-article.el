(add-to-list 'org-export-latex-classes
                  '("cjk-article"
                    "\\documentclass{article}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(setq org-export-latex-packages-alist '(
    (""   "CJK"   t)
    (""     "indentfirst"  nil)
    ("pdftex"     "graphicx"  t)
    (""     "fancyhdr" nil)
    ("CJKbookmarks=true"     "hyperref"  nil)
"%% Define a museincludegraphics command, which is
%%   able to handle escaped special characters in image filenames.
\\def\\museincludegraphics{%
  \\begingroup
  \\catcode`\\\|=0
  \\catcode`\\\\=12
  \\catcode`\\\#=12
  \\includegraphics[width=0.75\\textwidth]
}"))

(defcustom org-latex-to-pdf-process
  '("pdflatex -interaction nonstopmode -output-directory %o %f"
    "iconv -f utf-8 -t gbk %b.out > %b.out.bak"
    "mv %b.out.bak %b.out"
    "gbk2uni %b.out"
    "pdflatex -interaction nonstopmode -output-directory %o %f"
    "rm %b.out.bak %b.tex"))


(provide '04-org-cjk-article)
