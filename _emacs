;;; .emacs -- This file is designed to be re-evaled; use the variable first-time
;; to avoid any problems with this.
;;; Commentary:
;;; Code:

(defvar first-time t
  "Flag signifying this is the first time that .emacs has been evaled.")

;; Supress the GNU startup message
(setq inhibit-startup-message t)

;; Prelude
(load-file "~/.emacs.d/init.el")
(setq prelude-guru nil)

;; ido mode extra config
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Appearance
(add-to-list 'default-frame-alist
	         '(font . "Iosevka Comfy-14"))
(setq ring-bell-function 'ignore)
(smooth-scrolling-mode 1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(defun load-spacemacs-theme ()
  (setq powerline-height 20)
  (load-theme 'gruvbox-dark-soft t)
  (spaceline-emacs-theme)
  (spaceline-compile)
  (spaceline-toggle-buffer-size-off))

(defun load-theme-in-frame (frame)
  (select-frame frame)
  (load-spacemacs-theme))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'load-theme-in-frame)
  (load-spacemacs-theme))

;; Basic global modes
(setq show-trailing-whitespace t)
(smartparens-global-mode t)
(setq-default tab-width 4)

;; key bindings
(setq map (make-sparse-keymap))
(setq ns-command-modifier 'meta)
(setq ns-option-modifier 'hyper) ; sets the Option key as Hyper
(setq ns-function-modifier 'super) ; sets the Option key as Super
(setq mac-command-modifier 'meta) ; sets the Command key as Meta
(setq mac-option-modifier 'hyper) ; sets the Option key as Hyper
(global-unset-key (kbd "<magnify-up>"))
(global-unset-key (kbd "<magnify-down>"))
;; (global-set-key "\M-g" 'goto-line)
(global-set-key "\C-z" nil)

(message "Configuration loaded.")
(provide '.emacs)
;;; .emacs ends here
