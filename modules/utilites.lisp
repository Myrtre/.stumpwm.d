#|
(in-pakcage :stumpwm)

(add-to-load-path #p"~/.local/share/common-lisp/common-lisp/stumpwm-contrib/wpctl/")
(load-module "wpctl")
(setf wpctl:*modeline-fmt* "a %v")
(setf wpctl:*wpctl-path* "/home/davy/.guix-home/profile/wpctl")
(setf wpctl:*mixer-command* "playerctl")

(add-to-load-path #p"~/.local/share/common-lisp/common-lisp/stumpwm-contrib/bluetooth/")
(load-module "bluetooth")

(add-to-load-path #p"~/.local/share/common-lisp/common-lisp/stumpwm-contrib/end-session/")
(load-module "end-session")
(setf end-session:*end-session-command* "loginctl")

(add-to-load-path #p"~/.local/share/common-lisp/common-lisp/stumpwm-contrib/screenshot/")
(load-module "screenshot")
|#

