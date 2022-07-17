;;; package --- Sumary
;;; Commentary:
;;;   file for configuring the enviroment for Emacs
;;; Code:

;; Define the init file for automatic config as "custom.el"
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Define and initialize package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; add $PATH
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Theme
;;(use-package exotica-theme
;;  :config (load-theme 'exotica t))

;;(use-package zenburn-theme
;;  :config (load-theme 'zenburn t))

(use-package darktooth-theme
  :config (load-theme 'darktooth t))
;; Theme

;; display time
(setq display-time-24h-format t)
(display-time-mode 1)

;;no tollbar
(tool-bar-mode -1)

;; do not truncate messages on echo buffer
(setq message-truncate-lines nil)

;;highlights cursors current line
(global-hl-line-mode t)

;; tab-bar
(tab-bar-mode 1)

;; switch tab
(global-set-key (kbd "C-x t s") 'tab-switcher)

;; remember recently edited files
(recentf-mode 1)

; remember minibuffer prompt history
(setq history-length 25)
(savehist-mode 1)

; remember and restore last cursor location at file
(save-place-mode 1)

;; shorten yes or no confirmations
(defalias 'yes-or-no-p 'y-or-n-p)

;; case insensitive completion
(setq read-buffer-completion-ignore-case t)


;; keybiding help on mini-buffer
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
        which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))

;;;; (conflicts with Helm)
;; minibuffer autocomplete 
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind ("M-x" . smex))

(use-package ido-vertical-mode
  :ensure t
  :init (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

(global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
;; kill buffer without y-n
(setq ibuffer-expert t)
;;;; (conflicts with Helm)


;; Helm configuration
;(use-package helm
;  :config
;  (require 'helm-config)
;  :init
;  (helm-mode 1)
;  :bind
;  (("M-x"     . helm-M-x) ;; Evaluate functions
;   ("C-x C-f" . helm-find-files) ;; Open or create files
;   ("C-x b"   . helm-mini) ;; Select buffers
;   ("C-x C-r" . helm-recentf) ;; Select recently saved files
;   ("C-c i"   . helm-imenu) ;; Select document heading
;   ("M-y"     . helm-show-kill-ring) ;; Show the kill ring
;   :map helm-map
;   ("C-z" . helm-select-action)
;   ("<tab>" . helm-execute-persistent-action)))


;; Beacon - find your cursor faster
(use-package beacon
  :init
  (beacon-mode 1)
  (setq beacon-blink-duration 1)
  (setq beacon-blink-delay 0.2)
  (setq beacon-size 80)
  (setq beacon-blink-when-point-moves-vertically 2)
  (setq beacon-blink-when-point-moves-horizontally 2))


;; color parentheses
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'ess-mode-hook 'rainbow-delimiters-mode))

;;go to char
(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))



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


(use-package iedit
  :ensure t
  :bind (("<f6>" . iedit-mode))
  :config
  (add-hook 'emacs-lisp-mode-hook 'iedit-mode)
  (add-hook 'clojure-mode-hook 'iedit-mode)
  (add-hook 'haskell-mode-hook 'iedit-mode))
  

;; window resize
(global-set-key (kbd "<f7>") 'enlarge-window-horizontally)
(global-set-key (kbd "<f8>") 'shrink-window-horizontally)
(global-set-key (kbd "<f9>") 'enlarge-window)
(global-set-key (kbd "<f12>") 'shrink-window)

;; switch buffers
(use-package switch-window
  :ensure t
  :bind ("M-o" . 'switch-window)
  :config
  (setq switch-window-shortcut-appearance 'asciiart
	switch-window-shortcut-style 'qwerty))

;(use-package ace-window
;  :ensure t
;  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
;              aw-char-position 'left
;              aw-ignore-current nil
;              aw-leading-char-style 'char
;              aw-scope 'frame)
;  :bind (("M-o" . ace-window)
;         ("M-O" . ace-swap-window)))


(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "markdown"
	      markdown-enable-math t))


;; Company - general auto completion
(use-package company
  :ensure t
  :bind (("C-c ." . company-complete)
	 ("C-;" . company-complete))
  :init
  (add-hook 'after-init-hook #'global-company-mode)

  (require 'pos-tip)
  (use-package company-quickhelp
    :ensure t
    :init (add-hook 'company-mode-hook #'company-quickhelp-mode)
    :config (setq company-quickhelp-delay 1.0))
  
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

;; language server
(use-package lsp-mode
  :hook (((haskell-mode haskell-literate-mode) . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :init (setq lsp-keymap-prefix "s-l"
	      lsp-headerline-breadcrumb-enable t
	      lsp-lens-enable nil
	      lsp-eldoc-enable-hover t
	      lsp-modeline-diagnostics-enable t
	      lsp-signature-render-documentation t
	      lsp-signature-doc-lines 20
	      lsp-signature-auto-activate nil
	      lsp-completion-show-detail t
	      lsp-completion-show-kind nil
	      lsp-enable-file-watchers nil
	      lsp-log-io nil
	      lsp-haskell-server-path
	      "~/.ghcup/bin/haskell-language-server-wrapper"))

;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
(use-package lsp-ui
  :hook (((haskell-mode haskell-literate-mode) . lsp-ui-doc-mode))
  :config
  (setq lsp-ui-doc-use-childframe t
	lsp-ui-doc-header t
	lsp-ui-doc-enable t
	lsp-ui-doc-include-signature t
	lsp-ui-doc-position 'bottom
	lsp-ui-doc-alignment 'frame
	lsp-ui-doc-show-with-cursor t
	lsp-ui-doc-show-with-mouse t
	lsp-ui-imenu-enable t
	lsp-ui-imenu-buffer-position 'left
	lsp-ui-sideline-show-hover nil
	lsp-ui-sideline-show-diagnostics t
	lsp-ui-sideline-show-symbol t
	lsp-ui-sideline-diagnostic-max-lines 15
	lsp-ui-sideline-update-mode 'line
	lsp-ui-sideline-show-code-actions t
	lsp-ui-flycheck-list-position 'right))


;; Lisp 
  ;; Slime
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")
;; Lisp


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
  (setq lsp-haskell-formatting-provider "brittany")
  (setq-local before-save-hook `(lsp-format-buffer ,@before-save-hook)))
 

 
(use-package haskell-literate-mode
  :mode ("\\.lhs$" . haskell-literate-mode)
  :ensure nil
  :hook (haskell-literate-mode . turn-on-haskell-doc-mode))
 
(use-package haskell-mode
  :mode ("\\.hs$" . haskell-mode)
  :hook (('haskell-mode . haskell-indentation-mode)
         ('haskell-mode . display-line-numbers-mode)
         ('haskell-mode . turn-on-haskell-doc-mode)
	 ('haskell-mode . interactive-haskell-mode))
  :config
  (require 'haskell-interactive-mode)
  (require 'haskell-process)
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
	haskell-tags-on-save nil
	haskell-process-path-cabal "~/.ghcup/bin/cabal"
	haskell-process-path-ghci "~/.ghcup/bin/ghci"
	haskell-process-path-stack "~/.ghcup/bin/stack")
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
;; Haskell


;;;;; experimental
(defun mbr/company-frontend (command)
  (pcase command
    (`post-command
     (let* ((selected (nth company-selection company-candidates))
            (doc (let ((inhibit-message t))
                   (company-quickhelp--doc selected))))
       (with-help-window "*mbr/quick-buffer-doc*"
	  (princ (format "=== %s ===\n\n\n%s" selected doc)))))))

(defun enable-mbr/company-frontend()
  "Enables for this buffer documentation dysplay on help buffer for company autocomplete candidates."
  (make-local-variable 'company-frontends)
  (add-to-list 'company-frontends 'mbr/company-frontend :append))

(defun disable-mbr/company-frontend()
  "Disable for this buffer documentation dysplay on help buffer for company autocomplete candidates."
  (setq-local company-frontends (delq 'mbr/company-frontend company-frontends)))


(define-minor-mode phils/contextual-help-mode
  "Show help for the elisp symbol at point in the current *Help* buffer.
Advises `eldoc-print-current-symbol-info'."
  :lighter " C-h"
  :global t
  (require 'help-mode) ;; for `help-xref-interned'
  (when (eq this-command 'phils/contextual-help-mode)
    (message "Contextual help is %s" (if phils/contextual-help-mode "on" "off")))
  (and phils/contextual-help-mode
       (eldoc-mode 1)
       (if (fboundp 'eldoc-current-symbol)
           (eldoc-current-symbol)
         (elisp--current-symbol))
       (phils/contextual-help :force)))

(defadvice eldoc-print-current-symbol-info (before phils/contextual-help activate)
  "Triggers contextual elisp *Help*. Enabled by `phils/contextual-help-mode'."
  (and phils/contextual-help-mode
       (derived-mode-p 'emacs-lisp-mode)
       (phils/contextual-help)))

(defvar-local phils/contextual-help-last-symbol nil
  ;; Using a buffer-local variable for this means that we can't
  ;; trigger changes to the help buffer simply by switching windows,
  ;; which seems generally preferable to the alternative.
  "The last symbol processed by `phils/contextual-help' in this buffer.")

(defun phils/contextual-help (&optional force)
  "Describe function, variable, or face at point, if *Help* buffer is visible.
https://emacs.stackexchange.com/questions/22132/help-buffer-on-hover-possible
"
  (let ((help-visible-p (get-buffer-window (help-buffer))))
    (when (or help-visible-p force)
      (let ((sym (if (fboundp 'eldoc-current-symbol)
                     (eldoc-current-symbol)
                   (elisp--current-symbol))))
        ;; We ignore keyword symbols, as their help is redundant.
        ;; If something else changes the help buffer contents, ensure we
        ;; don't immediately revert back to the current symbol's help.
        (and (not (keywordp sym))
             (or (not (eq sym phils/contextual-help-last-symbol))
                 (and force (not help-visible-p)))
             (setq phils/contextual-help-last-symbol sym)
             sym
             (save-selected-window
               (describe-symbol sym)))))))

(defun phils/contextual-help-toggle ()
  "Intelligently enable or disable `phils/contextual-help-mode'."
  (interactive)
  (if (get-buffer-window (help-buffer))
      (phils/contextual-help-mode 'toggle)
    (phils/contextual-help-mode 1)))

(phils/contextual-help-mode 1)

(provide 'init)
;;;init ends here
