(in-package :stumpwm)

;; -------------- SWM-GAPS --------------------
;; SWM-Gaps - Border Gaps for frames
(load-module "swm-gaps")
;; Set gaps size
(setf swm-gaps:*head-gaps-size*  0
      swm-gaps:*inner-gaps-size* 4
      swm-gaps:*outer-gaps-size* 8)

(when *initializing*
  (swm-gaps:toggle-gaps))


;; -------------- Window Message Settings -------------
;; Rename and Create new Groups
(when *initializing*
  (grename "[HOME]")
  (gnewbg  "[DEV]")
  (gnewbg  "[WWW]")
  (gnewbg  "[ETC]"))

;; Clear Rules
(clear-window-placement-rules)


;; Window Split
(setf *dynamic-group-master-split-ratio* 1/2)

;; X window setting
;; Tell stumpwm to not honor application window size hints
(setf *ignore-wm-inc-hints* t)

;; Styling 'nd Stuff
(set-fg-color             gruvbox-dark06) ;; White
(set-border-color         gruvbox-dark09) ;; Orange
(set-msg-border-width     1)

(set-focus-color          gruvbox-dark09) ;; Orange
(set-unfocus-color        gruvbox-dark03) ;; None
(set-float-focus-color    gruvbox-dark09) ;; Orange
(set-float-unfocus-color  gruvbox-dark03) ;; None


;; Window format
(setf *window-format*              (format NIL "^(:fg \"~A\")<%25t>" gruvbox-dark0B)
      *window-border-style*        :thight
      *normal-border-width*        1
      *float-window-border*        1
      *hidden-window-color*        "^**"
      *float-window-title-height*  15)

;; Messaging & Input Window
(setf *key-seq-color* "^6")
(setf *which-key-format* (concat *key-seq-color* "*~5a^n ~a"))

;; Message Window Settings
(setf *message-window-padding*    1
      *message-window-y-padding*  1
      *message-window-gravity     :center)
(setf *input-window-gravity* :center)
