(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(require 'ergoemacs-mode)
(setq ergoemacs-theme nil)
(setq ergoemacs-keyboard-layout "us")
(ergoemacs-mode 1)

(add-to-list 'load-path "~/.emacs.d/elpa/neotree-*")
(require 'neotree)
(global-set-key [f7] 'neotree-toggle)

;;(load-theme 'base16-macintosh t)
(load-theme 'base16-google-dark t)
;;(load-theme 'base16-google-light t)

(electric-pair-mode 1)

(require 'cider)
(require 'atomic-chrome)
(atomic-chrome-start-server)

(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

(setq backup-directory-alist `(("." . "~/.saves")))

(which-key-mode 1)
(show-paren-mode 1)

;; (tabbar-mode 1)
(undo-tree-mode 1)  
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

(set-fullscreen)

(projectile-mode 1)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require 'xterm-color)

(require 'use-package)

(require 'eshell) ; or use with-eval-after-load

(add-hook 'eshell-before-prompt-hook
          (lambda ()
            (setq xterm-color-preserve-properties t)))

(add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
(setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))
(setenv "TERM" "xterm-256color")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package xterm-color atomic-chrome k8s-mode projectile base16-theme which-key neotree ergoemacs-mode cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
