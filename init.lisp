;;; init.lisp --- StumpWM init file -*- mode: common-lisp; -*-
;;; Commentary:
;;; Code:

;;; -- Boilerplate -----
;; Quicklisp Setup
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
;; Load Quicklisp Packages
(ql:quickload '("stumpwm"
                "clx"
                "cl-ppcre"
                "alexandria"
                "cl-fad"
                "xembed"
                "anaphora"
                "drakma"
                "slynk"))
;; Optimize
(declaim (optimize (speed 3) (safety 3)))
;; Compile FASL
(setq *block-compile-default* t)

;; automaticly use :stumpwm prefix
(in-package :stumpwm)
(setf *default-package* :stumpwm)

;; # GUIX
;; Define GUIX profiles
(defconstant +guix-system-path+ "/run/current-system/profile/share/"
  "Define Guix System profile PATH")
(defconstant +guix-home-path+ "/home/davy/.guix-home/profile/share/"
  "Define Guix Home profile PATH")
(defconstant +guix-profile+ "/home/davy/.guix-profile/share/"
  "Define Guix Profile PATH")

;; Set PATHs for guix-modules
;; Old Code, didn't delete because of 'consistency
;; (set-module-dir (concat +guix-system-path+
;;                        "common-lisp/sbcl/"))

(setf *data-dir* (concat (getenv "HOME")
                         "~/.stumpwm.d/data/"))

(setf *startup-message* nil)

(setf *altgr-offset* 4)      ;; Set up AltGr key to work
(register-altgr-as-modifier)

;; -- Modules & Libs -----
;; SET StumpWM-contrib lib
(set-module-dir "~/.stumpwm.d/libraries")
;; List of used StumpWM-contrib
(defvar *modulenames*
  (list "ttf-fonts"
        "kbd-layouts"
        "swm-gaps"
        "swm-ssh"
        "stumptray"
        "hostname"
        "searchengines"
        "beckon"
        "globalwindows"
        "urgentwindows"))
;; Load StumpWM-contrib addons
(dolist (modulename *modulenames*)
  (load-module modulename))

;; # Modules
(defvar myr/mod-directory
  (directory-namestring
   (merge-pathnames ".stumpwm.d/modules/"
                    (user-homedir-pathname)))
  "A directory wih initially loaded StumpWM Module files.")

(defun myr/load (filename)
  "Load a file FILENAME (without extension) from `myr/mod-directory`."
  (let ((file (merge-pathnames (concat filename ".lisp")
                               myr/mod-directory)))
    (if (probe-file file)
        (load file)
        (format *error-output* "File '~a' doesn't exist." file))))

(myr/load "colors")
(myr/load "theme")
(myr/load "frames")
(myr/load "keybindings")
;;(myr/load "modeline")

;; -- Environment Variables -----
(setf (getenv "PAGER") "less -R")


(myr/load "auto-start")

;; Welcome
(setf *startup-message*
      (concatenate 'string "^2Welcome ^BDavy^b! "
                   "Your ^BStumpWM^b session is ready."))

;;; init.lisp ends here
