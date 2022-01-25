;;;; ************************************************************************
;; STARTUP SECTION

(setq user-full-name "Fernando Perez")
(setq user-mail-address "Fernando.Perez@berkeley.edu")

;; find out how to call expand-file-name so that I can instead write
;; ~/.emacs.conf.d rather than /home/fperez/.emacs.conf.d...
(add-to-list 'load-path "~/.emacs.conf.d/lisp")
(add-to-list 'load-path "~/.emacs.conf.d/lisp/python-mode")

;; Don't show the GNU splash screen
(setq inhibit-startup-message t)

;;---------------------------------------------------------------------------
;; DEFAULTS FOR VARIOUS THINGS

(setq-default
 fill-column 79
 ;; scroll just one line when hitting the bottom of the window
 scroll-conservatively 1
 scroll-step 1
 ;; Pgup/dn will return exactly to the starting point.
 scroll-preserve-screen-position 1
 kill-whole-line t
 delete-key-deletes-forward t 
 line-number-mode t
 column-number-mode t
 ; dired mode 
 dired-listing-switches "-alF"
 list-directory-verbose-switches "-lF"
 ; so dabbrev doesn't ask every time on exit to save
 save-abbrevs nil
)

;; Activate show-paren mode
(show-paren-mode t)
(setq-default
 show-paren-style 'expression  ; Highlight whole region
)

(setq minibuffer-max-depth nil)

;; Stop the cursor from blinking
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode 0))

