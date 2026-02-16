;;; package --- Sumary
;;; Commentary:
;;;   file for configuring the enviroment for Emacs
;;; Code:

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

;;(global-unset-key (kbd "<up>"))
;;(global-unset-key (kbd "<down>"))




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
  (setq-local tab-stop-list
		        '(4 8 12 16 20 24 28 32
					36 40 44 48 52 56 60
	  				64 68 72 76 80 84 88 92 96
					100 104 108 112 116 120))
  (local-set-key (kbd "TAB") #'self-insert-command)
  (local-set-key (kbd "C-c e o") #'ff-get-other-file)
  (electric-indent-mode nil))

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
   
  (setq auto-save-file-name-transforms
	`((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t)))
  (setq backup-directory-alist
	`((".*" . ,(expand-file-name "backups/" user-emacs-directory))))

  (setq-default ediff-split-window-function #'split-window-horizontally)
  (setq-default ediff-window-setup-function #'ediff-setup-windows-plain)
  
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

(load "~/.emacs.d/42/list.el")
(load "~/.emacs.d/42/string.el")
(load "~/.emacs.d/42/comments.el")
(load "~/.emacs.d/42/header.el")


(use-package deadgrep
  :ensure t
  :bind ("C-c p s" . #'deadgrep))

(use-package vterm
  :ensure t)


(use-package multiple-cursors
  :ensure t

  :bind
  (("C-c >" . #'mc/mark-next-like-this-word)
   ("C-c C->" . #'mc/mark-all-symbols-like-this-in-defun)
   ("C-c M->" . #'mc/mark-all-words-like-this)
   ("C-c SPC" . #'mc/edit-lines)
   ))


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
(load-theme 'afternoon)

;;(set-face-attribute 'hl-line nil :foreground nil :background "#222222")
;;(set-face-attribute 'hl-line nil :foreground nil :background "#DDDDDD")

(set-frame-font "Monospace 19" nil t)
;; ;;Theme

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  :custom
  (undo-tree-auto-save-history t)
  
  (undo-tree-history-directory-alist `((".*" . ,(expand-file-name "undo-tree-history-files/" user-emacs-directory))))
  (undo-tree-visualizer-diff t)
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

;; adapt corfu to terminal mode
(use-package corfu-terminal
  :ensure t
  :config
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)))


;; keybiding help on mini-buffer
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
	which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))


;; Beacon - find your cursor faster
(use-package beacon
  :config
  (beacon-mode 1)
  :custom
  (beacon-blink-duration 1)
  (beacon-blink-delay 0.2)
  (beacon-size 80)
  (beacon-blink-when-point-moves-vertically 2)
  (beacon-blink-when-point-moves-horizontally 2))

;; git interface
(use-package magit
  :ensure t)

;; ;; markdown support
;; (use-package markdown-mode
;;   :ensure t
;;   :mode ("README\\.md\\'" . gfm-mode)
;;   :init (setq markdown-command "multimarkdown"))

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
     "--query-driver=/usr/bin/gcc,/usr/local/opt/llvm/bin/clang"
     "--enable-config"
     )
   eglot-server-programs)
  (setcdr (assoc '(java-mode java-ts-mode) eglot-server-programs)
	  ("/Users/redjocker/.emacs.d/share/eclipse.jdt.ls/bin/jdtls" 
           "-configuration"
	   "/Users/redjocker/.emacs.d/share/eclipse.jdt.ls/config_mac_arm"))
  (push
   '((mhtml-mode :language-id "html") 
     "vscode-html-language-server"
     "--stdio")
   eglot-server-programs)
  :bind (("C-c e e" . #'eglot)
	 ("C-c e q" . #'eglot-shutdown-all)
	 :map eglot-mode-map
	 ("C-c e a" . #'eglot-code-actions)
	 ("C-c e n" . #'flymake-goto-next-error)
	 ("C-c e Q" . #'eglot-shutdown)
	 ("C-c e w" . #'eglot-reconnect)
	 ("C-c e r" . #'eglot-rename)))

(use-package realgud
  :ensure t
  )

(use-package realgud-lldb
  :ensure t
  )

;; ;; Gradle (Java and Kotlin)
;; (use-package flycheck-gradle
;;   :ensure t
;;   :commands (flycheck-gradle-setup)
;;   :init
;;   (mapc
;;    (lambda (x)
;;      (add-hook x #'flycheck-gradle-setup))
;;    '(java-mode-hook kotlin-mode-hook)))

;; (use-package gradle-mode
;;   :ensure t)

(use-package eglot-java
  :ensure t)

(defun my-java-indent-setup ()
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-cont-nonempty '+)
  (c-set-offset 'arglist-close 0))

(add-hook 'java-mode-hook 'my-java-indent-setup)
;; ;; Gradle (Java and Kotlin)


(defun search-duck-duck ()
  "Search DuckDuckGo for a query or the word at point."
  (interactive)
  (let* ((default (thing-at-point 'sexp))
         (prompt (if default
                     (format "Search DuckDuckGo (default %s): " default)
                   "Search DuckDuckGo: "))
         (query (read-string prompt nil nil default)))
    (browse-url (format "https://duckduckgo.com/?q=%s" (url-hexify-string query)))))


(defun browse-man7-page ()
  "Search man7.org for a query or the word at point."
  (interactive)
  (let* ((default (thing-at-point 'sexp))
         (prompt (if default
                     (format "Search man7.org (default %s): " default)
                   "Search ma7.org: "))
         (query (read-string prompt nil nil default)))
    (browse-url
     (format
      "https://duckduckgo.com/?q=\\man7.org %s"
      (url-hexify-string query)))))


(defun pbcopy ()
  (interactive)
  (let ((deactivate-mark t))
    (call-process-region (point) (mark) "pbcopy")))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))


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
     gptel-backend
     (gptel-make-ollama "Ollama" ;Any name of your choosing
       :host "localhost:8080"   ;Where it's running
       :stream t   ;Stream responses
       :models '(deepseek-v3.1:671b-cloud
		 nemotron-3-nano:30b-cloud
		 gpt-oss:120b-cloud
		 granite4:latest
		 qwen3:4b
		 qwen3-vl:235b-cloud) ;List of models
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
     ("greet_mcp" . (:url "http://localhost:8081/mcp"))
     ))
  :config (require 'mcp-hub)
  :hook (after-init . mcp-hub-start-all-server))
;; ;; Swift
;; (defun load-swift() 
;;   (interactive)
;;   (use-package swift-mode
;;     :ensure t
;;     :config
;;     (push '(swift-mode "sourcekit-lsp") eglot-server-programs)))
;; ;; Swift

;; ;; Ruby
;; (use-package inf-ruby
;;   :ensure t
;;   )
;; ;;Ruby

;; ;; Elixir
;; (use-package
;;   elixir-ts-mode
;;   :ensure t
;;   :hook (elixir-ts-mode . eglot-ensure)
;;   (elixir-ts-mode
;;    .
;;    (lambda ()
;;      (push '(">=" . ?\u2265) prettify-symbols-alist)
;;      (push '("<=" . ?\u2264) prettify-symbols-alist)
;;      (push '("!=" . ?\u2260) prettify-symbols-alist)
;;      (push '("==" . ?\u2A75) prettify-symbols-alist)
;;      (push '("=~" . ?\u2245) prettify-symbols-alist)
;;      (push '("<-" . ?\u2190) prettify-symbols-alist)
;;      (push '("->" . ?\u2192) prettify-symbols-alist)
;;      (push '("<-" . ?\u2190) prettify-symbols-alist)
;;      p   (push '("|>" . ?\u25B7) prettify-symbols-alist))))

;; Should use:
;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
;; ;; at least once per installation or while changing this list
;; (setq-default treesit-language-source-alist
;;  '((heex "https://github.com/phoenixframework/tree-sitter-heex")
;;    (elixir "https://github.com/elixir-lang/tree-sitter-elixir")))

;; (setq-default major-mode-remap-alist
;; 	      '((elixir-mode . elixir-ts-mode)))

;; (add-to-list
;;  'eglot-server-programs
;;  '(elixir-ts-mode
;;    "/Users/redjocker/playground/elixir/elixirLsp/elixir-ls-v0.17.10/language_server.sh"))

;; ;; Elixir

;; Lua
(use-package
  lua-mode
  :ensure t)

;; Nim
(use-package nim-mode
  :ensure t
  :config (add-to-list 'eglot-server-programs
		       '(nim-mode "nimlsp"))
  :hook (nim-mode . (lambda() (auto-fill-mode 0)
		      (electric-indent-local-mode 0))))

;; ;; R
;; (use-package ess
;;   :ensure t
;;   :config)

;; ;; Common Lisp
;; (use-package slime
;;   :ensure t
;;   :config
;;   (load (expand-file-name "~/quicklisp/slime-helper.el"))
;;   (setq-default inferior-lisp-program "sbcl"))

;; ;; SML (polly)
;; (use-package sml-mode
;;   :ensure t)

;; ;; F#
;; (use-package fsharp-mode
;;   :defer t
;;   :ensure t)

;; (use-package eglot-fsharp
;;   :defer t
;;   :ensure t
;;   :config
;;   (defun format-after-save ()
;;     (add-hook 'before-save-hook #'eglot-format-buffer nil 'local))
;;   :hook
;;   (fsharp-mode . format-after-save))


;; ;; Go
;; (use-package go-mode
;;   :ensure t)

;; ;; Elm
;; (use-package elm-mode
;;   :ensure t
;;   :custom
;;   (elm-tags-on-save t))

;; ;; Zig
;; (use-package zig-mode
;;   :ensure t)

;; ;; SCHEME
;; (use-package geiser
;;   :ensure t)

;; (use-package geiser-guile
;;   :ensure t)
;; ;; (setq geiser-mit-binary "/usr/local/bin/scheme")
;; ;; (setq geiser-chez-binary "/usr/local/Cellar/chezscheme/9.5.4/bin/chez")
;; ;; (setq geiser-guile-binary "/usr/local/bin/guile")
;; ;; (setq geiser-racket-binary "/usr/local/bin/racket")
;; ;; (setq geiser-mode-smart-tab-p t)
;; ;; (setq racket-program "/usr/local/bin/racket")



;; ;; Julia
;; (use-package julia-mode)

;; (use-package eat
;;   :pin nongnu
;;   :custom
;;   (eat-kill-buffer-on-exit t)
;;   :config
;;   (delete [?\C-u] eat-semi-char-non-bound-keys) ; make C-u work in Eat terminals like in normal terminals
;;   (delete [?\C-g] eat-semi-char-non-bound-keys) ; ditto for C-g
;;   (eat-update-semi-char-mode-map)
;;   ;; XXX: Awkward workaround for the need to call eat-reload after changing Eat's keymaps,
;;   ;; but reloading from :config section causes infinite recursion because :config wraps with-eval-after-load.
;;   (defvar eat--prevent-use-package-config-recursion nil)
;;   (unless eat--prevent-use-package-config-recursion
;;     (setq eat--prevent-use-package-config-recursion t)
;;     (eat-reload))
;;   (makunbound 'eat--prevent-use-package-config-recursion)
;;   )

;; (use-package julia-snail
;;   :ensure t
;;   :custom (julia-snail-terminal-type :eat)
;;   :config (setq-default julia-snail-executable "/opt/homebrew/bin/julia") 
;;   :hook (julia-mode . julia-snail-mode))


(defun cppman (entry)
  "View C++ reference entry using cppman in Emacs, similar to man command.
If called interactively with no argument, uses the symbol at point as default."
  (interactive
   (list (let* ((default (thing-at-point 'symbol t))
                (prompt (if default
                            (format "C++ Reference entry (default %s): " default)
                          "C++ Reference entry: ")))
           (read-string prompt nil nil default))))
  (let ((buffer (get-buffer-create (format "*cppman %s*" entry))))
    (with-current-buffer buffer
      (setq buffer-read-only nil)
      (erase-buffer)
      (call-process-shell-command
       (format "cppman %s | col -b" entry)
       nil (current-buffer))
      (if (zerop (buffer-size))
          (message "No results found for %s" entry)
        (special-mode))
      (setq buffer-read-only t)
      (beginning-of-buffer))
    (unless (zerop (buffer-size))
      (switch-to-buffer buffer))))


;; old config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; (desktop-save-mode 1)


;; (use-package direx
;;   :bind ("C-x C-j" . 'direx:jump-to-directory))


;; (use-package swiper
;;   :ensure t
;;   ;; C-s        swiper-C-s
;;   ;; M-q        swiper-query-replace
;;   ;; C-l        swiper-recenter-top-bottom
;;   ;; C-'        swiper-avy
;;   ;; C-7        swiper-mc
;;   ;; C-c C-f    swiper-toggle-face-matching
;;   )


;; (use-package counsel
;;   :ensure t
;;   :bind (("M-x" . counsel-M-x)
;; 	 ("C-x C-b" . counsel-ibuffer)
;; 	 ;("C-x C-f" . counsel-find-file)
;; 	 :map minibuffer-local-map
;; 	 ("C-r" . 'counsel-minibuffer-history)))



;; (use-package ivy
;;   :ensure t
;;   :bind (("C-s" . swiper)
;; 	 :map ivy-minibuffer-map
;; 	 ("TAB" . ivy-alt-done)
;; 	 ("C-l" . ivy-alt-done)
;; 	 ("C-j" . ivy-next-line)
;; 	 ("C-k" . ivy-previous-line)
;; 	 :map ivy-switch-buffer-map
;; 	 ("C-k" . ivy-previous-line)
;; 	 ("C-l" . ivy-done)
;; 	 ("C-d" . ivy-switch-buffer-kill)
;; 	 :map ivy-reverse-i-search-map
;; 	 ("C-k" . ivy-previous-line)
;; 	 ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 0))

;; (use-package ivy-rich
;;   :init
;;   (ivy-rich-mode 1))


;; ; remember minibuffer prompt history
;; (setq history-length 25)
;; (savehist-mode 1)


;; (use-package smex
;;   :ensure t
;;   :init (smex-initialize))

;; (use-package ido-vertical-mode
;;   :ensure t
;;   :init (ido-vertical-mode 1)
;;   (setq ido-vertical-define-keys 'C-n-and-C-p-only))

;; ;;show possible completes at minibuffer
;; (setq ido-everywhere t)
;; (ido-mode 1)

;; ;;package adjust-parens
;; (use-package adjust-parens
;;   :ensure t
;;   :hook ((emacs-lisp-mode . adjust-parens-mode)
;; 	 (clojure-mode . adjust-parens-mode)))

;; (setq-default indent-tabs-mode nil)
;; ;(local-set-key (kbd "TAB") 'lisp-indent-adjust-parens)
;; ;(local-set-key (kbd "<backtab>") 'lisp-dedent-adjust-parens)
;; ;;

;; ;;go to char
;; (use-package avy
;;   :ensure t
;;   :bind
;;   ("M-s" . avy-goto-char))

;; (use-package popwin)
;; (use-package pos-tip)
;; (use-package yascroll
;;   :config (global-yascroll-bar-mode 1))

;; ;; Company - general auto completion
;; (use-package company
;;   :ensure t
;;   :bind (("C-c ." . company-complete)
;; 	 ("C-;" . company-complete)
;;          :map company-active-map
;; 	 ("C-n" . company-select-next)
;; 	 ("C-p" . company-select-previous)
;; 	 ("C-d" . company-show-doc-buffer)
;; 	 ("C-l" . company-show-location)
;; 	 ("<tab>" . company-complete)
;;          :map company-search-map
;; 	 ("<tab>" . company-complete))
;;   :hook ((after-init . global-company-mode))
;;   :custom
;;   (company-selection-wrap-around t)
;;   (company-idle-delay 0.01)
;;   (company-minimum-prefix-length 1)
;;   ;; show completion numbers for hotkeys
;;   (company-show-numbers t)
;;   ;; align annotations to the right
;;   (company-tooltip-align-annotations t)
;;   (company-search-regexp-function #'company-search-flex-regexp))



;; (use-package company-quickhelp
;;     :ensure t
;;     :hook ((company-mode . company-quickhelp-mode))
;;     :custom (company-quickhelp-delay 0.5))

;; ;; Set up statistics for company completions
;; (use-package company-statistics
;;     :ensure t
;;     :init (add-hook 'after-init-hook #'company-statistics-mode))

;; ;; sintax checker
;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))



;; ;; remember recently edited files
;; (recentf-mode 1)

;; ; remember and restore last cursor location at file
;; (save-place-mode 1)

;; ;; case insensitive completion
;; (setq read-buffer-completion-ignore-case t)


;; (defun recreate-dashboard()
;;   "Closed your dashboard? Want to open it? This is the right place."
;;   (interactive)
;;   (get-buffer-create "*dashboard*")
;;   (switch-to-buffer "*dashboard*"))

;; ;; wellcome page
;; (use-package dashboard
;;   :ensure t
;;   :config
;;   (progn
;;     (defun dashboard-keybindings-widget (list-size)
;;       (let ((keylist '("\tC-a | Move to beginning of line.\n"
;; 		       "\tM-m | Move to first non-whitespace character on the line.\n"
;; 		       "\tC-e | Move to end of line.\n"
;; 		       "\tC-f | Move forward one character.\n"
;; 		       "\tC-b | Move backward one character.\n"
;; 		       "\tM-f | Move forward one word (I use this a lot).\n"
;; 		       "\tM-b | Move backward one word (I use this a lot, too).\n"
;; 		       "\tM-a | Move backward-sentence\n"
;; 		       "\tM-e | Move forward-sentence\n"
;; 		       "\tC-s | Regex search for text in current buffer and move to it. Press C-s again to move to next match.\n"
;; 		       "\tC-r | Same as C-s, but search in reverse.\n"
;; 		       "\tM-< | Move to beginning of buffer.\n"
;; 		       "\tM-> | Move to end of buffer.\n"
;; 		       "\tC-M-n | forward-list\n"
;; 		       "\tC-M-f | forward-sexp"
;; 		       "\tC-M-p | backward-list"
;; 		       "\tC-M-b | backward-sexp"
;; 		       "\tM-g g | Go to line.\n")))
;; 	(mapc 'insert (seq-subseq keylist 0 (min (length keylist) list-size)))))
;;     (add-to-list 'dashboard-item-generators '(keybindings . dashboard-keybindings-widget))
;;     (dashboard-setup-startup-hook)
;;     (setq dashboard-items '((recents . 10) (keybindings . 20))))
;;   :bind ("C-x @ d" . 'recreate-dashboard))


;; ;; tree file 
;; (use-package neotree
;;   :ensure t
;;   :bind (("C-x \\" . 'neotree-toggle)))

;; (use-package w3m
;;   :ensure t)

 


;; ;; edit multiple occurrences of an identifier

;; (use-package iedit
;;   :ensure t
;;   :bind (("<f6>" . iedit-mode))
;;   :config
;;   (add-hook 'haskell-mode 'iedit-mode)
;;   ;;(add-hook 'emacs-lisp-mode-hook 'iedit-mode)
;;   (add-hook 'clojure-mode-hook 'iedit-mode))

;; ;; window resize
;; (global-set-key (kbd "<f7>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "<f8>") 'shrink-window-horizontally)
;; (global-set-key (kbd "<f9>") 'enlarge-window)
;; (global-set-key (kbd "<f12>") 'shrink-window)

;; ;; switch tab
;; (global-set-key (kbd "C-x t s") 'tab-switcher)


;; (use-package helm-lsp)
;; (use-package helm
;;   :config (helm-mode))


;; (use-package json-mode)

;; (add-hook 'json-mode-hook
;;           (lambda ()
;;             (make-local-variable 'js-indent-level)
;;             (set-default js-indent-level 2)))


;; (use-package lsp-java  
;;   :ensure t
;;   :config (add-hook 'java-mode-hook 'lsp)
;;   :bind (:map java-mode-map
;;               ("C-c a" . lsp-execute-code-action)
;;               ("C-c C-h" . lsp-describe-thing-at-point)
;;               ("C-c C-a i" . lsp-java-add-import)
;;               ("C-c n" . flycheck-next-error)
;;               ("C-c p" . flycheck-previous-error)
;;               ("C-c C-a l" . lsp-java-assign-statement-to-local)
;;               ("C-c C-a f" . lsp-java-assign-statement-to-field)
;;               ("C-c C-a p" . lsp-java-create-parameter)
;;               ("C-c C-a o" . lsp-java-organize-imports)
;;               ("C-c C-a v" . lsp-java-generate-overrides)
;;               ("C-c C-a m" . lsp-java-extract-method)
;;               ("C-c C-a e" . lsp-java-generate-equals-and-hash-code)))

;; ;; (use-package dap-mode
;; ;;   :ensure t
;; ;;   :after lsp-mode
;; ;;   :config (dap-auto-configure-mode))

;; ;; Kotlin

;; ;; (use-package kotlin-mode
;; ;;   :ensure t
;; ;;   :mode ("\\.kt" . kotlin-mode)
;; ;;   hook ((kotlin-mode . flycheck-mode)
;; ;; 	(kotlin-mode . lsp-mode)))

;; ;; (use-package kotlin-ts-mode

;; ;;   :mode "\\.kt\\'" ; if you want this mode to be auto-enabled
;; ;;   )

;; ;; (use-package flycheck-kotlin
;; ;;   :ensure t
;; ;;   :config (flycheck-kotlin-setup))




;; ;; Prolog
;; (use-package flymake-swi-prolog
;;   :ensure t
;;   :config (add-hook 'prolog-mode-hook #'flymake-swi-prolog-setup-backend))

;; (add-to-list 'auto-mode-alist '("\\.\\(pl\\|pro\\|lgt\\)" . prolog-mode))


;; ;; Cpp

;; (setq flycheck-clang-args "-std=c++11")

;; (print "Scheme loaded")

;; ;;OCaml

;; ;; Major mode for OCaml programming
;; (use-package tuareg
;;   :ensure t
;;   :mode (("\\.ocamlinit\\'" . tuareg-mode))
;;   :custom (utop-command "opam config exec -- dune utop . -- -emacs"))
;; ;;(setq utop-command "opam config exec -- dune utop . -- -emacs")


;; ;; Major mode for editing Dune project files
;; (use-package dune
;;   :ensure t)

;; ;; Merlin provides advanced IDE features
;; (use-package merlin
;;   :ensure t
;;   :config
;;   ;;(push "/Users/redjocker/.opam/default/share/emacs/site-lisp" load-path)
;;   (load-file "/Users/redjocker/.opam/default/share/emacs/site-lisp/merlin-company.el")
;;   (load-file "/Users/redjocker/.opam/default/share/emacs/site-lisp/merlin-iedit.el")
;;   (load-file "/Users/redjocker/.opam/default/share/emacs/site-lisp/merlin-imenu.el")
;;   (require 'merlin-iedit)
;;   (require 'merlin-company)
;;   (require 'merlin-imenu)
;;   (add-hook 'tuareg-mode-hook #'merlin-mode)
;;   (add-hook 'merlin-mode-hook #'company-mode)
;;   (with-eval-after-load 'company
;;   (add-to-list 'company-backends 'merlin-company-backend))
;;   ;; we're using flycheck instead
;;   (setq merlin-error-after-save nil)
;;   (setq merlin-use-auto-complete-mode t))



;; (use-package merlin-eldoc
;;   :ensure t
;;   :hook ((tuareg-mode) . merlin-eldoc-setup))

;; ;; This uses Merlin internally
;; (use-package flycheck-ocaml
;;   :ensure t
;;   :config
;;   (flycheck-ocaml-setup))

;; ;; utop configuration
;; (use-package utop
;;   :ensure t
;;   :config
;;   (add-hook 'tuareg-mode-hook #'utop-minor-mode))

;; ;;

;; (print "OCaml loaded")

;; ;; Haskell
;; (use-package flycheck-haskell
;;   :ensure t
;;   ;:hook (haskell-mode . flycheck-haskell-setup)
;;   )

;; (use-package lsp-haskell
;;   :config
;;   (setq-default
;;    lsp-haskell-formatting-provider "brittany"
;;    lsp-haskell-server-path "/Users/redjocker/.ghcup/bin/haskell-language-server-wrapper"
;; 	;lsp-haskell-server-args nil
;;    )
;;   (setq-local before-save-hook `(lsp-format-buffer ,@before-save-hook)))

;; (use-package lsp-mode
;;   :hook (((haskell-mode haskell-literate-mode) . lsp-deferred)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :config (setq
;;            lsp-keymap-prefix "s-l"
;; 	   lsp-headerline-breadcrumb-enable t
;; 	   lsp-lens-enable nil
;; 	   lsp-eldoc-enable-hover t
;; 	   lsp-modeline-diagnostics-enable t
;; 	   lsp-signature-render-documentation t
;; 	   lsp-signature-doc-lines nil
;; 	   lsp-signature-auto-activate nil
;;            ;lsp-completion-show-detail t
;; 	   ;lsp-completion-show-kind t
;; 	   ))

;; ;; (use-package treemacs
;; ;;   :ensure t
;; ;;   :init (setq-default treemacs-no-png-images t))

;; ;; (use-package lsp-treemacs
;; ;;   :ensure t)

;; (setq message-truncate-lines nil)

;; ;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
;; (use-package lsp-ui
;;   :hook (((haskell-mode haskell-literate-mode) . lsp-ui-doc-mode))
;;   :config
;;   (setq lsp-ui-doc-header t
;; 	lsp-ui-doc-enable t
;; 	lsp-ui-doc-include-signature t
;; 	lsp-ui-doc-position 'bottom
;; 	lsp-ui-doc-alignment 'window
;; 	lsp-ui-imenu-enable t
;; 	lsp-ui-imenu-buffer-position 'left
;; 	lsp-eldoc-enable-hover t
;;         lsp-log-io nil
;; 	lsp-ui-sideline-show-hover nil
;; 	lsp-ui-sideline-show-diagnostics t
;; 	lsp-ui-sideline-show-symbol nil
;; 	lsp-ui-sideline-show-code-actions t
;; 	lsp-ui-sideline-diagnostic-max-lines 15
;; 	lsp-ui-sideline-update-mode 'line
;; 	lsp-ui-flycheck-list-position 'bottom))

;; (use-package haskell-interactive-mode
;;   :ensure nil
;;   :config (haskell-indentation-mode)
;;   :bind
;;   (:map haskell-interactive-mode-map
;;         ("<f5>"    . haskell-interactive-switch-back)
;;         ("C-c C-z" . haskell-interactive-switch-back)
;;         ("C-c C-h" . bhr/haskell-search-hoogle)))

;; (use-package haskell-literate-mode
;;   :mode ("\\.lhs$" . haskell-literate-mode)
;;   :ensure nil
;;   :hook (haskell-literate-mode . turn-on-haskell-doc-mode))


;; (setq haskell-process-path-cabal "~/.ghcup/bin/cabal"
;;       haskell-process-path-ghci "~/.ghcup/bin/ghci"
;;       haskell-process-path-stack "~/.ghcup/bin/stack")

;; (use-package haskell-mode
;;   :mode ("\\.hs$" . haskell-mode)
;;   :hook ((haskell-mode . haskell-indentation-mode)
;;          (haskell-mode . display-line-numbers-mode)
;;          (haskell-mode . turn-on-haskell-doc-mode))
;;   :config
;;   (setq haskell-align-imports-pad-after-name t
;;         haskell-font-lock-symbols t
;; 	haskell-doc-show-global-types nil
;; 	haskell-doc-use-inf-haskell nil
;; 	haskell-process-type 'stack-ghci
;; 	haskell-process-suggest-remove-import-lines t
;; 	haskell-process-auto-import-loaded-modules t
;; 	haskell-process-use-presentation-mode t
;; 	haskell-process-suggest-haskell-docs-imports t
;; 	haskell-process-suggest-hoogle-imports t
;; 	haskell-process-suggest-remove-import-lines t
;; 	haskell-tags-on-save nil)

;;   :bind
;;   (:map haskell-mode-map
;;         ("<f5>"         . 'haskell-interactive-switch)
;;         ("C-c C-z"      . 'haskell-interactive-switch)
;;         ("C-c C-d d"    . 'haskell-get-doc-string)
;; 	("C-c C-d C-d"  . 'lsp-describe-thing-at-point)
;;         ("C-c C-l"      . 'haskell-process-load-file)
;;         ("C-c C-h"      . 'bhr/haskell-search-hoogle)
;;         ("C-c C-n C-t"  . 'haskell-process-do-type)
;;         ("C-c C-n C-i"  . 'haskell-process-do-info)
;;         ("C-c C-n C-c"  . 'haskell-process-cabal-build)
;;         ("C-c C-n c"    . 'haskell-process-cabal)
;; 	("C-c a"       .  'lsp-ui-sideline-apply-code-actions)))

;; (defun bhr/haskell-search-hoogle(start end)
;; "Search hoogle for the highlighted region or word under the cursor.
;;  START is start of region and END end of region."
;;   (interactive "r")
;;   (let ((criteria (if (use-region-p)
;;                       (buffer-substring-no-properties start end)
;; 		    (thing-at-point 'word))))
;;     (message "Hoogle: %s" criteria)
;;     (browse-url (concat "https://hoogle.haskell.org/?hoogle=" criteria))))

;; (eval-after-load 'haskell-cabal
;;   '(progn
;;      (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;      (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;;      (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;;      (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;; (print "Haskell loaded")
;; ;; Haskell



;; ;; Erlang



;; ;(use-package ivy-erlang-complete
;; ;  :ensure t)

;; ;(use-package erlang
;; ;  :init (setq erlang-root-dir "/user/local/opt/erlang/")
;; ;  :config (ivy-erlang-complete-init)
;; ;  :load-path ("/usr/local/opt/erlang/lib/erlang/lib/tools-3.5.3/emacs")
;; ;  :hook (after-save . ivy-erlang-complete-reparse)
;; ;  :custom (ivy-erlang-complete-erlang-root "/user/local/opt/erlang/lib/erlang/")
;; ;  :mode (("\\.erl?$" . erlang-mode)
;; ;	 ("rebar\\.config$" . erlang-mode)
;; ;	 ("relx\\.config$" . erlang-mode)
;; ;	 ("sys\\.config\\.src$" . erlang-mode)
;; ;	 ("sys\\.config$" . erlang-mode)
;; ;	 ("\\.config\\.src?$" . erlang-mode)
;; ;	 ("\\.config\\.script?$" . erlang-mode)
;; ;	 ("\\.hrl?$" . erlang-mode)
;; ;	 ("\\.app?$" . erlang-mode)
;; ;	 ("\\.app.src?$" . erlang-mode)
;; ;	 ("\\Emakefile" . erlang-mode)))

;; ;(print "Erlang loaded")


;; ;;;;; experimental
;; ;;;;;
;; (defun haskell-get-doc-string()
;;   "Look up the word under cursor in ghci :doc. 
;; The result depends on the loaded context at ghci.

;; This function depends on haskell-mode.el and haskell-interactive-mode.el."
;;   (interactive)
;;   (let ((word
;;          (if (use-region-p)
;;              (buffer-substring-no-properties (region-beginning) (region-end))
;;            (haskell-ident-at-point))))
;;     (haskell-process-show-repl-response
;;      (format ":doc %s" word))
;;     (haskell-process-show-repl-response
;;      (format ":info %s" word))
;;     (haskell-process-show-repl-response
;;      (format "putStrLn \"=== %s ===\"" word))))


;; (defun mbr/company-frontend (command)
;;   "Show company-quickhelp--doc on a buffer. 
;; COMMAND is an argument from company backend."
;;   (pcase command
;;     (`post-command
;;      (let* ((selected (nth company-selection company-candidates))
;;             (doc (let ((inhibit-message t))
;;                    (company-quickhelp--doc selected))))
;;        (with-help-window "*mbr/quick-buffer-doc*"
;; 	  (princ (format "=== %s ===\n\n\n%s" selected doc)))))))

;; (defun enable-mbr/company-frontend()
;;   "Enables for this buffer documentation dysplay on help buffer for company autocomplete candidates."
;;   (interactive)
;;   (make-local-variable 'company-frontends)
;;   (add-to-list 'company-frontends 'mbr/company-frontend :append))

;; (defun disable-mbr/company-frontend()
;;   "Disable for this buffer documentation dysplay on help buffer for company autocomplete candidates."
;;   (interactive)
;;   (setq-local company-frontends (delq 'mbr/company-frontend company-frontends)))


;; (define-minor-mode phils/contextual-help-mode
;;   "Show help for the elisp symbol at point in the current *Help* buffer.

;; Advises `eldoc-print-current-symbol-info'."
;;   :lighter " C-h"
;;   :global t
;;   (require 'help-mode) ;; for `help-xref-interned'
;;   (when (eq this-command 'phils/contextual-help-mode)
;;     (message "Contextual help is %s" (if phils/contextual-help-mode "on" "off")))
;;   (and phils/contextual-help-mode
;;        (eldoc-mode 1)
;;        (if (fboundp 'eldoc-current-symbol)
;;            (eldoc-current-symbol)
;;          (elisp--current-symbol))
;;        (phils/contextual-help :force)))

;; (defadvice eldoc-print-current-symbol-info (before phils/contextual-help activate)
;;   "Triggers contextual elisp *Help* . Enabled by `phils/contextual-help-mode'."
;;   (and phils/contextual-help-mode
;;        (derived-mode-p 'emacs-lisp-mode)
;;        (phils/contextual-help)))

;; (defvar-local phils/contextual-help-last-symbol nil
;;   ;; Using a buffer-local variable for this means that we can't
;;   ;; trigger changes to the help buffer simply by switching windows,
;;   ;; which seems generally preferable to the alternative.
;;   "The last symbol processed by `phils/contextual-help' in this buffer.")

;; (defun phils/contextual-help (&optional force)
;;   "Describe function, variable, or face at point, if *Help* buffer is visible.
;; If FORCE is t *Help* will be made visible
;; https://emacs.stackexchange.com/questions/22132/help-buffer-on-hover-possible"

;;   (let ((help-visible-p (get-buffer-window (help-buffer))))
;;     (when (or help-visible-p :force)
;;       (let ((sym (if (fboundp 'eldoc-current-symbol)
;;                      (eldoc-current-symbol)
;;                    (elisp--current-symbol))))
;;         ;; We ignore keyword symbols, as their help is redundant.
;;         ;; If something else changes the help buffer contents, ensure we
;;         ;; don't immediately revert back to the current symbol's help.
;;         (and (not (keywordp sym))
;;              (or (not (eq sym phils/contextual-help-last-symbol))
;;                  (and force (not help-visible-p)))
;;              (setq phils/contextual-help-last-symbol sym)
;;              sym
;;              (save-selected-window
;;                (describe-symbol sym)))))))


;; (defun phils/contextual-help-toggle ()
;;   "Intelligently enable or disable `phils/contextual-help-mode'."
;;   (interactive)
;;   (if (get-buffer-window (help-buffer))
;;       (phils/contextual-help-mode 'toggle)
;;     (phils/contextual-help-mode 1)))

;; (phils/contextual-help-mode 1)


;; ;;;;
;; (defun pin-current-window()
;;   "Set the selected window as dedicated."
;;   (interactive)
;;   (set-window-dedicated-p (selected-window) t))

;; (defun unpin-current-window()
;;   "Set the selected window as not dedicated."
;;   (interactive)
;;   (set-window-dedicated-p (selected-window) nil))
;; ;;;;;

;; (use-package yasnippet                  ; Snippets
;;   :ensure t
;;   :custom 
;;   (yas-verbosity 1)                      ; No need to be so verbose
;;   (yas-wrap-around-region t)
;;   :config
;;   (yas-reload-all)
;;   (yas-global-mode))

;; (use-package yasnippet-snippets         ; Collection of snippets
;;   :ensure t)

;; (use-package haskell-snippets
;;   :config
;;   (setq-default yas-prompt-functions '(yas-ido-prompt yas-dropdown-prompt)))


;; ;;;;;

;; (defun insert-end-of-text-char ()
;;   "Insert ^C."
;;   (interactive) 
;;   (self-insert-command 1 ?\003)) ;; octal char for C-c

;; (defun insert-end-of-transmition-char ()
;;   "Insert ^D."
;;   (interactive)
;;   (self-insert-command 1 ?\004))



;; (setq ring-bell-function #'flash-on-bell)

;; (defun flash-on-bell ()
;;   "Visual cues to indicate a bell event."
;;   (let ((mode-line-background (face-background 'mode-line))
;; 	(beacon-color "#ee2020")) 

;;     (invert-face 'mode-line)

;;     (buffer-face-mode 1)
;;     (buffer-face-set '(:inverse-video t))

;;     (beacon-blink)
;;     (run-with-timer 0.3 nil #'buffer-face-mode 0)
;;     (run-with-timer 0.3 nil #'buffer-face-set '(:inverse-video nil))
;;     (run-with-timer 0.5 nil #'invert-face 'mode-line)))



;; (defun kill-backward-line ()
;;   "Kill from point until beggining of line.
;; If point at beggining kill previous line."
;;   (interactive)
;;   (let ((point-line-start (point-at-bol))
;;         (current-point (point)))
;;     (if (equal point-line-start current-point)
;;         (kill-line -1)
;;         (kill-region point-line-start current-point))))


;; (global-set-key (kbd "C-M-m") #'kill-backward-line)

(put 'upcase-region 'disabled nil)
;; (provide 'init)
;; ;;; init.el ends here

