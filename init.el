;;; package --- Sumary  -*- lexical-binding: t; -*-
;;; Commentary:
;;;   file for configuring the enviroment for Emacs
;;; Code:

;; Define emacs directory for this alternative configuration
;; Start emacs with
;; #+begin_src:
;;  emacs -Q --init-directory ~/.emacs.42.d/
;; #+end_src: 

(setq user-emacs-directory "~/.emacs.promo.d/")

;; Define the init file for automatic config as "custom.el"
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;(package-install 'exec-path-from-shell)
;;(exec-path-from-shell-initialize)

;; Define and initialize package repositories
(require 'package)
(setq package-archives '(("melpa"   . "https://melpa.org/packages/")
			 ("org"     . "https://orgmode.org/elpa/")
			 ("elpa"    . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(setq package-archive-priorities '(("org"   . 15)
				   ("elpa"  . 10)
				   ("melpa" . 5)
				   ("nongnu". 1)))
;;(package-initialize)
;;(package-refresh-contents)


(use-package ace-window
  :ensure t
  :bind
  (("M-o" . #'ace-select-window)
   ("C-M-O" . #'ace-swap-window)))

(defun c-hook-fun()
  (setq-local c-basic-offset 4)
  (setq-local tab-width 4)
  (setq-local indent-tabs-mode t)
  (setq-local c-backspace-function 'backward-delete-char)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0)
  (setq-local tab-stop-list
		        '(4 8 12 16 20 24 28 32
					36 40 44 48 52 56 60
	  				64 68 72 76 80 84 88 92 96
					100 104 108 112 116 120))
  (local-set-key (kbd "TAB") #'self-insert-command)
  (local-set-key (kbd "C-c e o") #'ff-get-other-file)
  (electric-indent-mode nil))


(defun html-hook-fun()
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 2)
  )

(defun js-hook-fun()
  (message "js-hook")
  (setq-local js-indent-level 2)
  (setq-local tab-width 2)
  (setq-local indent-tabs-mode nil)
  (electric-indent-mode t))

(use-package emacs
  :ensure t
  :config
  ;; shorten yes or no confirmations
  (defalias 'yes-or-no-p 'y-or-n-p)
  ;;highlights cursors current line
  (global-hl-line-mode t)
  ;; no toolbar
  (tool-bar-mode -1)
  ;; tab-bar
  (tab-bar-mode -1)
  ;; remove window decorations from frame on gui emacs
  (set-frame-parameter nil 'undecorated t)
  (scroll-bar-mode -1)
  ;; col-num on modeline
  (column-number-mode t)
  ;; lambda
  (global-prettify-symbols-mode t)
  (repeat-mode 1)
  ;; display time
  (setq-default display-time-24hr-format t)
  (display-time-mode 1)
  ;; mini-buffer completion
  (icomplete-mode t)
  (icomplete-vertical-mode t)
  ;; save minibuffer history
  (savehist-mode 1)
  ;; recent files buffer
  (recentf-mode 1)
  ;; file and buffer completion on minibuffer
  (ido-mode t)
  (setq-default ido-enable-flex-matching t)
  ;; right margin indication at col 80
  (global-display-fill-column-indicator-mode t)
  (setq-default fill-column 80)
  ;; relative lineB numbers
  (setq-default display-line-numbers-type 'relative)
  ;; display line number in prog-mode
  (add-hook 'prog-mode-hook #'display-line-numbers-mode)
  ;; display right margin col in prog-mode
  (add-hook 'prog-mode-hook  #'display-fill-column-indicator-mode)
  ;; display num of matches after isearch command on minibuffer
  (setq-default isearch-lazy-count t)
  ;; no confirmation on ibuffer killing  
  (setq-default ibuffer-expert t)
  ;; easy copy file side by side dired buffers 
  (setq-default dired-dwim-target t)
  ;; load tags update without asking
  (setq-default tags-revert-without-query 1)
  ;; set flags for man command to open all man sections
  ;; related to that word (navigate section with M-n M-p)
  (setq-default Man-switches "-a")
  ;; support for output with color on compilation mode
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)  
  (add-hook 'c-mode-hook #'c-hook-fun)
  (add-hook 'c++-mode-hook #'c-hook-fun)
  (add-hook 'html-mode-hook #'html-hook-fun)
  (add-hook 'js-mode-hook #'js-hook-fun)
  (let ((autosaves-dir (expand-file-name "auto-saves/" user-emacs-directory))
	(backups-dir (expand-file-name "backups/" user-emacs-directory)))
    
    (unless (file-exists-p autosaves-dir)
      (make-directory autosaves-dir nil))
    (unless (file-exists-p backups-dir)
      (make-directory autosaves-dir nil))

  (setq auto-save-file-name-transforms `((".*" ,autosaves-dir t)))
  (setq backup-directory-alist `((".*" . ,backups-dir))))

  (setq-default ediff-split-window-function #'split-window-horizontally)
  (setq-default ediff-window-setup-function #'ediff-setup-windows-plain)

  (require 'calendar)
  (calendar-set-date-style 'iso)
  (setq visible-bell t)
  
  :bind
  (("C-x C-b" . #'ibuffer)
   ("C-c p c" . #'compile)
   ("C-c p p" . #'recompile)
   ("C-c p f" . #'recentf-open-files)
   ("C-x !" . #'shell)
   ("C-x @" . #'ansi-term)
   ("C-x <up>" .#'windmove-up)
   ("C-x <down>" .#'windmove-down)
   ("C-x <left>" .#'windmove-left)
   ("C-x <right>" .#'windmove-right)))

(expand-file-name "custom.el" user-emacs-directory)


(setq sql-connection-alist
      '((local-postgres
         (sql-product 'postgres)
         (sql-server "localhost")
         (sql-user "postgres")  ; Replace with your PostgreSQL username
         ;(sql-password "")
         (sql-database "test_chatwoot")  ; Replace with your database name
         (sql-port 5432))))  ; Default PostgreSQL port

;; Optional: Set PostgreSQL program if not in PATH
(setq sql-postgres-program "/usr/local/bin/psql")  ; Adjust path as needed

;; (use-package bash-completion
;;   :ensure t
;;   :config
;;   (bash-completion-setup)
;;   )

(use-package deadgrep
  :ensure t
  :bind ("C-c p s" . #'deadgrep))

;; (use-package vterm
;;   :ensure t)


(use-package multiple-cursors
  :ensure t
  :bind
  (("C-c <right>" . #'mc/mark-next-like-this-word)
   ("M-<down>"  . #'mc/mark-next-lines)
   ("M-<up>"    . #'mc/mark-previous-lines)
   ("C-c >"       . #'mc/mark-all-symbols-like-this-in-defun)
   ("C-c M->"     . #'mc/mark-all-words-like-this)
   ("C-c SPC"     . #'mc/edit-lines)
   ))



(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  :custom
  (undo-tree-auto-save-history t)
  
  (undo-tree-history-directory-alist `((".*" . ,(expand-file-name "undo-tree-history-files/" user-emacs-directory))))
  (undo-tree-visualizer-diff nil)
  (undo-tree-visualizer-timestamps t))

'(((()))) ;; color parentheses by nested level
(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode  . rainbow-delimiters-mode)
	 (LaTeX-mode . rainbow-delimiters-mode)
	 (ess-mode   . rainbow-delimiters-mode)))


;; display completion candidates 
(use-package corfu
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preview-current t)         ;; preview candidate (t, nil, insert)
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-exclude-modes'.
  :init
  (global-corfu-mode))

;; keybiding help on mini-buffer
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
	which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))


;; git interface
(use-package magit
  :ensure t)

;; markdown support
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "markdown"))

;; project level support 
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p o") 'projectile-command-map))


(use-package yasnippet                  ; Snippets
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (yas-reload-all))


(use-package eglot
  :ensure t
  :config
  (push
   '(c-mode
     "clangd"
     "--all-scopes-completion"
     "--background-index"
     "--clang-tidy"
     "--completion-style=bundled"
     "--function-arg-placeholders"
     "--header-insertion=iwyu"
     "--query-driver=/usr/bin/gcc,/usr/bin/clang"
     "--enable-config"
     )
   eglot-server-programs)
  :bind (("C-c e e" . #'eglot)
	 ("C-c e q" . #'eglot-shutdown-all)
	 :map eglot-mode-map
	 ("C-c e a" . #'eglot-code-actions)
	 ("C-c e n" . #'flymake-goto-next-error)
	 ("C-c e Q" . #'eglot-shutdown)
	 ("C-c e w" . #'eglot-reconnect)
	 ("C-c e r" . #'eglot-rename)))


(use-package dot-env
  :ensure t)

;; ;; Theme
;; (use-package exotica-theme
;;   :ensure t
;;   :config (load-theme 'exotica t))

;; (use-package zenburn-theme
;;   :ensure t
;;   :config (load-theme 'zenburn t)
;;   (set-face-attribute 'region nil :background "#228" :foreground "#99ffff")
;;   (set-face-attribute 'hl-line nil :foreground nil :background "#333333"))

;; (use-package darktooth-theme
;;   :ensure t
;;   :config (load-theme 'darktooth t)
;;   (set-face-attribute 'region nil :background "#116" :foreground "#77ff33")
;;   (set-face-attribute 'hl-line nil :foreground nil :background "#333333"))
;;(load-theme 'afternoon)

(set-face-attribute 'hl-line nil :foreground nil :background "#001010")
(set-face-attribute 'highlight nil :foreground nil :background "#001010")
(set-face-attribute 'magit-section-highlight nil :foreground nil :background "#001010")
(set-face-attribute 'corfu-default nil :foreground nil :background "#000005")

;;(set-face-attribute 'hl-line nil :foreground nil :background "#DDDDDD")

;;(set-frame-font "Monospace 19" nil t)

;; (use-package modus-themes
;;   :ensure t
;;   :demand t
;;   :init
;;   ;; Starting with version 5.0.0 of the `modus-themes', other packages
;;   ;; can be built on top to provide their own "Modus" derivatives.
;;   ;; For example, this is what I do with my `ef-themes' and
;;   ;; `standard-themes' (starting with versions 2.0.0 and 3.0.0,
;;   ;; respectively).
;;   ;;
;;   ;; The `modus-themes-include-derivatives-mode' makes all Modus
;;   ;; commands that act on a theme consider all such derivatives, if
;;   ;; their respective packages are available and have been loaded.
;;   ;;
;;   ;; Note that those packages can even completely take over from the
;;   ;; Modus themes such that, for example, `modus-themes-rotate' only
;;   ;; goes through the Ef themes (to this end, the Ef themes provide
;;   ;; the `ef-themes-take-over-modus-themes-mode' and the Standard
;;   ;; themes have the `standard-themes-take-over-modus-themes-mode'
;;   ;; equivalent).
;;   ;;
;;   ;; If you only care about the Modus themes, then (i) you do not need
;;   ;; to enable the `modus-themes-include-derivatives-mode' and (ii) do
;;   ;; not install and activate those other theme packages.
;;   (modus-themes-include-derivatives-mode 1)
;;   :bind
;;   (("<f5>" . modus-themes-rotate)
;;    ("C-<f5>" . modus-themes-select)
;;    ("M-<f5>" . modus-themes-load-random))
;;   :config
;;   ;; Your customizations here:
;;   (setq modus-themes-to-toggle '(modus-operandi modus-vivendi)
;;         modus-themes-to-rotate modus-themes-items
;;         modus-themes-mixed-fonts t
;;         modus-themes-variable-pitch-ui t
;;         modus-themes-italic-constructs t
;;         modus-themes-bold-constructs t
;;         modus-themes-completions '((t . (bold)))
;;         modus-themes-prompts '(bold)
;;         modus-themes-headings
;;         '((agenda-structure . (variable-pitch light 2.2))
;;           (agenda-date . (variable-pitch regular 1.3))
;;           (t . (regular 1.15))))

;;   (setq modus-themes-common-palette-overrides nil)

;;   ;; Finally, load your theme of choice (or a random one with
;;   ;; `modus-themes-load-random', `modus-themes-load-random-dark',
;;   ;; `modus-themes-load-random-light').
;;   (modus-themes-load-theme 'modus-vivendi-deuteranopia))


;; ;;Theme


(use-package gptel
  :ensure t
  :config
  (require 'gptel-integrations)
  (require 'gptel-org)
  (require 'dot-env)
  
  (let* ((dot-env-environment (dot-env-config "~/.env"))
	 (ollama-api-key (car
			  (alist-get
			   'OLLAMA_API_KEY
			   dot-env-environment))))
    (setq-default
     gptel-model 'deepseek-v3.1:671b-cloud
     gptel-backend
     (gptel-make-ollama "Ollama" ;Any name of your choosing
       :host "localhost:11434"   ;Where it's running
       :stream t   ;Stream responses
       :models (split-string
		(shell-command-to-string
		 "ollama list | cut -d ' ' -f 1")
		"\n" t) ;List of models
       :key ollama-api-key ; api key for cloud models
       )))
  :custom
					;(gptel-default-mode 'org-mode)
  
  (gptel-use-curl t)
  (gptel-use-tools t)
  (gptel-confirm-tool-calls 'always)
  (gptel-include-tool-results 'auto)
  )

(use-package mcp
  :ensure t
  :after gptel
  :custom
  (mcp-hub-servers
   `(
     ;; ("github" . (:command "docker"
     ;;              :args ("run" "-i" "--rm"
     ;;                     "-e" "GITHUB_PERSONAL_ACCESS_TOKEN"
     ;;                     "ghcr.io/github/github-mcp-server")
     ;;              :env (:GITHUB_PERSONAL_ACCESS_TOKEN ,(get-sops-secret-value "gh_pat_mcp"))))
     
     ("duckduckgo" . (:command "uvx" :args ("duckduckgo-mcp-server")))
     ;; ("nixos" . (:command "uvx" :args ("mcp-nixos")))
     
     ("fetch" . (:command "uvx" :args ("mcp-server-fetch")))
     
     ("filesystem" .
      (:command "npx"
		:args ("-y" "@modelcontextprotocol/server-filesystem"
		       ,(expand-file-name (getenv "HOME") "playground"))))
     
     
     ;; ("sequential-thinking" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-sequential-thinking")))
     
     ;; ("context7" . (:command "npx" :args ("-y" "@upstash/context7-mcp") :env (:DEFAULT_MINIMUM_TOKENS "6000")))
     ;;("greet_mcp" . (:url "http://localhost:8081/mcp"))
     ))
  :config (require 'mcp-hub)
  :hook (after-init . mcp-hub-start-all-server))








(put 'upcase-region 'disabled nil)

;; (provide 'init)
;; ;;; init.el ends here

