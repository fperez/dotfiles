;; Font selections when being used with a windowing system.
(set-face-attribute 'default nil
		    :background "White"
		    :foreground "Black"
;		    :background "Black"
;		    :foreground "White"
		    :height 140
		    :family "Menlo"
;                    :family "Consolas"
;                    :family "Monaco"
                    )

(set-face-attribute 'bold nil
		    :bold t
;		    :family "Consolas"
		    )

(set-face-attribute 'custom-variable-button-face nil
;		    :family "Consolas"
		    :underline t
		    )

(set-face-attribute 'variable-pitch nil
		    :family "Tahoma")

;(set-face-attribute 'info-node nil
;		    :foreground "Blue"
;		    :bold t)

(set-face-attribute 'mode-line nil
		    :foreground "Black"
		    :background "Gray80")

(set-face-foreground 'font-lock-comment-face "Red")
(set-face-foreground 'font-lock-doc-string-face "Blue")
(set-face-foreground 'font-lock-function-name-face "Orange3")
(set-face-foreground 'font-lock-keyword-face "Green4")
(set-face-foreground 'font-lock-other-type-face "DarkOrange")
(set-face-foreground 'font-lock-preprocessor-face "Blue4")
(set-face-foreground 'font-lock-reference-face "Tan3")
(set-face-foreground 'font-lock-string-face "Blue")
(set-face-foreground 'font-lock-type-face "IndianRed4")
(set-face-foreground 'font-lock-variable-name-face "SeaGreen")
(set-face-foreground 'py-decorators-face "SaddleBrown")

(set-face-background 'show-paren-match "DarkSeaGreen1")
(set-face-background 'show-paren-mismatch "Firebrick2")
