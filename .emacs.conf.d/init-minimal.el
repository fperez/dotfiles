;; A minimal emacs configuration file for very fast startup times.  I use it as
;; the config file for this alias, which loads just about as fast as jed, but
;; provides a real, full-featured emacs:
;; emacs -nw --no-init-file --no-site-file  \
;;       --load $HOME/.emacs.conf.d/init-minimal.el

;; First, load init-common, where I define basic stuff loaded in all emacs
;; aliases I use
(load-file "~/.emacs.conf.d/init-common.el")

;; Since this is always used in -nw mode, load font defs for terminal use.
(load-file "~/.emacs.conf.d/fonts-nw.el")
