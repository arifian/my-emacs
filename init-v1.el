(require 'package)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'ergoemacs-mode)
  (package-install 'ergoemacs-mode))
(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
(unless (package-installed-p 'base16-theme)
  (package-install 'base16-theme))
(unless (package-installed-p 'neotree)
  (package-install 'neotree))

(load-theme 'base16-macintosh t)

(add-to-list 'load-path "~/.emacs.d/elpa/neotree-*")
(require 'neotree)
(global-set-key [f7] 'neotree-toggle)

(require 'ergoemacs-mode)
(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-mode 1)

(electric-pair-mode 1)

(require 'cider)
;;(set-variable 'cider-repl-print-length 100)
;;(set-variable 'cider-repl-print-level 100)

;; (defun my-eshell-mode-hook ()
;;   "alt s set to nil"
;;   (local-set-key (kbd "M-s") nil))

(setq backup-directory-alist `(("." . "~/.saves")))

(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

(setq inf-clojure-program "planck")

;; (defun my-cider-repl-mode-config ()
;;   "alt s nil"
;;   (local-set-key (kbd "M-s") nil) ; example of remove a key
;;   ;; more here
;;   )

;; (add-hook 'eshell-mode-hook 'my-eshell-mode-hook)
;; (add-hook 'cider-repl-mode-hook 'my-cider-repl-mode-config)
(which-key-mode 1)
(show-paren-mode 1)

(tabbar-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(defvar fullscreen? t "Check if fullscreen is on or off")

(defun set-non-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
	  ;; WM_SYSCOMMAND restore #xf120
	  (w32-send-sys-command 61728)
	(progn (set-frame-parameter nil 'width 82)
		   (set-frame-parameter nil 'fullscreen 'fullheight))))

(defun set-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
	  ;; WM_SYSCOMMAND maximaze #xf030
	  (w32-send-sys-command 61488)
	(set-frame-parameter nil 'fullscreen 'fullboth)))

(defun toggle-fullscreen ()
  (interactive)
  (setq fullscreen? (not fullscreen?))
  (if fullscreen?
	  (set-non-fullscreen)
	(set-fullscreen)))

;; (defun cider-repl-reset ()
;;   (interactive)
;;   (save-some-buffers)
;;   (with-current-buffer (cider-current-repl-buffer)
;;     (goto-char (point-max))
;;     (insert \"(dev/reset)\")
;;     (cider-repl-return)))

;; (global-set-key (kbd "C-c r") 'cider-repl-reset)

(set-fullscreen)

(projectile-mode +1)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
