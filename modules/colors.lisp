;;; colors.lisp --- Color Settings for StumpWM -*- mode: common-lisp; -*-
;;; Commentary:
;;; Code:

;; -- Gruvbox-dark -----
;; Author: morhetz (github.com/morhetz/gruvbox)
(defvar gruvbox-dark00 "#1D2021")  ;; ----   ;; bg0 (dark-gray)
(defvar gruvbox-dark01 "#3C3836")  ;; ---    ;; bg1 (gray)
(defvar gruvbox-dark02 "#504945")  ;; --     ;; bg2 (light-gray)
(defvar gruvbox-dark03 "#665C54")  ;; -      ;; bg3 (lighter gray)
(defvar gruvbox-dark04 "#BDAE93")  ;; +      ;; fg3 (grayish-white)
(defvar gruvbox-dark05 "#D5C4A1")  ;; ++     ;; fg2 
(defvar gruvbox-dark06 "#EBDBB2")  ;; +++    ;; fg1
(defvar gruvbox-dark07 "#FBF1C7")  ;; ++++   ;; fg0
(defvar gruvbox-dark08 "#FB4934")  ;; red
(defvar gruvbox-dark09 "#FE8019")  ;; orange
(defvar gruvbox-dark0A "#FABD2F")  ;; yellow
(defvar gruvbox-dark0B "#B8BB26")  ;; green
(defvar gruvbox-dark0C "#8EC07C")  ;; aqua/cyan
(defvar gruvbox-dark0D "#83A598")  ;; blue
(defvar gruvbox-dark0E "#D3869B")  ;; purple
(defvar gruvbox-dark0F "#D65D0E")  ;; brown

;; Set as color-map
(defvar *color-map*
  '((myr-black         . gruvbox-dark00) 
    (myr-darkest-gray  . gruvbox-dark01)
    (myr-darker-gray   . gruvbox-dark02)
    (myr-dark-gray     . gruvbox-dark03)
    (myr-light-gray    . gruvbox-dark04)
    (myr-lighter-gray  . gruvbox-dark05)
    (myr-lightest-gray . gruvbox-dark06)
    (myr-white         . gruvbox-dark07)
    (myr-red           . gruvbox-dark08)
    (myr-orange        . gruvbox-dark09)
    (myr-yellow        . gruvbox-dark0A)
    (myr-green         . gruvbox-dark0B)
    (myr-aqua          . gruvbox-dark0C)
    (myr-blue          . gruvbox-dark0D)
    (myr-purple        . gruvbox-dark0E)
    (myr-brown         . gruvbox-dark0F)))

;; Directly create colors by *color-map*
(setf *colors*
      (mapcar (lambda (color-name)
                (eval (cdr (assoc color-name *color-map*))))
              '(myr-black  ;;   ^0 : 1
                myr-red    ;;   ^1 : 2
                myr-green  ;;   ^2 : 3
                myr-yellow ;;   ^3 : 4
                myr-blue   ;;   ^4 : 5
                myr-purple ;;   ^5 : 6
                myr-aqua   ;;   ^6 : 7
                myr-white  ;;   ^7 : 8
                myr-orange ;;   ^8 : 9
                myr-light-gray)));; ^9 : 10

(update-color-map (current-screen))
