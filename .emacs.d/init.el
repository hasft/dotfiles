(progn ;     startup
  (defvar before-user-init-time (current-time)
    "Value of `current-time' when Emacs begins loading `user-init-file'.")
  (message "Loading Emacs...done (%.3fs)"
           (float-time (time-subtract before-user-init-time
                                      before-init-time)))
  (setq user-init-file (or load-file-name buffer-file-name))
  (setq user-emacs-directory (file-name-directory user-init-file))
  (message "Loading %s..." user-init-file)
  ;;  (message (getenv "SHELL"))
  (setq package-enable-at-startup nil)
  ;; (package-initialize)
  (setq inhibit-startup-buffer-menu t)
  (setq inhibit-startup-screen t)
  (setq inhibit-startup-echo-area-message "locutus")
  (setq initial-buffer-choice t)
  (setq initial-scratch-message "Hello... start by (C-c pp)")
  (setq load-prefer-newer t)
  (setq create-lockfiles nil)
  (setq make-backup-files nil) ; stop creating backup~ files
  (setq auto-save-default nil) ; stop creating #autosave# files
  (setq ring-bell-function 'ignore)
    (dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]  
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k)))

(progn ; user info
  (setq user-full-name "Haska")
  (setq user-mail-address "haskafikritauhid@gamil.com"))

(progn ; basic view
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (when window-system (add-hook 'prog-mode-hook 'hl-line-mode))
  (setq line-number-mode t)
  (setq column-number-mode t))

(if (member "Source Code Pro" (font-family-list))
    (set-frame-font "Source Code Pro"))

;;; basic Movement
(progn ;
  (setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
  (setq auto-window-vscroll nil)
  (setq scroll-preserve-screen-position 1)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-follow-mouse 't) 
  (setq scroll-step 1))

;;; interactivity
(progn
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq kill-ring-max 100))

;;; Basic Editing
(progn
  (set-charset-priority 'unicode)
  (setq locale-coding-system   'utf-8)   ; pretty
  (set-terminal-coding-system  'utf-8)   ; pretty
  (set-keyboard-coding-system  'utf-8)   ; pretty
  (set-selection-coding-system 'utf-8)   ; please
  (prefer-coding-system        'utf-8)   ; with sugar on top
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  (setq-default indent-tabs-mode nil)
  (show-paren-mode 1)
  (add-hook 'lisp-mode-hook '(lambda ()
                               (local-set-key (kbd "RET") 'newline-and-indent)))
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq indent-line-function 'insert-tab))

;;; BASIC KEY BINDING
(progn
  (global-set-key (kbd "<s-return>") 'ansi-term))

;;; ---------------------------------------------------------------------------------------------------------End startup
;;; setup straightel
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

;;; ---------------------------------------------------------------------------------------------------------End PACKAGE MANAGER

(use-package better-shell
    :bind (("C-'" . better-shell-shell)
           ("C-;" . better-shell-remote-open)))

(use-package exec-path-from-shell
  :init
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

(use-package doom-themes
  :init
  (load-theme 'doom-one t)
  :config
  (progn
    (doom-themes-org-config)))

(use-package restart-emacs
  :demand t
  :bind ("C-x q" . restart-emacs))

(use-package golden-ratio
  :demand t
  :init
  :config
  (golden-ratio-mode 1))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume) ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-lcount-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package counsel
  :after ivy
  :bind
  (("M-x" . counsel-M-x)
   ("C-c C-m" . counsel-M-x)
   ("C-x C-m" . counsel-M-x)
   ("C-x m" . counsel-M-x)
   ("C-x C-f" . counsel-find-file))
  :custom
  (counsel-find-file-ignore-regexp "\\.DS_Store\\|.git"))

(use-package swiper
  :bind (("C-s" . swiper)))

(use-package projectile
  :demand t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

(use-package aggressive-indent
  :config
  (aggressive-indent-global-mode 1))

(use-package multiple-cursors
  :init
  (progn
    (global-set-key (kbd "C-c .") 'mc/mark-next-like-this)
    (global-set-key (kbd "C->") 'mc/mark-next-like-this)
    (global-set-key (kbd "C-c ,") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-c C-l") 'c/mark-all-like-this)))

(use-package magit
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

;; hydra: tie related commands into a family of short bindings with a common
;; prefix - a Hydra
;; https://github.com/abo-abo/hydra
(use-package hydra
  :config (hydra-add-font-lock))


;;; ---------------------------------------------------------------------------------------------------------End BASE

(use-package smartparens
  :demand t
  :diminish smartparens-mode
  :config
  (progn
  (require 'smartparens-config)
  (smartparens-global-mode 1))
  (sp-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))

(use-package yasnippet
  :init (yas-global-mode 1)
  :config
  (setq yas-triggers-in-field t))

(use-package flycheck
  :bind ("C-c h f" . hydra-flycheck/body)
  :config
  ;; (add-hook 'typescript-mode-hook 'flycheck-mode)
  (defhydra hydra-flycheck (:color blue
                                   :hint nil)
    "
  ^
  ^Flycheck^          ^Errors^            ^Checker^
  ^────────^──────────^──────^────────────^───────^─────
  _q_ quit            _<_ previous        _?_ describe
  _M_ manual          _>_ next            _d_ disable
  _v_ verify setup    _f_ check           _m_ mode
  ^^                  _l_ list            _s_ select
  ^^                  ^^                  ^^
  "
    ("q" nil)
    ("<" flycheck-previous-error :color pink)
    (">" flycheck-next-error :color pink)
    ("?" flycheck-describe-checker)
    ("M" flycheck-manual)
    ("d" flycheck-disable-checker)
    ("f" flycheck-buffer)
    ("l" flycheck-list-errors)
    ("m" flycheck-mode)
    ("s" flycheck-select-checker)
    ("v" flycheck-verify-setup)))

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))
  (use-package yasnippet-snippets
    :demand t)

  (yas-global-mode 1))

;;; ---------------------------------------------------------------------------------------------------------GLOBAL

(use-package markdown-mode)
(use-package bazel-mode
  :mode ("\\.bazel\\'" . bazel-mode)("\\.bzl\\'" . bazel-mode))
;;; ---------------------------------------------------------------------------------------------------------End BASE

(eval-and-compile
  (add-to-list 'load-path (locate-user-emacs-file "modules/")))

(require 'config-dashboard)
(require 'config-grep)
(require 'config-company)
(require 'config-yaml)
(require 'config-js)
(require 'config-rust)
