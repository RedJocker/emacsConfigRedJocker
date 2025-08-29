;;; package --- Sumary
;;; Commentary:
;;;   file for configuring the enviroment for Emacs
;;; Code:

;; Define emacs directory for this alternative configuration
;; Start emacs with
;; #+begin_src:
;;  emacs -Q --init-directory ~/.emacs.42.d/
;; #+end_src: 

(setq user-emacs-directory "~/.emacs.42.d/")

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

(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))


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

(load (expand-file-name "list.el" (concat user-emacs-directory "42")))
(load (expand-file-name "string.el" (concat user-emacs-directory "42")))
(load (expand-file-name "comments.el" (concat user-emacs-directory "42")))
(load (expand-file-name "header.el" (concat user-emacs-directory "42")))


(use-package deadgrep
  :ensure t
  :bind ("C-c p s" . #'deadgrep))

;; (use-package vterm
;;   :ensure t)


(use-package multiple-cursors
  :ensure t
  :bind
  (("C-c <right>" . #'mc/mark-next-like-this-word)
   ("C-c <down>"  . #'mc/mark-next-lines)
   ("C-c <up>"    . #'mc/mark-previous-lines)
   ("C-c >"       . #'mc/mark-all-symbols-like-this-in-defun)
   ("C-c M->"     . #'mc/mark-all-words-like-this)
   ("C-c SPC"     . #'mc/edit-lines)
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
;;(load-theme 'afternoon)

;;(set-face-attribute 'hl-line nil :foreground nil :background "#222222")
;;(set-face-attribute 'hl-line nil :foreground nil :background "#DDDDDD")

;;(set-frame-font "Monospace 19" nil t)
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


(push "/usr/share/emacs/site-lisp/" load-path)
(require 'clang-format)
(require 'clang-include-fixer)
(require 'clang-rename)



;; (defun cppman (entry)
;;   "View C++ reference entry using cppman in Emacs, similar to man command.
;; If called interactively with no argument, uses the symbol at point as default."
;;   (interactive
;;    (list (let* ((default (thing-at-point 'symbol t))
;;                 (prompt (if default
;;                             (format "C++ Reference entry (default %s): " default)
;;                           "C++ Reference entry: ")))
;;            (read-string prompt nil nil default))))
;;   (let ((buffer (get-buffer-create (format "*cppman %s*" entry))))
;;     (with-current-buffer buffer
;;       (setq buffer-read-only nil)
;;       (erase-buffer)
;;       (call-process-shell-command
;;        (format "cppman %s | col -b" entry)
;;        nil (current-buffer))
;;       (if (zerop (buffer-size))
;;           (message "No results found for %s" entry)
;;         (special-mode))
;;       (setq buffer-read-only t)
;;       (beginning-of-buffer))
;;     (unless (zerop (buffer-size))
;;       (switch-to-buffer buffer))))


(put 'upcase-region 'disabled nil)

;; (provide 'init)
;; ;;; init.el ends here

