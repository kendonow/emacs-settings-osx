Miscellaneous emacs lisp files
=====

reveal-in-finder
-----

**Usage:**

- If ```M-x reveal-in-finder``` is invoked in a file-associated buffer, it will open the folder enclosing the file in the OS X Finder. It will also highlight the file the buffer is associated with within the folder.

- *(NEW in 0.3.0)* If ```M-x reveal-in-finder``` is invoked in a dired buffer, it will open the current folder in the OS X Finder. It will also highlight the file at point if available.

- If ```M-x reveal-in-finder``` is invoked in a buffer not associated with a file, it will open the folder defined in the default-directory variable.


**Installation**

This package depends on ```dired.el```, which should be available in the default emacs installation. It only works on the OS X environment on Macs.

It is available on the MELPA repository. Do the following, then choose and install reveal-in-finder.

To configure the MELPA, see this: http://melpa.milkbox.net/#/getting-started

```
M-x list-packages
```

If you prefer auto-install.el, you can do the following to install.
```lisp
(auto-install-from-url "https://raw.github.com/kaz-yos/elisp/master/reveal-in-finder.el")
```

Otherwise you can download the file from the URL below and place it somewhere in your path.
https://raw.github.com/kaz-yos/elisp/master/reveal-in-finder.el

Then, put the following in your emacs configuration file.

```lisp
;; To load at the start up
(require 'reveal-in-finder)
;; If you want to configure a keybinding (e.g., C-c z), add the following
(global-set-key (kbd "C-c z") 'reveal-in-finder)
```

**Special thanks:**

This is a modified version of the ```open-finder``` found at the URL below. Thank you elemakil and lawlist for introducing this nice piece of code,

http://stackoverflow.com/questions/20510333/in-emacs-how-to-show-current-file-in-finder

and Peter Salazar for pointing out a useful link about AppleScript (below),

http://stackoverflow.com/questions/11222501/finding-a-file-selecting-it-in-finder-issue

and mikeypostman and purcell for auditing the code for MELPA approval.