;; auto indent when I hit the ENTER key in all modes
(global-set-key "\C-m" 'newline-and-indent)

; so we don't have to type 'yes' in full every time
(fset 'yes-or-no-p 'y-or-n-p)

; typing replaces highligted selection always
(pending-delete-mode)

; suggested by Bo Peng on the ipython list, for vertically split windows to
; wrap long lines properly
(set-default 'truncate-partial-width-windows nil)

(setq indicate-buffer-boundaries 'right)

;; Basic python support
;(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;; XEmacs-like behavior, where the cursor gets narrower if at the end of the
;; line. Ref: http://osdir.com/ml/help-gnu-emacs-gnu/2010-01/msg00178.html
(defun narrow-eol-cursor ()
  (setq cursor-type (if (eolp) '(bar . 3) t))
  )
(add-hook 'post-command-hook 'narrow-eol-cursor)

;; Use matlab mode for all .m files
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

;; Use magit for git support
;; !! Disabled b/c it makes startup insanely slow at LBL machine.
;;(require 'magit)

;;; *************************************************************************
;; Basic Fonts setup - actual font selections are loaded in separate files
;; later

(require 'font-lock)

;; A few of these faces may not have been created, check them to avoid startup
;; error messages
(unless (facep 'custom-variable-button-face) (make-face
					      'custom-variable-button-face))
(unless (facep 'font-lock-doc-string-face) (make-face
					    'font-lock-doc-string-face))
(unless (facep 'font-lock-other-type-face) (make-face
					    'font-lock-other-type-face))
(unless (facep 'font-lock-reference-face) (make-face
					   'font-lock-reference-face))
(unless (facep 'py-decorators-face) (make-face 'py-decorators-face))
(unless (facep 'font-lock-preprocessor-face ) (make-face
					       'font-lock-preprocessor-face ))
(unless (facep 'comint-highlight-prompt ) (make-face 'comint-highlight-prompt ))
(unless (facep 'minibuffer-prompt ) (make-face 'minibuffer-prompt ))
(unless (facep 'show-paren-match ) (make-face 'show-paren-match ))
(unless (facep 'show-paren-mismatch ) (make-face 'show-paren-mismatch))

;;;; *************************************************************************
;; KEY BINDINGS SECTION

;; NOTE: Some of these modify classic Emacs behavior.  Keep them here so we can
;; quickly turn them off when sharing with other Emacs users

;; These first three are the most confusing to 'classic' emacs users
;(global-set-key "\C-s" 'save-buffer) ;  file save, replaces def. search binding
;(global-set-key "\C-\M-f" 'isearch-forward) ; find (was C-s) 
(global-set-key "\C-f" 'save-buffer)
;(global-set-key "\C-\M-s" 'save-buffer) ;  file save

(global-set-key "\C-o" 'other-window)

;; These change less-often used behavior
(global-set-key "\C-r" 'query-replace) ; replace (was M-%)
(global-set-key "\C-\M-r" 'replace-string) ; replace without prompt (in region)
(global-set-key "\C-l" 'dabbrev-expand)
(global-set-key "\C-z" 'undo)

;; Some Windows-like key bindings
(global-set-key [(shift delete)] 'kill-region)           ; cut
(global-set-key [(control insert)] 'copy-region-as-kill)  ; copy
(global-set-key [(shift insert)] 'yank)                   ; paste 
(global-set-key [(control delete)] 'kill-word)
(global-set-key [(control backspace)] 'backward-kill-word)

;; In terminal mode, C-home and home send the same sequence.  Since I use
;; C-a, C-e for regular home/end, I can rebind the home/end keys to buffer
;; navigation. 
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

;; get correct delete behavior
(define-key global-map [(delete)] "\C-d") 
;(global-set-key (read-kbd-macro "DEL") 'delete-char)

;; misc. bindings
(global-set-key "\C-\M-\\" 'indent-region) 

;; Function keys
;; call up the man page on the word under the cursor
;(global-set-key [(shift f1)] (lambda () (interactive) (manual-entry
;						       (current-word))))
;; common file/directory operations
(global-set-key [(f2)] 'save-buffer)  ; file save
(global-set-key [(f3)] 'find-file)    ; file open
;(global-set-key [(f4)] 'buffer-menu)
(global-set-key [(f4)] 'ibuffer)
(global-set-key [(f5)] 'dired)        ; directory open (in dired mode)
;; quick switching of common modes
(global-set-key [(f6)] 'rst-mode)
(global-set-key [(S-f6)] 'text-mode)
(global-set-key [(C-f6)] 'latex-mode)
(global-set-key [(f7)] 'doctest-mode)
(global-set-key [(f8)] 'python-mode)
(global-set-key [(C-f8)] 'flymake-mode)
(global-set-key [(S-f7)] 'fill-paragraph)
(global-set-key [(S-f8)] 'font-lock-fontify-buffer)
;; compilation support
(global-set-key [(f9)] 'compile)
;(global-set-key [(f10)] 'next-error)
;(global-set-key [(f11)] 'previous-error)

(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map "\C-b" 'isearch-repeat-backward)
(global-set-key "\C-\M-w" 'mark-whole-buffer)
(global-set-key "\M-g" 'goto-line) ; standard XEmacs
(global-set-key "\M-1" 'delete-other-windows)
(global-set-key "\M-2" 'split-window-vertically)

;; VI-like keyboard movement, but with M- prefix
(global-set-key "\M-h" 'backward-char)
;(global-set-key "\M-l" 'forward-char)
(global-set-key "\M-j" 'next-line)
(global-set-key "\M-k" 'previous-line)
(global-set-key "\M-n" 'scroll-up)
(global-set-key "\M-p" 'scroll-down)

(define-key text-mode-map [(control return)] 'fill-paragraph)
(define-key text-mode-map [(S)] 'self-insert-command)

(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\C-v" 'uncomment-region)

;; Since we can't use C-xcv to standardize on cut/copy/paste b/c
;; C-x is already a prefix for too many things, use C-,./ instead
;(global-set-key [(control ,)]'clipboard-kill-region)           ; cut
(global-set-key [(control \.)] 'clipboard-kill-ring-save)  ; copy
(global-set-key [(control /)] 'clipboard-yank)                   ; paste

;; Rebind C-x k to unconditionally kill the current buffer without asking.
(global-set-key "\C-xk" 'kill-this-buffer)

;; get wheelmouse working
(global-set-key [button4] 'scroll-down-one)
(global-set-key [button5] 'scroll-up-one)
(global-set-key [(control button4)] 'scroll-down-command)
(global-set-key [(control button5)] 'scroll-up-command)

;; Some older versions of emacs don't turn font-lock on by default
(global-font-lock-mode t)

;<f10> runs the command tmm-menubar, disable menu by default since it's useless
(menu-bar-mode -1)


;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'control)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be
    ;; right-delete
)

;; From: http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map [(meta right)] 'right-word )
(define-key my-keys-minor-mode-map [(meta left)] 'left-word )

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

