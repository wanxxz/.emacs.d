(setq frame-title-format "Emacs")

(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

(if window-system
    (progn
      (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
      (if (fboundp 'toggle-scroll-bar) (toggle-scroll-bar -1))))

(add-to-list 'default-frame-alist '(height . 75))
(add-to-list 'default-frame-alist '(width . 105))

(menu-bar-mode -1)
(column-number-mode t)
(hl-line-mode t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq desktop-save-mode t)

(setq create-lockfiles nil)

(global-auto-revert-mode t)

(setq completion-auto-help 'lazy)

(setq indent-line-function 'insert-tab)

(setq
  indent-tabs-mode nil
  tab-width 2
  tab-stop-list '(0 2 4))

(show-paren-mode t)

(setq set-mark-command-repeat-pop t)

(package-initialize)

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'quelpa)
  (package-refresh-contents)
  (package-install 'quelpa))

(require 'use-package)

(setq use-package-ensure-function 'quelpa)

(require 'quelpa)

(setq quelpa-update-melpa-p nil)

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)

(use-package multi-term
  :ensure t
  :quelpa t
  :config (setq multi-term-program "/bin/bash"))

(use-package wgrep
  :ensure t
  :quelpa t)

(use-package ido
  :config
  (ido-mode 'both)
  (setq ido-max-window-height 1
	ido-enable-flex-matching t
	ido-use-filename-at-point 'guess
	ido-enable-last-directory-history t))

(use-package projectile
  :ensure t
  :quelpa t
  :bind ("C-c p" . 'projectile-command-map)
  :config
  (projectile-mode)
  (setq projectile-switch-project-action 'projectile-vc))

(use-package dired
  :config (setq dired-listing-switches "-lhAX --group-directories-first"))

(use-package dired+
  :ensure t
  :quelpa (dired+ :fetcher github :repo "emacsmirror/dired-plus")
  :hook (dired-mode . (lambda () (diredp-toggle-find-file-reuse-dir 1))))

(use-package editorconfig
  :ensure t
  :quelpa t
  :config (editorconfig-mode 1))

(use-package dracula-theme
  :ensure t
  :quelpa t
  :config (load-theme 'dracula t))

(use-package switch-window
  :ensure t
  :quelpa t
  :bind ("C-x o" . switch-window))

(use-package magit
  :ensure t
  :quelpa t)

(use-package company
  :ensure t
  :quelpa t
  :config
  (global-company-mode t)
  (setq company-tooltip-align-annotations t))

(use-package which-key
  :ensure t
  :quelpa t
  :config
  (which-key-mode t))

(use-package lsp-mode
  :ensure t
  :quelpa t
  :init (setq lsp-keymap-prefix "C-c l")
  :hook
  (js-mode . lsp)
  (typescript-mode . lsp)
  (clojure-mode . lsp)
  (clojurescript-mode . lsp)
  (clojurc-mode . lsp)
  (web-mode . lsp)
  (rust-mode . lsp))

(use-package lsp-ui
  :ensure t
  :quelpa t
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable t
	lsp-ui-doc-enable t
	lsp-ui-peek-enable t))

(use-package flycheck
  :ensure t
  :quelpa t
  :config (global-flycheck-mode t))

(use-package js-mode
  :mode ("\\.jsx$" "\\.js$"))

(use-package typescript-mode
  :ensure t
  :quelpa t
  :mode ("\\.tsx$" "\\.ts$"))

(use-package clojure-mode
  :ensure t
  :quelpa t)

(use-package inf-clojure
  :ensure t
  :quelpa t)

(use-package web-mode
  :ensure t
  :quelpa t
  :custom-face
  (web-mode-html-tag-face ((t (:foreground "blue"))))
  (web-mode-html-tag-bracket-face ((t (:foreground "blue"))))
  :config
  (add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))
  (setq web-mode-engines-alist '(("svelte"  . "\\.svelte\\."))))

(use-package rust-mode
  :ensure t
  :quelpa t)
