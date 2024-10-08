;;; theme.lisp --- StumpWM theme -*- mode: common-lisp; -*-
;;; Commentary:
;;; Code:

;; -- Fonts -----
;; # Load Fonts dir
(setf xft:*font-dirs* (list (concat +guix-system-path+ "fonts/")
                            (concat +guix-home-path+ "fonts/"))
      clx-truetype:+font-cache-filename+ (concat (getenv "HOME")
                                                 "/.local/share/fonts/"
                                                 "font-cache.sexp"))
;; # Load Fonts
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
;; -- Styling -----
;; -- Focused
(set-focus-color gruvbox-dark0D)
(set-float-focus-color gruvbox-dark0D)
;; -- Unfocused
(set-unfocus-color gruvbox-dark01)
(set-float-unfocus-color gruvbox-dark03)
;; -- Text
(set-fg-color gruvbox-dark0D)
;; -- BG
(set-bg-color gruvbox-dark01)
;; -- Border
(set-border-color gruvbox-dark03)


(set-msg-border-width 1)

;; Set Mouse-Keys
(setf *mouse-focus-policy* :click
      *float-window-modifier* :SUPER)


;;; theme.lisp ends here
