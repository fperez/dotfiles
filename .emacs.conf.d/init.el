;; -*- Mode: Emacs-Lisp -*-
;; Emacs configuration file. Fernando  Pérez.  This file will NOT work with
;; Xemacs, it has GNU Emacs-specific stuff in it.

;; Note: character code for declaring the input type of interactive arg:
;; http://www.gnu.org/software/emacs/elisp/html_node/Interactive-Codes.html

;; First, load init-common, where I define basic stuff loaded in all emacs
;; aliases I use
(load-file "~/.emacs.conf.d/init-common.el")

;;(scroll-bar-mode 0)

;;----------------------------------------------------------------------------
;; DEFAULTS FOR VARIOUS THINGS

(setq-default
 ;; Fonts
 font-menu-ignore-scaled-fonts nil
 font-lock-maximum-decoration t
 font-lock-use-colors t
 font-lock-use-fonts nil
 font-menu-ignore-scaled-fonts t
 ;; focus follows mouse within emacs buffers
 mouse-autoselect-window t
 ;; ido-mode lets you find files and buffers by typing a fraction of the name
 ido-mode t

 which-func-modes t 
 compile-command "make"
;; tool-bar-mode nil
 )

(delete-selection-mode 1)

;;*****************************************************************************
;; A properly functioning tab bar
;(require 'tabbar)
;(tabbar-mode)
;(global-set-key [C-prior] 'tabbar-backward)
;(global-set-key [C-next] 'tabbar-forward)

;;*****************************************************************************
;; Syntax highlighting and text hooks

;; Turn on font-lock (syntax highligting) everywhere:
(require 'font-lock )

;; This is supposedly obsolete, but I'm still finding code that calls it, so
;; I have my local private copy.
;(require 'lazy-lock)

;; Activate proper handling of ANSI color escapes
(require 'ansi-color)
(ansi-color-for-comint-mode-on)

;; autofill in all text modes
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'html-mode-hook 'turn-on-auto-fill)
(add-hook 'Tex-mode-hook 'turn-on-auto-fill)
(add-hook 'emacs-lisp-mode-hook 'turn-on-auto-fill)
(add-hook 'python-mode-hook 'turn-on-auto-fill)
(add-hook 'makefile-mode-hook 'turn-on-auto-fill)

;; C++ and C mode hooks...
(defun my-c-mode-hook ()
  (setq c-basic-offset 4)
;;  (setq tab-width 4)
  (define-key c-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c-mode-map "\C-ce" 'c-comment-edit)
  (setq c-auto-hungry-initial-state 'none)
  (setq c-tab-always-indent t)
;; BSD-ish indentation style
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c-brace-offset -4)
  (setq c-argdecl-indent 0)
  (setq c-label-offset -4)
  (setq auto-fill-function 'do-auto-fill)
  (local-set-key "\C-i" 'th-complete-or-indent)
)


;; Convenience function to add a section divider
(defun insert-section-divider ()
  (interactive)
  (insert "#-----------------------------------------------------------------------------\n")  
  )

;; And a full section header
(defun insert-section (name)
  "insert a section header"
  (interactive "sSection Name: ")
  (insert "#-----------------------------------------------------------------------------\n")
  (insert "# ")
  (insert name)
  (insert "\n#-----------------------------------------------------------------------------\n")
  )

(defun insert-docstring ()
  (interactive)
  (insert "    \"\"\"\n")
  (insert "\n")
  (insert "    Parameters\n")
  (insert "    ----------\n")
  (insert "\n")
  (insert "    Returns\n")
  (insert "    -------\n")
  (insert "\n")
  (insert "    \"\"\"\n")
  )

;; Add all of the hooks...
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(add-hook 'python-mode-hook
	  (lambda ()
	    (local-set-key "\C-i" 'th-complete-or-indent))
	  )

;; Tab/shift tab for indent/dedent, by Jason Grout
;; https://gist.github.com/1675277

;; Enable tab and shift-tab to continuously indent/dedent rst blocks
(add-hook 'rst-mode-hook
	  (function (lambda ()
		      (setq indent-region-function (lambda (&rest n)
						     (rst-shift-region-right nil)
						     (setq deactivate-mark nil)))
		      (local-set-key [S-tab] (lambda (&rest n) 
					       (interactive)
					       (if (use-region-p)
						   (progn (rst-shift-region-left nil)
							  (setq deactivate-mark nil)))))
		      )))


(add-hook 'python-mode-hook
          (function (lambda ()
		      (setq indent-region-function (lambda (&rest n)
                                                     (if (use-region-p)
                                                         (progn
                                                           (python-shift-right (region-beginning) (region-end))
                                                           (setq deactivate-mark nil)))))
                      (local-set-key [S-tab] (lambda (&rest n)
                                               (interactive)
                                               (if (use-region-p)
                                                   (progn (python-shift-left (region-beginning) (region-end))
                                                          (setq deactivate-mark nill))))))))


;; Add python mode hooks to show trailing whitespace in files
;;; (add-hook 'python-mode-hook
;;;          (lambda ()
;;;            (setq show-trailing-whitespace t)
;;;            ))

;;; (mapc (lambda (hook)
;;;      (add-hook hook (lambda ()
;;;           (setq show-trailing-whitespace t))))
;;;      '(python-mode-hook))

;; Use spaces instead of tabs for indentation
(defun indent-spaces-common-hook () 
  (setq indent-tabs-mode 'nil)
  )
;;
;; Turn this on for specfic modes. Some modes need tabs, like
;; makefile-mode
;;
(add-hook 'c-mode-hook 'indent-spaces-common-hook) 
(add-hook 'c++-mode-hook 'indent-spaces-common-hook)
(add-hook 'java-mode-hook 'indent-spaces-common-hook)
(add-hook 'js-mode-hook 'indent-spaces-common-hook)

;; CSS editing
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)
(setq auto-mode-alist
      (append '(("\\.css$" . css-mode))
	      auto-mode-alist))

;; Markdown
(autoload 'markdown-mode "markdown-mode" "Mode for editing Markdown files" t)
(setq auto-mode-alist
      (append '(("\\.md$" . markdown-mode))
	      auto-mode-alist))

;; Markdown
(autoload 'jinja2-mode "jinja2-mode" "Mode for editing Jinja2 files" t)
(setq auto-mode-alist
      (append '(("\\.j2$" . jinja2-mode))
	      auto-mode-alist))

; utf-8 support: doesn't work.  need to fix it so my compilation buffers
; look normal.
;(set-language-environment               'utf-8)
;(set-default-coding-systems             'utf-8)

;; ---------------------------------------------------------------------------
;; reStructuredText stuff
(require 'rst)
;(add-hook 'text-mode-hook 'rst-text-mode-bindings)

;; So that lists and enumerations which have no separating blank lines
;; reflow correctly instead of being mashed into one big paragraph:
;(add-hook 'text-mode-hook 'rst-set-paragraph-separation)

(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
		("\\.rest$" . rst-mode)
                ("\\.txt$" . rst-mode)
                ) auto-mode-alist))

(setq rst-shift-basic-offset '4)

;; Use reST by default for all non-code editing.
;;(setq default-major-mode 'rst-mode)

;; rst hooks for math editing, courtesy of John Hunter
(defun rst-insert-math ()
  "insert a math directive at point"
  (interactive)
  (insert ":math:`")
  ;(backward-char 1)
  )

(defun rst-insert-file ()
  "insert a file directive at point"
  (interactive)
  (insert ":file:`")
  ;(backward-char 1)
  )

(defun rst-insert-ref ()
  "insert a ref directive at point"
  (interactive)
  (insert ":ref:`")
  ;(backward-char 1)
  )

(defun rst-insert-command ()
  "insert a command directive at point"
  (interactive)
  (insert ":command:`")
  ;(backward-char 1)
  )

(add-hook 'rst-mode-hook
	  (lambda ()

	    ;; This hook is handy, but it tends to generate too many spurious
	    ;; changes when editing existing files.  Disable for now.
	    ;; (add-hook 'write-file-functions 'delete-trailing-whitespace)
	   
	    (define-key rst-mode-map "\C-cif" 'rst-insert-file)
	    (define-key rst-mode-map "\C-cim" 'rst-insert-math)
	    (define-key rst-mode-map "\C-cir" 'rst-insert-ref)
	    (define-key rst-mode-map "\C-cic" 'rst-insert-command)
            (define-key rst-mode-map "\C-_" 'rst-adjust)
	    (turn-on-font-lock))
	  )

;; ---------------------------------------------------------------------------
;; Python stuff

;; Configuration for IPython, thanks to Alex Schmolck.
;; For things to really work correctly, a recent (4.22 or newer) version
;; of python-mode.el is needed.

;; Basic call: this will get the system running in default mode.
;(setq py-shell-name "ipython")
;(require 'ipython)
;(setq-default py-python-command-args '("--pylab" "--colors" "LightBG"))
;(setq ipython-command "/home/fperez/usr/bin/ipython")
;; Configure the ipython call for pylab use

;;(setq py-python-command-args '("-pylab"))

(setq auto-mode-alist
      (append '(("\\.ipy$" . python-mode)) auto-mode-alist))

;;(require 'doctest-mode)

;; Use ropemacs, a fancy refactoring tool
;(require 'pymacs)
;(pymacs-load "ropemacs" "rope-")

;; Flymake with Pyflakes

;; code checking via flymake
;; set code checker here from "epylint", "pyflakes"
;(setq pycodechecker "pyflakes")

;(require 'flymake)
;(when (load "flymake" t)
;  (defun flymake-pyflakes-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;                       'flymake-create-temp-inplace))
;           (local-file (file-relative-name
;                        temp-file
;                        (file-name-directory buffer-file-name))))
;      (list "pyflakes" (list local-file)))
;    )
;  (add-to-list 'flymake-allowed-file-name-masks
;               '("\\.py\\'" flymake-pyflakes-init))

  ;; (defun flymake-pychecker-init ()
  ;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;; 		       'flymake-create-temp-inplace))
  ;; 	   (local-file (file-relative-name
  ;; 			temp-file
  ;; 			(file-name-directory
  ;; 			 buffer-file-name))))
  ;;     (list "/usr/local/bin/pyflakespep8.py" (list local-file)))
  ;;   )
  ;; (add-to-list 'flymake-allowed-file-name-masks
  ;; 	       '("\\.py\\'" flymake-pychecker-init))
;  )

;; Autoload flymake with loading files
;; this is Off for now, I turn it on manually
;;(add-hook 'find-file-hook 'flymake-find-file-hook)
;(custom-set-faces
; '(flymake-errline ((((class color)) (:background "DarkRed"))))
; '(flymake-warnline ((((class color)) (:background "DarkBlue")))))

;; Make code checking appear in buffer rather than as tooltip hint
;(load-library "flymake-cursor")

;;;; Cython' mode.

(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))

(define-derived-mode cython-mode python-mode "Cython"
  (font-lock-add-keywords
   nil
   ((,(concat "\\<\\(NULL"
               "\\|c\\(def\\|har\\|typedef\\)"
               "\\|e\\(num\\|xtern\\)"
               "\\|float"
               "\\|in\\(clude\\|t\\)"
               "\\|object\\|public\\|struct\\|type\\|union\\|void"
               "\\)\\>")
      1 font-lock-keyword-face t)))) 


;; *************************************************************************
;; FUNCTION DEFINITION SECTION

;; Taken from:
;; http://tsdh.wordpress.com/2006/12/02/using-tab-to-complete-and-indent/
(defun th-complete-or-indent (arg)
  "If preceding character is a word character and the following
character is a whitespace or non-word character, then
`dabbrev-expand', else indent according to mode."
  (interactive "*P")
  (cond ((and
          (= (char-syntax (preceding-char)) ?w)
          (looking-at (rx (or word-end (any ".,;:#=?()[]{}")))))
         (require 'sort)
         (let ((case-fold-search t))
           (dabbrev-expand arg)))
         (t
          (indent-according-to-mode))))

;;; 1999-07-12 Noah Friedman <friedman@splode.com>
;;; pour mettre un chmod +x si on trouve #! qqch :))
(defun make-buffer-file-executable-if-script-p ()
  "Make file executable according to umask if not already executable.
If file already has any execute bits set at all, do not change existing
file modes."
  (and (save-excursion
         (save-restriction
           (widen)
           (goto-char (point-min))
           (save-match-data
             (looking-at "^#!"))))
       (let* ((current-mode (file-modes (buffer-file-name)))
              (add-mode (logand ?\111 (default-file-modes))))
         (or (/= (logand ?\111 current-mode) 0)
             (zerop add-mode)
             (set-file-modes (buffer-file-name)
                             (logior current-mode add-mode))))))

(add-hook 'after-save-hook 'make-buffer-file-executable-if-script-p)
;; end of make-buffer-file-executable-if-script-p ()

;; From: http://www.geocities.com/kensanata/dot-emacs.html
;; create an indirect buffer
(defun indirect-buffer ()
  "Edit stuff in this buffer in an indirect buffer.
The indirect buffer can have another major mode from the original (useful to
edit a file that contains multiple languages in it, each buffer can be set to
each separate language while they all modify the same file."
  (interactive)
  (let ((buffer-name (generate-new-buffer-name "*indirect*")))
    (pop-to-buffer (make-indirect-buffer (current-buffer) buffer-name))))

(defun insert-date ()
  "Insert a simple date string."
  (interactive)
  (insert (format-time-string "%B %e, %Y")))

(defun insert-date-full ()
  "Insert a very detailed date string."
  (interactive)
  (insert (format-time-string "%A, %B %e, %Y %k:%M:%S %z")))


;; ---------------------------------------------------------------------------
;; Remove hard line breaks
;; http://blog.bookworm.at/2007/08/emacs-unfill-region.html

 (defun unfill-region (begin end)
  "Remove all linebreaks in a region but leave paragraphs, 
  indented text (quotes,code) and lines starting with an asterix (lists) intakt."
  (interactive "r")
  (replace-regexp "\\([^\n]\\)\n\\([^ *\n]\\)" "\\1 \\2" nil begin end))

;; ---------------------------------------------------------------------------
;; Word counting
;; http://sunsite.ualberta.ca/Documentation/Gnu/emacs-lisp-intro/html_node/emacs-lisp-intro_165.html

(defun count-words-region (beginning end)  
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

;; ---------------------------------------------------------------------------
;; Comint modes improvements

;; Alex Schmolck's mods to get ctrl p/n do history matching like I have in my
;; regular shells.
(require 'comint)
(define-key comint-mode-map [(control p)] 
  'comint-previous-matching-input-from-input)
(define-key comint-mode-map [(control n)] 
  'comint-next-matching-input-from-input)
(define-key comint-mode-map [(control meta n)]
  'comint-next-input)
(define-key comint-mode-map [(control meta p)]
  'comint-previous-input)

;; Nice up/down arrow enhancement for comint buffers, from:
;; http://www.jenandgreg.org/cgi-bin/gradwiki?action=browse&diff=1&id=Emacs

 ;;; Comint
 ;;; If the cursor is after the command prompt, make <up> and <down> do
 ;;; command history matching rather than just sequentially pulling
 ;;; commands from the history.  If the cursor is before the command
 ;;; prompt, make <up> and <down> do the normal cursor-movement stuff.
 ;;; Note that this means that you'll have to hit <left arrow> to get
 ;;; the cursor off of the command line so that <up> and <down> start
 ;;; moving the cursor instead of fooling around with the command history.
 
 (defun my-comint-history-keymaps () 
   (local-set-key [up] 
 		 '(lambda () 
 		    (interactive)
 		    (if (not (comint-after-pmark-p))
 			;; if we're before the prompt, move around
 			(previous-line 1)      
 		      ;; if we're after the prompt, do history matching
 		      (comint-previous-matching-input-from-input 1)   
 		      ;; fool comint into thinking that the last command was
 		      ;; comint-... b/c of the way it remembers the search
 		      ;; string
 		      (setq this-command
 		      'comint-previous-matching-input-from-input))))
   (local-set-key [down] 
 		 '(lambda () 
 		    (interactive)
 		    (if (not (comint-after-pmark-p))
 			(next-line 1)      
 		      (comint-next-matching-input-from-input 1)   
 		      (setq this-command
 		      'comint-next-matching-input-from-input)))))

;; Activate the function for all comint modes
(add-hook 'comint-mode-hook 'my-comint-history-keymaps t)

;;;; ***************** END OF Emacs init.el file *****************************
(put 'upcase-region 'disabled nil)
