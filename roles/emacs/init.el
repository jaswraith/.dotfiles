;; Set encodings
(setq-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; Don't litter init file with custom settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Set package archives
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Install and configure packages
(use-package diminish
  :ensure t)

(use-package spacemacs-theme
  :ensure t
  :defer t)

(use-package doom-themes
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package magit
  :ensure t)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :defer t
  :config
  (projectile-mode))

(use-package which-key
  :ensure t
  :defer t
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package helm
  :ensure t
  :diminish helm-mode
  :commands helm-mode
  :config
  (helm-mode))

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; BREAKS STUFF. modified files won't open in tramp
;;(use-package git-gutter
  ;;:ensure t
  ;;:config
  ;;(global-git-gutter-mode +1))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode))

;; Random settings
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(setq tab-width 4)
;;(setq tramp-default-method "sshx")
;;(setq tramp-syntax 'simplified)
(set-face-attribute 'default nil :height 145)

;; Set theme
(load-theme 'spacemacs-dark)

;; Random helpers
(defun my-open-init-file ()
  "Open the init file."
  (interactive)
  (find-file user-init-file))

;; Keybindings
(use-package general
  :ensure t
  :config
  (general-define-key
	;; :prefix leader
	:states '(normal insert emacs)
	:keymaps 'override
	:prefix "SPC"
	:non-normal-prefix "M-SPC"
	;; Files
	"f" '(:ignore t :which-key "Files")
	"f o" '(find-file :which-key "Find files")
	"f s" '(save-buffer :which-key "Save buffer")
	"f i" '(my-open-init-file :which-key "Open init.el")
	"f D" '(j/delete-file-and-buffer :which-key "Delete file and buffer")
	"f S" '(write-file :which-key "write-file")
	;; Buffers
	"b" '(:ignore t :which-key "Buffers")
	"b j" '(next-buffer :which-key "Next buffer")
	"b k" '(previous-buffer :which-key "Previous buffer")
	"b d" '(kill-current-buffer :which-key "Kill buffer")
	"b l" '(helm-buffers-list :which-key "List buffers")))
