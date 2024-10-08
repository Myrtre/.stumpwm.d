;;; frame.lisp --- Frame based Setting for StumpWM -*- mode: common-lisp; -*-
;;; Commentary:
;;; Code:


;; -------------- SWM-GAPS --------------------
;; SWM-Gaps - Border Gaps for frames
;; Set gaps size
(setf swm-gaps:*head-gaps-size*  0
      swm-gaps:*inner-gaps-size* 6
      swm-gaps:*outer-gaps-size* 10)
(when *initializing*
  (swm-gaps:toggle-gaps))

;; -------------- Window Message Settings -------------
;; Rename and Create new Groups
(when *initializing*
  (grename "[HOME]")
  (gnewbg  "[DEV]")
  (gnewbg  "[WWW]")
  (gnewbg  "[ETC]"))
(define-frame-preference "[HOME]" (nil t t :class "Tiling"))
(define-frame-preference "[DEV]" (nil t t :class "Tiling"))
(define-frame-preference "[WWW]" (nil t t :class "Tiling"))
(define-frame-preference "[ETC]" (nil t t :class "Stack"))
;;|--> Clear Rules
(clear-window-placement-rules)
;;|--> Group Format
(setf *group-format* "%n")
;;|--> Window Split
(setf *dynamic-group-master-split-ratio* 1/2)
;; -- X window settings -----
(setf *ignore-wm-inc-hints* t)     ; Tell StumpWM to not honor application window size hints
;; -- Window format -----
(setf *window-format*              (format NIL "^(:fg \"~A\")<%c>" (nth 8 *colors*))
      *window-border-style*        :thight
      *normal-border-width*        1
      *hidden-window-color*        "^**")
;;|--> Time-format
(setf *time-modeline-string* "%I:%M%p")
;; -- Messaging & Input Window -----
(setf *key-seq-color* "^6")
(setf *which-key-format* (concat *key-seq-color* "*~5a^n ~a"))
;;|--> Message Windows
(setf *message-window-padding*    1
      *message-window-y-padding*  1
      *message-window-gravity*    :top)

(setf *input-window-gravity* :center)
(setq *ignore-wm-inc-hints* t)


;;; frame.lisp ends here
