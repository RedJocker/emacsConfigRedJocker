;;; package --- Sumary
;;; Commentary:
;;;   file for configuring the enviroment for Emacs
;;; Code:

;; Define the init file for automatic config as "custom.el"
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; Define and initialize package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; shorten yes or no confirmations
(defalias 'yes-or-no-p 'y-or-n-p)

;;highlights cursors current line
(global-hl-line-mode t)

;; no toolbar
(tool-bar-mode -1)

;; tab-bar
(tab-bar-mode 1)

(use-package switch-window
  :ensure t
  :bind ("M-o" . 'switch-window)
  :config
  (setq switch-window-shortcut-appearance 'asciiart
	switch-window-shortcut-style 'qwerty))


;; display time
(setq display-time-24h-format t)
(display-time-mode 1)

;; keybiding help on mini-buffer
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
	which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))

; remember minibuffer prompt history
(setq history-length 25)
(savehist-mode 1)


(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind ("M-x" . smex))

(use-package ido-vertical-mode
  :ensure t
  :init (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

;;show possible completes at minibuffer
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(setq ibuffer-expert t)

;;package adjust-parens
  (require 'adjust-parens)
  (add-hook 'emacs-lisp-mode-hook #'adjust-parens-mode)
  (add-hook 'clojure-mode-hook #'adjust-parens-mode)
  
  (local-set-key (kbd "TAB") 'lisp-indent-adjust-parens)
  (local-set-key (kbd "<backtab>") 'lisp-dedent-adjust-parens)
;;

;; lambda
(global-prettify-symbols-mode t)

;;go to char
(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

;; Theme
;;(use-package exotica-theme
;;  :config (load-theme 'exotica t))

;;(use-package zenburn-theme
;;  :config (load-theme 'zenburn t))

(use-package darktooth-theme
  :config (load-theme 'darktooth t))
;; Theme


;; Beacon - find your cursor faster
(use-package beacon
  :init
  (beacon-mode 1)
  (setq beacon-blink-duration 1)
  (setq beacon-blink-delay 0.2)
  (setq beacon-size 80)
  (setq beacon-blink-when-point-moves-vertically 2)
  (setq beacon-blink-when-point-moves-horizontally 2))

;; Company - general auto completion
(use-package company
  :ensure t
  :bind (("C-c ." . company-complete)
	 ("C-;" . company-complete))
  :init
  (add-hook 'after-init-hook #'global-company-mode)

  (use-package company-quickhelp
    :ensure t
    :init (add-hook 'company-mode-hook #'company-quickhelp-mode)
    :config (setq company-quickhelp-delay 0.5))
  
  ;; Set up statistics for company completions
  (use-package company-statistics
    :ensure t
    :init (add-hook 'after-init-hook #'company-statistics-mode))
  :config
  (setq company-selection-wrap-around t
	company-idle-delay 0.5
	company-minimum-prefix-length 3
	;; show completion numbers for hotkeys
	company-show-numbers t
	;; align annotations to the right
	company-tooltip-align-annotations t
	company-search-regexp-function #'company-search-flex-regexp)
  (bind-keys :map company-active-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous)
	     ("C-d" . company-show-doc-buffer)
	     ("C-l" . company-show-location)
	     ("<tab>" . company-complete)))


;; sintax checker
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; color parentheses
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'ess-mode-hook 'rainbow-delimiters-mode))


;; remember recently edited files
(recentf-mode 1)

; remember and restore last cursor location at file
(save-place-mode 1)

;; case insensitive completion
(setq read-buffer-completion-ignore-case t)


(defun recreate-dashboard()
  "Closed your dashboard? Want to open it? This is the right place."
  (interactive)
  (get-buffer-create "*dashboard*")
  (switch-to-buffer "*dashboard*"))

;; wellcome page
(use-package dashboard
  :ensure t
  :config (dashboard-setup-startup-hook)
  (setq dashboard-item '((recents . 10)))
  :bind ("C-x @ d" . 'recreate-dashboard))

;; editit multiple occurrences of an identifier
(use-package iedit
  :ensure t
  :bind (("<f6>" . iedit-mode))
  :config
  (add-hook 'haskell-mode 'iedit-mode)
  (add-hook 'emacs-lisp-mode-hook 'iedit-mode)
  (add-hook 'clojure-mode-hook 'iedit-mode))
 
;; window resize
(global-set-key (kbd "<f7>") 'enlarge-window-horizontally)
(global-set-key (kbd "<f8>") 'shrink-window-horizontally)
(global-set-key (kbd "<f9>") 'enlarge-window)
(global-set-key (kbd "<f12>") 'shrink-window)

;; switch tab
(global-set-key (kbd "C-x t s") 'tab-switcher)



(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


;;Lisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(add-to-list 'exec-path "/usr/local/Cellar/sbcl/2.0.8/bin/")

(setq inferior-lisp-program "sbcl")
;; Lisp



;; SCHEME
(setq geiser-mit-binary "/usr/local/bin/scheme")
(setq geiser-chez-binary "/usr/local/Cellar/chezscheme/9.5.4/bin/chez")
(setq geiser-guile-binary "/usr/local/Cellar/guile/3.0.4/bin/guile")
(setq geiser-racket-binary "/usr/local/bin/racket")
(setq geiser-mode-smart-tab-p t)
(setq racket-program "/usr/local/bin/racket")
;;



;; Haskell
(defun haskell-get-doc-string()
  "Look up the word under cursor in ghci :doc"
  (interactive)
  (let ((word
         (if (use-region-p)
             (buffer-substring-no-properties (region-beginning) (region-end))
           (haskell-ident-at-point))))
    (haskell-process-show-repl-response
     (format ":doc %s" word))
    (haskell-process-show-repl-response
     (format ":info %s" word))
    (haskell-process-show-repl-response
     (format "putStrLn \"=== %s ===\"" word))))

(use-package flycheck-haskell
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))
 
(use-package lsp-haskell
  :config
  (setq lsp-haskell-formatting-provider "brittany"
	lsp-haskell-server-path
	"/Users/redjocker/.ghcup/bin/haskell-language-server-wrapper"
	;lsp-haskell-server-args nil
	)
  (setq-local before-save-hook `(lsp-format-buffer ,@before-save-hook)))
 
(use-package lsp-mode
  :hook (((haskell-mode haskell-literate-mode) . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :init (setq lsp-keymap-prefix "s-l"
	      lsp-headerline-breadcrumb-enable t
	      lsp-lens-enable nil
	      lsp-eldoc-enable-hover t
	      lsp-modeline-diagnostics-enable t
	      lsp-signature-render-documentation t
	      lsp-signature-doc-lines nil
	      lsp-signature-auto-activate nil
	      ;lsp-completion-show-detail t
	      ;lsp-completion-show-kind t
	      ))

(setq message-truncate-lines nil)

;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
(use-package lsp-ui
  :hook (((haskell-mode haskell-literate-mode) . lsp-ui-doc-mode))
  :config
  (setq lsp-ui-doc-header t
	lsp-ui-doc-enable t
	lsp-ui-doc-include-signature t
	lsp-ui-doc-position 'bottom
	lsp-ui-doc-alignment 'window
	lsp-ui-imenu-enable t
	lsp-ui-imenu-buffer-position 'left
	lsp-eldoc-enable-hover nil
        lsp-log-io t
	lsp-ui-sideline-show-hover nil
	lsp-ui-sideline-show-diagnostics t
	lsp-ui-sideline-show-symbol t
	lsp-ui-sideline-diagnostic-max-lines 15
	lsp-ui-sideline-update-mode 'line
	lsp-ui-sideline-show-code-actions t
	lsp-ui-flycheck-list-position 'right))
 
(use-package haskell-interactive-mode
  :ensure nil
  :config (haskell-indentation-mode)
  :bind
  (:map haskell-interactive-mode-map
        ("<f5>"    . haskell-interactive-switch-back)
        ("C-c C-z" . haskell-interactive-switch-back)
        ("C-c C-h" . bhr/haskell-search-hoogle)))
 
(use-package haskell-literate-mode
  :mode ("\\.lhs$" . haskell-literate-mode)
  :ensure nil
  :hook (haskell-literate-mode . turn-on-haskell-doc-mode))


(setq haskell-process-path-cabal "~/.ghcup/bin/cabal"
      haskell-process-path-ghci "~/.ghcup/bin/ghci"
      haskell-process-path-stack "~/.ghcup/bin/stack")

(use-package haskell-mode
  :mode ("\\.hs$" . haskell-mode)
  :hook ((haskell-mode . haskell-indentation-mode)
         (haskell-mode . display-line-numbers-mode)
         (haskell-mode . turn-on-haskell-doc-mode))
  :config
  (setq haskell-align-imports-pad-after-name t
        haskell-font-lock-symbols t
	haskell-doc-show-global-types nil
	haskell-doc-use-inf-haskell t
	haskell-process-type 'ghci
	haskell-process-suggest-remove-import-lines t
	haskell-process-auto-import-loaded-modules t
	haskell-process-use-presentation-mode t
	haskell-process-auto-import-loaded-modules t
	haskell-process-suggest-haskell-docs-imports t
	haskell-process-suggest-hoogle-imports t
	haskell-process-suggest-remove-import-lines t
	haskell-tags-on-save nil)
  
  :bind
  (:map haskell-mode-map
        ("<f5>"         . 'haskell-interactive-switch)
        ("C-c C-z"      . 'haskell-interactive-switch)
        ("C-c C-d"      . 'haskell-get-doc-string)
        ("C-c C-l"      . 'haskell-process-load-file)
        ("C-c C-h"      . 'bhr/haskell-search-hoogle)
        ("C-c C-n C-t"  . 'haskell-process-do-type)
        ("C-c C-n C-i"  . 'haskell-process-do-info)
        ("C-c C-n C-c"  . 'haskell-process-cabal-build)
        ("C-c C-n c"    . 'haskell-process-cabal)
	("C-c a"       .  'lsp-ui-sideline-apply-code-actions)))
 
(defun bhr/haskell-search-hoogle (start end)
  "Search hoogle for the highlighted region or word under the cursor"
  (interactive "r")
  (let ((criteria (if (use-region-p)
                      (buffer-substring-no-properties start end)
                    (thing-at-point 'word))))
    (message "Hoogle: %s" criteria)
    (browse-url (concat "https://hoogle.haskell.org/?hoogle=" criteria))))


(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))


(provide 'init)
;;; init.el ends here
