;; The default is 800 kilobytes. Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))
(setq ring-bell-function 'ignore)

(defun start/org-babel-tangle-config ()
  "Automatically tangle our Emacs.org config file when we save it. Credit to Emacs From Scratch for this one!"
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'start/org-babel-tangle-config)))

(require 'use-package-ensure) ;; Load use-package-always-ensure
(setq use-package-always-ensure t) ;; Always ensures that a package is installed
(setq package-archives '(("melpa" . "https://melpa.org/packages/") ;; Sets default package repositories
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/"))) ;; For Eat Terminal

(use-package evil
  :init
  (evil-mode)
  :custom
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil)
  (evil-undo-system 'undo-redo)
  (org-return-follows-link t)
  :config
  (evil-set-initial-state 'eat-mode 'insert)
  :bind (:map evil-motion-state-map
              ("SPC" . nil)
              ("RET" . nil)
              ("TAB" . nil)))

(use-package key-chord
  :after evil
  :config
 (setq key-chord-two-keys-delay 0.4)   ;; Max time (in seconds) between the two keys
 (setq key-chord-one-key-delay 0.3)    ;; Delay when both keys are the same (like "jj")

  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))

(use-package general
              :config
              (general-evil-setup)
              ;; Set up 'SPC' as the leader key
              (general-create-definer start/leader-keys
                :states '(normal insert visual motion emacs)
                :keymaps 'override
                :prefix "SPC"           ;; Set leader key
                :global-prefix "C-SPC") ;; Set global leader key

              (start/leader-keys
                "." '(find-file :wk "Find file")
                "TAB" '(comment-line :wk "Comment lines")
                "p" '(projectile-command-map :wk "Projectile command map"))

              (start/leader-keys
                "f" '(:ignore t :wk "Find")
                "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
                "f r" '(consult-recent-file :wk "Recent files")
                "f f" '(consult-fd :wk "Fd search for files")
                "f g" '(consult-ripgrep :wk "Ripgrep search in files")
                "f l" '(consult-line :wk "Find line")
                "f i" '(consult-imenu :wk "Imenu buffer locations"))

              (start/leader-keys
                "b" '(:ignore t :wk "Buffer Bookmarks")
                "b b" '(consult-buffer :wk "Switch buffer")
                "b k" '(kill-this-buffer :wk "Kill this buffer")
                "b i" '(ibuffer :wk "Ibuffer")
                "b n" '(next-buffer :wk "Next buffer")
                "b p" '(previous-buffer :wk "Previous buffer")
                "b r" '(revert-buffer :wk "Reload buffer")
                "b j" '(consult-bookmark :wk "Bookmark jump"))

              (start/leader-keys
                "d" '(:ignore t :wk "Dired")
                "d v" '(dired :wk "Open dired")
                "d j" '(dired-jump :wk "Dired jump to current"))

              (start/leader-keys
                "e" '(:ignore t :wk "Eglot Evaluate")
                "e e" '(eglot-reconnect :wk "Eglot Reconnect")
                "e f" '(eglot-format :wk "Eglot Format")
                "e l" '(consult-flymake :wk "Consult Flymake")
                "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
                "e r" '(eval-region :wk "Evaluate elisp in region"))

              (start/leader-keys
                "g" '(:ignore t :wk "Git")
                "g g" '(magit-status :wk "Magit status"))

              (start/leader-keys
                "h" '(:ignore t :wk "Help") ;; To get more help use C-h commands (describe variable, function, etc.)
                "h q" '(save-buffers-kill-emacs :wk "Quit Emacs and Daemon")
                "h r" '((lambda () (interactive)
                          (load-file "~/.config/emacs/init.el"))
                        :wk "Reload Emacs config"))

              (start/leader-keys
                "s" '(:ignore t :wk "Show")
                "s e" '(eat :wk "Eat terminal"))

              (start/leader-keys
                "t" '(:ignore t :wk "Toggle")
                "t t" '(visual-line-mode :wk "Toggle truncated lines (wrap)")
                "t l" '(display-line-numbers-mode :wk "Toggle line numbers")))

            ;; use vim motions for window navigation 
        (define-key evil-normal-state-map (kbd "M-h") 'evil-window-left)
        (define-key evil-normal-state-map (kbd "M-l") 'evil-window-right)
        (define-key evil-normal-state-map (kbd "M-j") 'evil-window-down)
        (define-key evil-normal-state-map (kbd "M-k") 'evil-window-up)

    ;; Text zooming like doom emacs, without shift
    (global-set-key (kbd "C-=") 'text-scale-increase)  ;; C-+ (on most keyboards)
    (global-set-key (kbd "C-+") 'text-scale-increase)  ;; for some layouts
    (global-set-key (kbd "C--") 'text-scale-decrease)
    (global-set-key (kbd "C-0") (lambda () (interactive) (text-scale-set 0)))
;; in vertico (the buffer switch menu triggered with SPC b b) I want j and k to navigate vim-like
(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "j") 'vertico-next)
  (define-key vertico-map (kbd "k") 'vertico-previous))

(use-package emacs
  :custom
  ;; hide some UI stuff
  (menu-bar-mode nil)         ;; Disable the menu bar
  (scroll-bar-mode nil)       ;; Disable the scroll bar
  (tool-bar-mode nil)         ;; Disable the tool bar
  (inhibit-startup-screen t)  ;; Disable welcome screen

  (delete-selection-mode t)   ;; Select text and delete it by typing.
  (electric-indent-mode nil)  ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing

  (blink-cursor-mode nil)     ;; Don't blink cursor
  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed

  ;;(dired-kill-when-opening-new-dired-buffer t) ;; Dired don't create new buffer
  ;;(recentf-mode t) ;; Enable recent file mode

  ;;(global-visual-line-mode t)           ;; Enable truncated lines
  ;;(display-line-numbers-type 'relative) ;; Relative line numbers
  (global-display-line-numbers-mode t)  ;; Display line numbers
  
  (tab-width 4)

  (make-backup-files nil) ;; Stop creating ~ backup files
  (auto-save-default nil) ;; Stop creating # auto save files
  :hook
  (prog-mode . (lambda () (hs-minor-mode t))) ;; Enable folding hide/show globally
  :config
  ;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
  (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  (load custom-file 'noerror 'nomessage)
  :bind (
         ([escape] . keyboard-escape-quit) ;; Makes Escape quit prompts (Minibuffer Escape)
         )
  ;; Fix general.el leader key not working instantly in messages buffer with evil mode
  :ghook ('after-init-hook
          (lambda (&rest _)
            (when-let ((messages-buffer (get-buffer "*Messages*")))
              (with-current-buffer messages-buffer
                (evil-normalize-keymaps))))
          nil nil t)
  )

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t)) ;; We need to add t to trust this package

(use-package dashboard
  :ensure t
  :init
  (setq inhibit-startup-screen t)
  (setq dashboard-startup-banner 'official)
  (setq dashboard-center-content t)         ;; Center content
  (setq dashboard-set-heading-icons t)      ;; Optional: adds icons
  (setq dashboard-set-file-icons t)         ;; Optional: adds file icons
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (bookmarks . 5)))
  :config
  (dashboard-setup-startup-hook))

(add-to-list 'default-frame-alist '(alpha-background . 80)) ;; For all new frames henceforth

(set-face-attribute 'default nil
                    ;; :font "JetBrains Mono" ;; Set your favorite type of font or download JetBrains Mono
                    :height 120
                    :weight 'medium)
;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.

;;(add-to-list 'default-frame-alist '(font . "JetBrains Mono")) ;; Set your favorite font
(setq-default line-spacing 0.12)

(use-package emacs
  :bind
  ("C-+" . text-scale-increase)
  ("C--" . text-scale-decrease)
  ("<C-wheel-up>" . text-scale-increase)
  ("<C-wheel-down>" . text-scale-decrease))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 25)     ;; Sets modeline height
  (doom-modeline-bar-width 5)   ;; Sets right bar width
  (doom-modeline-persp-name t)  ;; Adds perspective name to modeline
  (doom-modeline-persp-icon t)) ;; Adds folder icon next to persp name

(defun smooth-scroll-down ()
  "Scroll down smoothly by half a page."
  (interactive)
  (dotimes (_ (/ (window-height) 4)) ;; Adjust this number for speed
    (scroll-up 3)
    (sit-for 0.0002)))  ;; Adds a small delay (in seconds)

(defun smooth-scroll-up ()
  "Scroll up smoothly by half a page."
  (interactive)
  (dotimes (_ (/ (window-height) 4))
    (scroll-down 3)
    (sit-for 0.0002)))  ;; Adds a small delay (in seconds)

;; Bind them to the keys
(define-key evil-normal-state-map (kbd "C-d") 'smooth-scroll-down)
(define-key evil-normal-state-map (kbd "C-u") 'smooth-scroll-up)

(use-package projectile
  :init
  (projectile-mode)
  :custom
  (projectile-run-use-comint-mode t) ;; Interactive run dialog when running projects inside emacs (like giving input)
  (projectile-switch-project-action #'projectile-dired) ;; Open dired when switching to a project
  (projectile-project-search-path '("~/projects/" "~/work/" ("~/github" . 1)))) ;; . 1 means only search the first subdirectory level for projects
;; Use Bookmarks for smaller, not standard projects

(use-package eglot
	:ensure nil ;; `eglot` is built into Emacs 29, so no need to install
	:hook ((go-mode python-mode c-mode c++-mode sql-mode) . eglot-ensure) ;; Auto-start for these languages
	:custom
	(eglot-events-buffer-size 0)  ;; No event buffers
	(eglot-autoshutdown t)        ;; Shutdown unused servers
	(eglot-report-progress nil)   ;; Disable verbose LSP messages
	:config
	(add-to-list 'eglot-server-programs
				 '(go-mode . ("gopls"))) ;; Manually specify `gopls` for Go
	(add-to-list 'eglot-server-programs
				 '(python-mode . ("pyright-langserver" "--stdio"))) ;; Python
	(add-to-list 'eglot-server-programs
				 '(c-mode . ("clangd")))
	;;(add-to-list 'eglot-server-programs
	;;             '(c++-mode . ("clangd")))
	(add-to-list 'eglot-server-programs
				 '(sql-mode . ("sqls"))) ;; Adds SQL language server
)

(use-package yasnippet-snippets
  :hook (prog-mode . yas-minor-mode))

(add-to-list 'display-buffer-alist
             '("\\*.*\\*"  ;; Match all buffers with `*` in the name (adjust as needed)
               (display-buffer-reuse-window display-buffer-in-side-window)
               (side . bottom)    ;; Open at the bottom
               (window-height . 12)))  ;; Set height to 12 lines

(use-package lua-mode
  :mode "\\.lua\\'") ;; Only start in a lua file

;;(use-package python-mode
  ;;:mode "\\.py\\'")

(defun my-python-eval-region-or-line ()
      "Evaluate the selected region or the current line in Python, displaying results in a small window."
      (interactive)
      (let ((output-buffer (get-buffer-create "*Python Output*"))
            (code (if (use-region-p)
                      (buffer-substring-no-properties (region-beginning) (region-end))
                    (thing-at-point 'line t))))
        (with-current-buffer output-buffer
          (erase-buffer)) ;; Clear previous output
        (python-shell-send-string code) ;; Removed output-buffer argument
        (display-buffer output-buffer '(display-buffer-below-selected . ((window-height . 10))))))

(add-hook 'python-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local eglot-format-buffer-function
                        (lambda () (call-process "black" nil nil nil (buffer-file-name)))
                        )))

(require 'sql)
        (setq sql-interactive-mode-hook
              (lambda ()
                (setq sql-ask-about-save nil)
                (setq sql-interactive-mode-prompt-regexp "^[^>]*> ")
                (setq sql-interactive-mode-output-destination 'buffer)))

        ;; Ensure SQL buffers have proper indentation and appearance
        (add-hook 'sql-mode-hook
                  (lambda ()
                    (setq sql-indent-offset 2)  ;; Indentation level
                    (display-line-numbers-mode)))  ;; Line numbers
    
(defun my-sqlformat-buffer ()
  "Format the current buffer with pg_format."
  (interactive)
  (when (executable-find "pg_format")
    (let ((orig-point (point)))
      (shell-command-on-region (point-min) (point-max) "pg_format -"
                               (current-buffer) t)
      (goto-char orig-point))))

(add-hook 'sql-mode-hook
          (lambda ()
            (eglot-ensure)
            (add-hook 'before-save-hook #'my-sqlformat-buffer nil t)))

(use-package go-mode
  :mode "\\.go\\'"
  :hook ((before-save . gofmt-before-save))) ;; Auto-format before saving

(use-package org
  :ensure nil
  :custom
  (org-edit-src-content-indentation 4) ;; Set src block automatic indent to 4 instead of 2.

  :hook
  (org-mode . org-indent-mode) ;; Indent text
  ;; The following prevents <> from auto-pairing when electric-pair-mode is on.
  ;; Otherwise, org-tempo is broken when you try to <s TAB...
  ;;(org-mode . (lambda ()
  ;;              (setq-local electric-pair-inhibit-predicate
  ;;                          `(lambda (c)
  ;;                             (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
  )

(use-package toc-org
  :commands toc-org-enable
  :hook (org-mode . toc-org-mode))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode))

(use-package org-tempo
  :ensure nil
  :after org)

(use-package eat
  :hook ('eshell-load-hook #'eat-eshell-mode))

;; (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; (require 'start-multiFileExample)

;; (start/hello)

(use-package nerd-icons
  :if (display-graphic-p))

(use-package nerd-icons-dired
  :hook (dired-mode . (lambda () (nerd-icons-dired-mode t))))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package magit
  :commands magit-status)

(use-package diff-hl
  :hook ((dired-mode         . diff-hl-dired-mode-unless-remote)
         (magit-pre-refresh  . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :init (global-diff-hl-mode))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-prefix 2)          ;; Minimum length of prefix for auto completion.
  (corfu-popupinfo-mode t)       ;; Enable popup information
  (corfu-popupinfo-delay 0.5)    ;; Lower popupinfo delay to 0.5 seconds from 2 seconds
  (corfu-separator ?\s)          ;; Orderless field separator, Use M-SPC to enter separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  (completion-ignore-case t)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)
  (corfu-preview-current nil) ;; Don't insert completion without confirmation
  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

(use-package nerd-icons-corfu
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package cape
  :after corfu
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  ;; The functions that are added later will be the first in the list

  (add-to-list 'completion-at-point-functions #'cape-dabbrev) ;; Complete word from current buffers
  (add-to-list 'completion-at-point-functions #'cape-dict) ;; Dictionary completion
  (add-to-list 'completion-at-point-functions #'cape-file) ;; Path completion
  (add-to-list 'completion-at-point-functions #'cape-elisp-block) ;; Complete elisp in Org or Markdown mode
  (add-to-list 'completion-at-point-functions #'cape-keyword) ;; Keyword/Snipet completion

  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev) ;; Complete abbreviation
  ;;(add-to-list 'completion-at-point-functions #'cape-history) ;; Complete from Eshell, Comint or minibuffer history
  ;;(add-to-list 'completion-at-point-functions #'cape-line) ;; Complete entire line from current buffer
  ;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol) ;; Complete Elisp symbol
  ;;(add-to-list 'completion-at-point-functions #'cape-tex) ;; Complete Unicode char from TeX command, e.g. \hbar
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml) ;; Complete Unicode char from SGML entity, e.g., &alpha
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345) ;; Complete Unicode char using RFC 1345 mnemonics
  )

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :init
  (vertico-mode))

(savehist-mode) ;; Enables save history mode

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  :hook
  ('marginalia-mode-hook . 'nerd-icons-completion-marginalia-setup))

(use-package consult
  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))

  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  ;; (consult-customize
  ;; consult-theme :preview-key '(:debounce 0.2 any)
  ;; consult-ripgrep consult-git-grep consult-grep
  ;; consult-bookmark consult-recent-file consult-xref
  ;; consult--source-bookmark consult--source-file-register
  ;; consult--source-recent-file consult--source-project-recent-file
  ;; :preview-key "M-."
  ;; :preview-key '(:debounce 0.4 any))

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
   ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
   ;;;; 2. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
   ;;;; 3. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
   ;;;; 4. projectile.el (projectile-project-root)
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))
   ;;;; 5. No project support
  ;; (setq consult-project-function nil)
  )

(use-package diminish)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init
  (which-key-mode 1)
  :diminish
  :custom
  (which-key-side-window-location 'bottom)
  (which-key-sort-order #'which-key-key-order-alpha) ;; Same as default, except single characters are sorted alphabetically
  (which-key-sort-uppercase-first nil)
  (which-key-add-column-padding 1) ;; Number of spaces to add to the left of each column
  (which-key-min-display-lines 6)  ;; Increase the minimum lines to display, because the default is only 1
  (which-key-idle-delay 0.3)       ;; Set the time delay (in seconds) for the which-key popup to appear
  (which-key-max-description-length 25)
  (which-key-allow-imprecise-window-fit nil)) ;; Fixes which-key window slipping out in Emacs Daemon

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
;; Increase the amount of data which Emacs reads from the process
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq comp-deferred-compilation t)
(setq comp-async-jobs-number 8)
