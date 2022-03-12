;; Emacs configuration - Fernando Perez. 

;; Set the names of various config files, Emacs expects these variables to exist
(setq user-init-file
      (expand-file-name "init.el"
                        (expand-file-name ".emacs.conf.d" "~")) )
(setq custom-file
      (expand-file-name "custom.el"
                        (expand-file-name ".emacs.conf.d" "~")) )
 
;; Load General init ile
(load-file user-init-file)

;; Load options and fonts depending on whether we have a window manager or not
;; This works on OSX, Linux and Windows
(if (display-graphic-p)
    (progn
      ;; if graphic
      (load-file "~/.emacs.conf.d/init-wm.el")
      (load-file "~/.emacs.conf.d/fonts-wm.el")
      )
  ;; else (optional)
  ;; In a terminal, use a scheme good for dark backgrounds with ANSI escapes
  (load-file "~/.emacs.conf.d/fonts-nw.el")
  )

;; Load the Emacs-generated custom file
(load-file custom-file)
