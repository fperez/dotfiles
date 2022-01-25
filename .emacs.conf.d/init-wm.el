;; Set here options that are only valid when a windowing system is active

;; starting geometry and colors
(setq default-frame-alist
      '((width . 81) (height . 60) ; default geometry
	(cursor-type . box)
	(cursor-color . "red")
	)
      )

(menu-bar-mode t)

; With X11, C-home/end are separate from home/end
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [(control home)] 'beginning-of-buffer)
(global-set-key [(control end)] 'end-of-buffer)

;; Activate the scrollbar on the right
(setq scroll-bar-mode 'right)
(toggle-scroll-bar t)

;; The fringe is a GUI-only feature
(set-fringe-mode '(0 . 2))
(setq right-fringe-width 4)

;; So that we can always connect to it
(server-start)

;; *************************************************************************
;; FUNCTION DEFINITION SECTION
(defun set-font-size (num)
  "Interactively change the default font size"
  (interactive "nEnter a font size (>~81): ")
  (set-face-attribute 'default nil
		      :height num
		      )
  )

(defun desktop-font ()
  "Set font size for desktop use (size 100)"
  (interactive)
  (set-face-attribute 'default nil
		      :height 100
		      )
  )

(defun laptop-font ()
  "Set font size for desktop use (size 110)"
  (interactive)
  (set-face-attribute 'default nil
		      :height 110
		      )
  )

;; XXX - For some reason, this state saver below is causing me problems in
;; text-only mode...  It seems to mess up the buffer positioning state, and
;; page up/down stop working altogether (regardless of keybinding used, it's
;; the actual scrolling that breaks).  Until I figure this out, I'll have to
;; stop using the state saver in terminal mode...

;;;; *************************************************************************
;; STATE SAVER FUNCTION
;; Save names and cursor positions of all loaded files in ".emacs.files"
;; Taken from http://www.gkrueger.com/java/emacs.html, Guido Krueger.
(defun gk-state-saver ()
  (interactive)
  (setq fname (format "%s.emacs.files" gk-startdir))
  (cond 
   ((buffer-file-name)
    (setq currentbuffer (buffer-name)))
   (t
    (setq currentbuffer nil)))
  (cond
   ((y-or-n-p (format "Save state to %s? " fname))
	(switch-to-buffer "*state-saver*")
	(kill-buffer "*state-saver*")
	(switch-to-buffer "*state-saver*")
	(setq bl (buffer-list))
	(while bl
	  (setq buffer (car bl))
	  (setq file (buffer-file-name buffer))
	  (cond 
	   (file 
		(insert "(find-file \"" file "\")\n")
		(switch-to-buffer buffer)
		(setq mypoint (point))
		(switch-to-buffer "*state-saver*")
		(insert (format "(goto-char %d)\n" mypoint))))
	  (setq bl (cdr bl)))
	(cond
	 (currentbuffer
	  (insert (format "(switch-to-buffer \"%s\")\n" currentbuffer))))
	(set-visited-file-name fname)
	(save-buffer)
	(kill-buffer ".emacs.files")
	(cond
	 (currentbuffer
	  (switch-to-buffer currentbuffer))))))

;--- Save state when killing emacs ----------
(add-hook 
 'kill-emacs-hook
 '(lambda () 
    (gk-state-saver)))

;--- Remember from where emacs was started --
;(defvar gk-startdir default-directory)
(defvar gk-startdir "~/")

;--- Load files from .emacs.files -----------
(cond
 ((file-exists-p "~/.emacs.files")
  (load-file "~/.emacs.files")))

;; END OF STATE SAVER FUNCTION
