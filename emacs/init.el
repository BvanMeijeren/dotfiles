;;; init.el --- Cleaned Emacs config -*- lexical-binding: t; -*-

;;----------------------------------------------------------------------------
;; Performance
;;----------------------------------------------------------------------------

(setq gc-cons-threshold (* 50 1000 1000)
      read-process-output-max (* 1024 1024) ; 1MB
      ring-bell-function #'ignore)

;; Native compilation
(setq native-comp-async-report-warnings-errors nil)

;;----------------------------------------------------------------------------
;; Package setup
;;----------------------------------------------------------------------------

(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("org"    . "https://orgmode.org/elpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

;;----------------------------------------------------------------------------
;; General UI
;;----------------------------------------------------------------------------

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(global-auto-revert-mode 1)
(global-display-line-numbers-mode 1)
(savehist-mode 1)
(electric-pair-mode 1)
(delete-selection-mode 1)

(setq inhibit-startup-screen t
      electric-indent-mode nil
      display-line-numbers-type 'relative
      tab-width 4
      make-backup-files nil
      auto-save-default nil
      line-spacing 0.12)

(set-face-attribute 'default nil
                    :height 120
                    :weight 'medium)

(add-to-list 'default-frame-alist '(alpha-background . 99)) ;; transparency

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(global-set-key [escape] #'keyboard-escape-quit)

;;----------------------------------------------------------------------------
;; Org auto tangle
;;----------------------------------------------------------------------------

(defun start/org-babel-tangle-config ()
  "Automatically tangle config.org on save."
  (when (and buffer-file-name
             (string-equal
              (file-truename (file-name-directory buffer-file-name))
              (file-truename user-emacs-directory)))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(defun start/org-mode-auto-tangle ()
  "Enable auto tangling for Org buffers."
  (add-hook 'after-save-hook #'start/org-babel-tangle-config nil t))

(add-hook 'org-mode-hook #'start/org-mode-auto-tangle)

;;----------------------------------------------------------------------------
;; Evil
;;----------------------------------------------------------------------------

(use-package evil
  :init
  (setq evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-undo-system 'undo-redo)

  :config
  (evil-mode 1)

  ;; force vim-style C-u scrolling
  (define-key evil-normal-state-map (kbd "C-u") #'evil-scroll-up)
  (define-key evil-motion-state-map (kbd "C-u") #'evil-scroll-up)

  (evil-set-initial-state 'eat-mode 'insert)

  :bind
  (:map evil-motion-state-map
        ("SPC" . nil)
        ("RET" . nil)
        ("TAB" . nil)))

;; Window navigation
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "M-h") #'evil-window-left)
  (define-key evil-normal-state-map (kbd "M-j") #'evil-window-down)
  (define-key evil-normal-state-map (kbd "M-k") #'evil-window-up)
  (define-key evil-normal-state-map (kbd "M-l") #'evil-window-right))

;;----------------------------------------------------------------------------
;; Key chord
;;----------------------------------------------------------------------------

(use-package key-chord
  :after evil
  :config
  (setq key-chord-two-keys-delay 0.4
        key-chord-one-key-delay 0.3)

  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jj" #'evil-normal-state))

;;----------------------------------------------------------------------------
;; Which key
;;----------------------------------------------------------------------------

(use-package which-key
  :init
  (which-key-mode 1)
  :custom
  (which-key-side-window-location 'bottom)
  (which-key-idle-delay 0.3)
  (which-key-max-description-length 25)
  (which-key-min-display-lines 6)
  (which-key-add-column-padding 1)
  (which-key-sort-uppercase-first nil)
  (which-key-allow-imprecise-window-fit nil))

;;----------------------------------------------------------------------------
;; General.el
;;----------------------------------------------------------------------------

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer start/leader-keys
    :states '(normal visual motion emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  ;; Files
  (start/leader-keys
    "f"  '(:ignore t :wk "Files")
    "ff" '(find-file :wk "Find file")
    "fr" '(consult-recent-file :wk "Recent files")
    "fg" '(consult-ripgrep :wk "Ripgrep")
    "fl" '(consult-line :wk "Find line")
    "fi" '(consult-imenu :wk "Imenu"))

  ;; Buffers
  (start/leader-keys
    "b"  '(:ignore t :wk "Buffers")
    "bb" '(consult-buffer :wk "Switch buffer")
    "bk" '(kill-current-buffer :wk "Kill buffer")
    "bi" '(ibuffer :wk "Ibuffer")
    "bn" '(next-buffer :wk "Next buffer")
    "bp" '(previous-buffer :wk "Previous buffer"))

  ;; Git
  (start/leader-keys
    "g"  '(:ignore t :wk "Git")
    "gg" '(magit-status :wk "Magit"))

  ;; Toggle
  (start/leader-keys
    "t"  '(:ignore t :wk "Toggle")
    "tt" '(visual-line-mode :wk "Wrap lines")
    "tl" '(display-line-numbers-mode :wk "Line numbers"))

  ;; Comment
  (start/leader-keys
    "c"  '(:ignore t :wk "Comment")
    "cc" '(comment-line :wk "Toggle comment")
    "cf" '(format-code :wk "Format code"))

  ;; Terminal
  (start/leader-keys
    "S"  '(:ignore t :wk "Shell")
    "se" '(eat :wk "Eat")))

;;----------------------------------------------------------------------------
;; Theme / modeline
;;----------------------------------------------------------------------------

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 5))

;;----------------------------------------------------------------------------
;; Dashboard
;;----------------------------------------------------------------------------

(use-package dashboard
  :init
  (setq dashboard-startup-banner 'official
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-items '((recents  . 5)
                          (projects . 5)
                          (bookmarks . 5)))
  :config
  (dashboard-setup-startup-hook))

;;----------------------------------------------------------------------------
;; Completion UI
;;----------------------------------------------------------------------------

(use-package vertico
  :init
  (vertico-mode 1)

  :bind
  (:map vertico-map
        ("C-j" . vertico-next)
        ("C-k" . vertico-previous)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package consult
  :hook
  (completion-list-mode . consult-preview-at-point-mode)

  :config
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  (advice-add #'register-preview :override #'consult-register-window)

  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

;;----------------------------------------------------------------------------
;; Corfu
;;----------------------------------------------------------------------------

(use-package corfu
  :init
  (global-corfu-mode 1)

  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-preview-current nil)
  (completion-ignore-case t)
  (tab-always-indent 'complete))

(use-package cape
  :after corfu
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;;----------------------------------------------------------------------------
;; Projectile
;;----------------------------------------------------------------------------

(use-package projectile
  :init
  (projectile-mode 1)

  :custom
  (projectile-run-use-comint-mode t)
  (projectile-switch-project-action #'projectile-dired)
  (projectile-project-search-path
   '("~/projects/"
     "~/work/"
     ("~/github" . 1))))

;;----------------------------------------------------------------------------
;; Magit / Git
;;----------------------------------------------------------------------------

(use-package magit
  :commands magit-status)

(use-package diff-hl
  :init
  (global-diff-hl-mode 1)

  :hook
  ((dired-mode         . diff-hl-dired-mode-unless-remote)
   (magit-pre-refresh  . diff-hl-magit-pre-refresh)
   (magit-post-refresh . diff-hl-magit-post-refresh)))

;;----------------------------------------------------------------------------
;; Eglot
;;----------------------------------------------------------------------------

(use-package eglot
  :ensure nil

  :hook
  ((go-mode
    python-mode
    c-mode
    c++-mode
    sql-mode
    nix-mode
    yaml-mode)
   . eglot-ensure)

  :custom
  (eglot-events-buffer-size 0)
  (eglot-autoshutdown t)
  (eglot-report-progress nil))

;;----------------------------------------------------------------------------
;; Languages
;;----------------------------------------------------------------------------

(use-package lua-mode
  :mode "\\.lua\\'")

(use-package nix-mode)

(use-package go-mode
  :mode "\\.go\\'"
  :hook (before-save . gofmt-before-save))

(use-package python-mode
  :mode "\\.py\\'")

(use-package yaml-mode
  :mode "\\.yml\\'")

(setq python-shell-interpreter "python3")

(use-package sql
  :ensure nil
  :hook
  (sql-mode . display-line-numbers-mode)
  :config
  (setq sql-indent-offset 2))

;;----------------------------------------------------------------------------
;; Formatting
;;----------------------------------------------------------------------------

(use-package format-all
  :preface
  (defun format-code ()
    "Auto-format region if active, otherwise format whole buffer."
    (interactive)
    (if (derived-mode-p 'prolog-mode)
        (prolog-indent-buffer)
      (format-all-region-or-buffer)))
  :config
  (global-set-key (kbd "M-f") #'format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter)
  ;; add formatters here
  (add-hook 'python-mode-hook #'(lambda ()
                                  (setq-local format-all-formatters '(("Python" yapf)))))
  (add-hook 'sql-mode-hook #'(lambda ()
                                  (setq-local format-all-formatters '(("SQL" pgformatter)))))
  (add-hook 'lua-mode-hook #'(lambda ()
                                  (setq-local format-all-formatters '(("Lua" luafmt)))))
  (add-hook 'yaml-mode-hook #'(lambda ()
                                  (setq-local format-all-formatters '(("Yaml" ymlfmt)))))
)

;;----------------------------------------------------------------------------
;; Org
;;----------------------------------------------------------------------------

(use-package org
  :ensure nil
  :custom
  (org-edit-src-content-indentation 4)
  (org-confirm-babel-evaluate nil)

  :hook
  (org-mode . org-indent-mode)

  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (sql . t)
     (shell . t)
     (emacs-lisp . t))))

(use-package toc-org
  :hook (org-mode . toc-org-mode))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode))

(use-package org-tempo
  :ensure nil)

;;----------------------------------------------------------------------------
;; Terminal
;;----------------------------------------------------------------------------

(use-package eat
  :hook (eshell-load . eat-eshell-mode))

;;----------------------------------------------------------------------------
;; Icons
;;----------------------------------------------------------------------------

(use-package nerd-icons
  :if (display-graphic-p))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

;; (use-package nerd-icons-ibuffer
;;  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode 1)
  (nerd-icons-completion-marginalia-setup))

;;----------------------------------------------------------------------------
;; Misc
;;----------------------------------------------------------------------------

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(add-hook 'prog-mode-hook #'hs-minor-mode)

(add-to-list 'display-buffer-alist
             '("\\*.*\\*"
               (display-buffer-reuse-window
                display-buffer-in-side-window)
               (side . bottom)
               (window-height . 12)))

;;----------------------------------------------------------------------------
;; Final GC tuning
;;----------------------------------------------------------------------------

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1000 1000))))

(provide 'init)
;;; init.el ends here
