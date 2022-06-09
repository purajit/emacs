(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(csv-separators '("," ";"))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "939ea070fb0141cd035608b2baabc4bd50d8ecc86af8528df9d41f4d83664c6a" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" default))
 '(fci-rule-color "#383838")
 '(indent-tabs-mode nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(terraform-mode latex-preview-pane puppet-mode lua-mode go-mode groovy-mode coffee-mode scss-mode thrift csv-mode yaml-mode gruvbox-theme indent-guide geiser json-mode js2-mode rainbow-mode elisp-slime-nav counsel swiper ivy helm-projectile helm lsp-ui rainbow-delimiters spaceline powerline smooth-scrolling spacemacs-theme exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number move-text magit projectile imenu-anywhere hl-todo guru-mode gitconfig git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring beacon anzu ace-window))
 '(safe-local-variable-values '((flycheck-disabled-checkers emacs-lisp-checkdoc)))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(setq prelude-packages (append package-selected-packages prelude-packages))

;; Install my packages
(prelude-install-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JavaScript
(setq js-indent-level 2)
(setq-default js2-basic-offset 2)
(message "Ready for launch, %s." (user-login-name))

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2)))

;; use spaces only. no tabs
;; and don't use tabs for indentation
(customize-set-variable 'indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq python-indent-offset 4)
            (setq python-indent-level 4)
            (setq-default indent-tabs-mode nil)
            (setq indent-tabs-mode nil)
            (let ((ptw (if (boundp 'me-my-python-tab-width) me-my-python-tab-width 4)))
              (progn (setq tab-width ptw)
                     (set-variable 'py-indent-offset ptw)
                     (setq python-indent ptw)))))

(require 'indent-guide)
(add-hook 'python-mode-hook 'indent-guide-mode)
(add-hook 'ruby-mode-hook 'indent-guide-mode)

(defcustom TeX-buf-close-at-warnings-only t
  "Close TeX buffer if there are only warnings."
  :group 'TeX-output
  :type 'boolean)

(defun my-tex-close-TeX-buffer (_output)
  "Close compilation buffer if there are no errors.
Hook this function into `TeX-after-compilation-finished-functions'."
  (let ((buf (TeX-active-buffer)))
    (when (buffer-live-p buf)
      (with-current-buffer buf
        (when (progn (TeX-parse-all-errors)
                     (or
                      (and TeX-buf-close-at-warnings-only
                           (null (cl-assoc 'error TeX-error-list)))
                      (null TeX-error-list)))
          (cl-loop for win in (window-list)
                   if (eq (window-buffer win) (current-buffer))
                   do (delete-window win)))))))

(add-hook 'TeX-after-compilation-finished-functions #'my-tex-close-TeX-buffer)
