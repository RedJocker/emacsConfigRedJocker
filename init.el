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

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; shorten yes or no confirmations
(defalias 'yes-or-no-p 'y-or-n-p)


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


;; keybiding help on mini-buffer
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
        which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))

;; (conflicts with Helm)
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
;; (conflicts with Helm)


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

;; Company - general auto completion
(use-package company
  :bind (("C-L" . company-complete))
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  (company-selection-wrap-around t)
  :config
  (global-company-mode))

;; Lisp 
  ;; Slime
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")
;; Lisp


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

; remember minibuffer prompt history
(setq history-length 25)
(savehist-mode 1)

; remember and restore last cursor location at file
(save-place-mode 1)

;; wellcome page
(use-package dashboard
  :ensure t
  :config (dashboard-setup-startup-hook)
  (setq dashboard-item '((recents . 10))))


(use-package iedit
  :ensure t
  :bind (("<f6>" . iedit-mode))
  :config
  (add-hook 'emacs-lisp-mode-hook 'iedit-mode)
  (add-hook 'clojure-mode-hook 'iedit-mode))
  

(global-set-key (kbd "<f7>") 'enlarge-window-horizontally)
(global-set-key (kbd "<f8>") 'shrink-window-horizontally)
(global-set-key (kbd "<f9>") 'enlarge-window)
(global-set-key (kbd "<f12>") 'shrink-window)


(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "markdown"))

;; haskell

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
 
(use-package lsp-mode
  :diminish lsp-mode
  :hook (((haskell-mode haskell-literate-mode) . lsp-deferred))
         (lsp-mode . lsp-enable-which-key-integration))
 
(use-package lsp-ui
  :hook ((haskell-mode haskell-literate-mode) . lsp-ui-doc-mode)
  :config
  (setq lsp-ui-doc-header t
        lsp-ui-doc-include-signature t
	lsp-log-io t))
 
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
  :config
  (interactive-haskell-mode)
  (turn-on-haskell-doc-mode))
 
(use-package haskell-mode
  :mode ("\\.hs$" . haskell-mode)
  :diminish flycheck-mode
  :config
  (interactive-haskell-mode)
  (turn-on-haskell-doc-mode)
  (haskell-indentation-mode)
  (setq haskell-process-type 'stack-ghci
        haskell-align-imports-pad-after-name t
        haskell-process-suggest-remove-import-lines t
        haskell-process-auto-import-loaded-modules t
        haskell-font-lock-symbols t
        haskell-process-use-presentation-mode t
	haskell-doc-show-global-types t
	haskell-process-auto-import-loaded-modules t
	haskell-process-suggest-add-package  t
	haskell-process-suggest-haskell-docs-imports t
	haskell-process-suggest-hoogle-imports t
	haskell-process-suggest-language-pragmas t
	haskell-process-show-overlays t
	)
  :bind
  (:map haskell-mode-map
        ("<f5>"    . haskell-interactive-switch)
        ("C-c C-z" . haskell-interactive-switch)
	("C-c C-d" . 'haskell-get-doc-string)
        ("C-c C-l" . haskell-process-load-or-reload)
        ("C-c C-h" . bhr/haskell-search-hoogle)))
 
(defun bhr/haskell-search-hoogle (start end)
  "Search hoogle for the highlighted region or word under the cursor"
  (interactive "r")
  (let ((criteria (if (use-region-p)
                      (buffer-substring-no-properties start end)
                    (thing-at-point 'word))))
    (message "Hoogle: %s" criteria)
    (browse-url (concat "https://hoogle.haskell.org/?hoogle=" criteria))))

(provide 'init)
;;;init ends here
