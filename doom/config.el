;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kara Brightwell"
      user-mail-address "kara@153.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka" :size 13 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Galaxie Polaris" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-classic)

(setq fancy-splash-image "~/.doom.d/emacs.png")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq mac-mouse-wheel-smooth-scroll t)

(setq lsp-auto-guess-root t)

(setq-default indent-tabs-mode t)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

;; vim-vinegar-like dired ui and - to open
(setq dired-hide-details-hide-symlink-targets nil)
(add-hook 'dired-mode-hook #'dired-setup)
(map! :n "-" #'dired-jump)

(defun dired-setup ()
  (dired-hide-details-mode t)
  (dired-omit-mode t)

  ;; allow selection with mouse
  (make-local-variable 'mouse-1-click-follows-link)
  (setq mouse-1-click-follows-link nil)

  (local-set-key (kbd  "<mouse-1>") #'dired-mouse-click))

(defun dired-mouse-click (event)
  "In Dired, visit the file or directory name you click on."
  (interactive "e")
  (let (window pos file)
    (save-excursion
      (setq window (posn-window (event-end event))
            pos (posn-point (event-end event)))
      (if (not (windowp window))
          (error "No file chosen"))
      (set-buffer (window-buffer window))
      (goto-char pos)
      (setq file (dired-get-file-for-visit)))
    (find-alternate-file file)))


(add-hook 'prog-mode-hook #'whitespace-mode)
(add-hook 'prog-mode-hook #'visual-line-mode)

(setq projectile-project-search-path '("~/Projects/" "~/Work/"))
(setq projectile-auto-discover t)

(projectile-rails-global-mode)

(setq whitespace-line-column nil
      whitespace-style
      '(face indentation tabs tab-mark spaces space-mark newline newline-mark
        trailing)
      whitespace-display-mappings
      '((tab-mark ?\t [?› ?\t])
        (newline-mark ?\n [?⁋ ?\n])
        (space-mark ?\  [?·] [?.])))

;; (map! :map evil-mc-key-map [mouse-1] #'evil-mc-undo-all-cursors)

(set-evil-initial-state! 'vterm-mode 'insert)
(map! :map vterm-mode-map :gin [M-left] #'vterm-send-M-b)
(map! :map vterm-mode-map :gin [M-right] #'vterm-send-M-f)
(map! :map vterm-mode-map :gin [M-backspace] #'vterm-send-C-w)
(map! :map vterm-mode-map :gin [s-left] #'vterm-send-C-a)
(map! :map vterm-mode-map :gin [s-right] #'vterm-send-C-e)
(map! :map vterm-mode-map :gin [s-backspace] #'vterm-send-C-u)

(after! magit
  (set-popup-rules!
    '(("^magit" :side left :width 60 :slot 1 :quit t :select t :modeline t)
      ("\\*transient\\*" :side left :width 60 :height 30 :slot 2 :quit nil :select nil :modeline nil)
      ("COMMIT_EDITMSG" :side left :width 60 :height 0.3 :slot 2 :quit nil :select t :modeline t)
      ("^magit-diff" :side left :width 60 :height 0.7 :slot 1 :quit t :select nil :modeline t))))

(setq magit-blame-styles
      '((margin
	 (margin-format " %s%f" " %C %a" " %H")
	 (margin-width . 42)
	 (margin-face . magit-blame-margin)
	 (margin-body-face magit-blame-dimmed))))

(setq magit-blame-disable-modes '(fci-mode yascroll-bar-mode whitespace-mode))
(setq magit-blame-buffer-read-only t)

(setq transient-show-popup 2)

(setq evil-vsplit-window-right t)
(setq evil-split-window-below t)
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
