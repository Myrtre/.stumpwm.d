(in-package :stumpwm)

;; Fonts
(load-module "ttf-fonts")
(setf xft:*font-dirs* (list (concat +guix-system-path+ "fonts/")
			    (concat +guix-home-path+ "fonts/"))
      clx-truetype:+font-cache-filename+ (concat (getenv "HOME")
						 "/.local/share/fonts/"
						 "font-cache.sexp"))

(xft:cache-fonts)
(set-font `(,(make-instance ; system
	      'xft:font :family "Hack"
	      :subfamily "Regular" :size 11 :antialias t)
	    ,(make-instance ; system - secondary
	      'xft:font :family "JetBrains Mono"
	      :subfamily "Regular" :size 11 :antialias t)
	    ,(make-instance ; Icons
	      'xft:font :family "FontAwesome"
	      :subfamily "Regular" :size 11 :antialias t)))

;; Colors
;; Colors actually in colors.lisp
(setq *colors* (list
		gruvbox-dark01
		gruvbox-dark08
		gruvbox-dark0B
		gruvbox-dark0A
		gruvbox-dark0D
		gruvbox-dark0C
		gruvbox-dark06
		;; Extra
		gruvbox-dark09
		gruvbox-dark0E))

(when *initializing*
  (update-color-map (current-screen)))
