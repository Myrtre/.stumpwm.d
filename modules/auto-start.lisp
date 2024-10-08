;;; auto-start.lisp --- Startup -*- mode: common-lisp; no-lexical-bindings: t;  -*-
;;; Commentary:
;; Start X11 Environment for StumpWM
;;; Code:

;;|--> Functions

(in-package :stumpwm)

;; -- UI -----
;;|--> Cursor
;;(run-shell-command "xsetroot -xcf")
;; Turn of system bell & screen-saver control
(run-shell-command "xset b off")
(run-shell-command "xset s off")
;; Wallpaper
(run-shell-command "feh --bg-scale ~/.dots/.files/img/wallhaven-cyberpunk.png")
;; Screen Compositor
(run-shell-command "picom")
;; Enable screen locking on suspend
(run-shell-command "xss-lock -- i3lock-fancy")
;; Additional XOrg Resource + Runs
(run-shell-command "xrdb -merge ~/.Xresources")
;; Start Emacs Server
(run-shell-command "emacs --daemon")

(require :slynk)
;; -- Initializing -----
(when *initializing*
  (slynk:create-server
   :style slynk:*communication-style*
   :dont-close t))

;; -- Hard Load keybindings as thread ------
(defvar *bind-thread-list*
  (list *my-wm-window-thread*
        *my-app-key-thread*
        *my-media-key-thread*
        *my-unprefixed-module-thread*))
(dolist (threadname *bind-thread-list*)
  (bt:join-thread threadname))

;;; auto-start.lisp ends here
