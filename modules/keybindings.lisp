;;; keybinds.lisp --- Keybinds for StumpWM -*- mode: common-lisp; -*-
;;; Commentary:
;;; Code:


;;; -- Remove Old Defaults -----
(defvar *gross-default-binds*
  (list "c" "C-C" "e" "C-e" "d" "C-d" "SPC"
        "i" "f" "C-k" "w" "C-w" "a" "C-a"
        "C-t" "R" "O" "TAB" "F" "C-h" "v"
        "#" "m" "C-m" "l" "C-l" "G" "C-N"
        "A" "X" "C-SPC" "I" "r" "W" "+"
        "RET" "C-RET" "C-0" "C-1" "C-2"
        "C-3" "C-4" "C-5" "C-6" "C-7"
        "C-8" "C-9" "0" "1" "2" "3" "4"
        "5" "6" "7" "8" "9"))

;; Remove 'default keys
(dolist (bind *gross-default-binds*)
  (define-key *root-map* (kbd bind) NIL))

;;; -- Create Function for My new Binds -----
(defmacro make-keymap (map-name key-binding &optional root top)
  `(progn
     (defvar ,map-name
       (let ((map (make-sparse-keymap)))
         map))
     (when ,root
       (define-key *root-map* (kbd ,key-binding) ,map-name))
     (when ,top
       (define-key *top-map* (kbd ,key-binding) ,map-name))))

;; -- Create Prefixes
(make-keymap *search-map* "M-s" t t)
(make-keymap *media-map*  "M-m" t t)
(make-keymap *app-map*    "M-a" t t)

;;; -- Create Binding Macro -----
;; Bind shell command to a specified map (default is *root-map*)
;; Old way from Phundark
(defmacro bind-shell-to-key (key command &optional (map *root-map*))
  `(define-key ,map (kbd ,key) (concatenate 'string " " ,command)))
;; Bind StumpWM command to a specified map (default is *root-map*)
(defmacro bind-to-key (key command &optional (map *root-map*))
  `(define-key ,map (kbd ,key) ,command))

;;; -- Loop & Bind Macro -----
;; Loop through keybinding lists and bind them
(defmacro loop-and-bind (key-cmd-list bind-macro &optional (map *root-map*))
  `(bt:make-thread
    (lambda ()
      (dolist (key-cmd ,key-cmd-list)
        (,bind-macro (first key-cmd) (second key-cmd) ,map)))))

;; Define own runner commands

(defcommand emacsclient () ()
  (run-or-raise "emacsclient -c -a 'emacs' --frame-parameters='(quote (name . \"emacsclient\"))'" '(:title "emacsclient" :class "emacsclient" :instance "emacsclient")))

(defcommand urxvt () ()
  (run-or-raise "urxvt" '(:title "urxvt" :class "urxvt" :instance "urxvt")))

(defcommand librewolf () ()
  (run-shell-command "librewolf"))

(defcommand nyxt () ()
  (run-shell-command "nyxt"))


;; Push/Pop Current Window Into a Floating group
(defcommand toggle-float () ()
  (if (float-window-p (current-window))
      (unfloat-this)
      (float-this)))


;;; -- Own Keybindings -----
;; Grouped =>

;; [App]
;; Set Shell Keys
(defvar *my-shell-key-commands*
  '(("c" "urxvt")
    ("C-c" "urxvt")
    ("L" "i3lock-fancy")))
;; Set App Keys
(defvar *my-app-key-commands*
  '(("p" "emacsclient -e '(rune/app-launcher)'")
    ("l" "librewolf")
    ("n" "nyxt")
    ("e" "emacsclient")
    ("E" "emacs")
    ("C-e" "emacsclient -e '(kill-emacs)' && emacs --daemon")))

;; [Media]
;; Set Playerctl Keys
(defvar *my-media-key-commands*
  '(("p" "playerctl play-pause")
    ("s" "playerctl stop")
    ("b" "playerctl previous")
    ("n" "playerctl next")
    ("z" "playerctl shuffle toggle")))

;; [Root]
;; Raw StumpWM Window-managing Commands
(defvar *my-wm-window-commands*
  '(("M-ESC" "mode-line")
    ("M-q" "quit")
    ("m" "mark")
    ("C-b" "banish")
    ("RET" "expose")
    ("C-Up" "exchange-direction up")
    ("C-Down" "exchange-direction down")
    ("C-Left" "exchange-direction left")
    ("C-Right" "exchange-direction right")
    ("p" "toggle-float")
    ("M-p" "flatten-floats")
    ("/" "toggle-gaps")))

;; [Unprefixed]
;; Unprefixed Module Commands
(defvar *my-unprefixed-module-commands*
  '(("M-Tab" "select-previous-window")
    ("s-Tab" "windowlist-last")
    ("XF86AudioMute" "toggle-mute")
    ("XF86AudioRaiseVolume" "playerctl volume 0.05+")
    ("XF86AudioLowerVolume" "playerctl volume 0.05-")))

;; -- Loop & Bind with Macros from earlier -----
;; The List of binds
(defparameter *key-bindings*
  '((*my-shell-key-thread* *my-shell-key-commands* bind-shell-to-key *app-map*)
    (*my-app-key-thread* *my-app-key-commands* bind-shell-to-key *app-map*)
    (*my-unprefixed-module-thread* *my-unprefixed-module-commands* bind-to-key *top-map*)
    (*my-media-key-thread* *my-media-key-commands* bind-shell-to-key *media-map*)
    (*my-wm-window-thread* *my-wm-window-commands* bind-to-key *root-map*)))

;; Loop over list
(dolist (binding *key-bindings*)
  (destructuring-bind (name commands binding-fn map) binding
    (eval `(defvar ,name
             (loop-and-bind ,commands ,binding-fn ,map)))))


;; -- Search Binds -----
;; Set browser engine to search
(setf searchengines:*search-browser-executable* "librewolf")

;; Macro for search
(defmacro define-searchengine (selection-name prompt-name url description key-selection key-prompt)
  `(progn
     (searchengines:make-searchengine-selection ,selection-name ,url ,description :map *search-map* :key ,key-selection)
     (searchengines:make-searchengine-prompt ,prompt-name ,description ,url ,description :map *search-map* :key ,key-prompt)))

;; Set Search Params
(defparameter *URL-WIKI* "https://en.wikipedia.org/w/index.php?title=Special:Search&search=~a")

(defparameter *URL-GUIX-PACKAGE* "https://packages.guix.gnu.org/packages/~a")

(define-searchengine "search-wikipedia-selection" "search-wikipedia-prompt" *URL-WIKI* "Wikipedia Search" "C-w" "w")

(define-searchengine "search-guix-package" "search-guix-package-prompt" *URL-GUIX-PACKAGE* "Guix Package" "C-g" "g")

(which-key-mode)
;;; keybinds.lisp ends here
