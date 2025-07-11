;; alias
(defalias 'list-buffers 'ibuffer)

;; make 'y-or-n-p a short version of 'yes-or-no-p
(setq-default use-short-answers t)

(setq-default use-dialog-box nil)

;; frame-title-format:
;; `%F': frame-name
;; `%@': '@'(if at a remote machine) or '-'(if at localhost)
;; `%f': file-name
(setq-default frame-title-format "%F %@ %f")
(setq-default major-mode 'text-mode)
(setq-default ring-bell-function 'ignore)
(setq-default default-frame-alist '((font . "Monospace-10:pixelsize=14")(width . 100)(height . 45)))
(setq-default initial-major-mode 'markdown-mode)
(setq-default initial-scratch-message "\
# This buffer is for text that is not saved, and for markdown-mode.
# To create a file, visit it with `C-x C-f' and enter text in its buffer.

")
;; Enable so-long library.
(when (require 'so-long nil :noerror)
  (global-so-long-mode 1)
  ;; Basic settings.
  (setq so-long-action 'so-long-minor-mode)
  ;; Additional target major modes to trigger for.
  (mapc (apply-partially #'add-to-list 'so-long-target-modes)
        '(sgml-mode nxml-mode js-mode text-mode))
  ;; Additional buffer-local minor modes to disable.
  (mapc (apply-partially #'add-to-list 'so-long-minor-modes)
        '(diff-hl-mode diff-hl-amend-mode diff-hl-flydiff-mode))
  ;; Additional variables to override.
  (mapc (apply-partially #'add-to-list 'so-long-variable-overrides)
        '((show-trailing-whitespace . nil)
          (truncate-lines . nil))))

(global-set-key (kbd "C-x f") 'project-find-file)
(global-set-key (kbd "M-!") 'async-shell-command)

;; This is an emacs elpa mirror from china: CST:China Standard Time
(if (equal (car (cdr (current-time-zone))) "CST")
    (setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
			     ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f"
    "#f6f3e8"])
 '(column-number-mode t)
 '(connection-local-criteria-alist
   '(((:application tramp :protocol "kubernetes")
      tramp-kubernetes-connection-local-default-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile
      tramp-connection-local-default-shell-profile)))
 '(display-time-default-load-average nil)
 '(display-time-format "%H:%M %Z")
 '(display-time-mode t)
 '(electric-pair-mode t)
 '(ido-enable-flex-matching t)
 '(ido-enable-regexp t)
 '(ido-mode 'both nil (ido))
 '(ido-use-filename-at-point t)
 '(ido-use-url-at-point t)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold 2000000)
 '(menu-bar-mode nil)
 '(mode-line-compact 'long)
 '(mouse-avoidance-mode 'animate nil (avoid))
 '(org-agenda-files nil)
 '(package-native-compile t)
 '(package-selected-packages
   '(all-the-icons bison-mode clang-format company go-mode go-playground
		   helm lsp-mode lsp-treemacs lsp-ui magit
		   markdown-mode markdown-toc protobuf-mode rust-mode
		   rust-playground sql-indent treemacs yaml-mode
		   yasnippet yasnippet-classic-snippets))
 '(save-place-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-follow-symlinks t)
 '(warning-suppress-log-types '((comp))))

(setq use-package-always-ensure t)
(setq use-package-always-defer t)

(use-package helm
  :init
  (setq completion-styles '(flex))
  :config
  (setq helm-move-to-line-cycle-in-source nil)
  :bind
  ("C-x C-f" . helm-find-files)
  ("C-x b" . 'helm-buffers-list)
  :bind
  ("M-x" . helm-M-x))

(use-package company
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0)
  :defer)

(add-hook 'after-init-hook (lambda ()
			     ;; (global-auto-revert-mode t)
			     (global-company-mode)
			     (which-key-mode)
			     (helm-mode)
			     (recentf-mode)
			     (savehist-mode)))

(use-package magit
  :config
  (define-key magit-mode-map (kbd "C-x g") #'magit-status)
  :defer)

(use-package lsp-treemacs
  :after (lsp-mode)
  :config
  (setq lsp-treemacs-sync-mode t)
  (setq treemacs-file-event-delay 500)
  (setq treemacs-file-follow-delay 0.05))

(use-package lsp-mode
  :demand t
  :init
  (setq read-process-output-max (* 1024 1024)) ; 1MiB
  :config
  (define-key lsp-mode-map (kbd "C-c") lsp-command-map)
  (setq lsp-response-timeout 20)
  (setq lsp-auto-guess-root t)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-clients-clangd-args (list "--header-insertion=never"
				      (concat "--resource-dir="
					      (if (file-exists-p "/usr/lib/gcc/x86_64-linux-gnu/15")
						  "/usr/lib/gcc/x86_64-linux-gnu/15"
						(if (file-exists-p "/usr/local/lib/gcc/x86_64-linux-gnu/15")
						    "/usr/local/lib/gcc/x86_64-linux-gnu/15"
						  "/usr/lib/gcc/x86_64-linux-gnu/14")))
				      ;; let clangd generate index in background
				      "-background-index")))

(use-package lsp-ui
  :after (lsp-mode)
  :config
  ;; (setq lsp-ui-doc-delay 0.1)
  (setq lsp-ui-doc-enable nil)
  (define-key lsp-ui-mode-map
	      [remap xref-find-references] #'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map (kbd "M-/") #'lsp-ui-peek-find-implementation))

(use-package yasnippet
  :config
  :hook ((prog-mode) . #'yas-minor-mode))

(use-package yasnippet-classic-snippets)

;; configuration for golang programming language
(use-package go-mode
  :hook ((go-mode) .
	 (lambda ()
	   (subword-mode)
	   (setq gofmt-command "gofmt")
	   (setq gofmt-args (list "-l"))
	   (add-hook 'before-save-hook 'gofmt-before-save nil t)
	   (if (not (string-match "go" compile-command))
	       (setq-local compile-command "go test -vet=all -v"))
	   (if (featurep 'lsp-mode)
	       (progn
		 ;; (setq lsp-go-build-flags ["-tags=duckdb"])
		 (lsp-deferred)
		 )
	     ))))

(use-package go-playground
  :config
  (setq go-playground-init-command "")
  (setq go-playground-basedir "~/.go/src/playground")
  :hook ((go-playground-mode) .
	 (lambda ()
	   (define-key go-playground-mode-map (kbd "C-<return>") #'go-playground-exec)
	   )
	 )
  )

;; rust mode support
;; ```
;; apt install rustup
;; RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static rustup install stable
;; RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static rustup default stable
;; RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static rustup component add rust-src rust-analysis rust-analyzer
;; RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static rustup update
;; ```
(use-package rust-mode
  :config
  :hook ((rust-mode) .
	 (lambda ()
	   (setq-local compile-command "cargo run --release")
	   (setq-local rust-mode-treesitter-derive t)
	   (setq-local rust-format-on-save t)
	   (setq-local rust-indent-offset 8)
	   (if (featurep 'lsp-mode)
	       (lsp-deferred))
	   (if (featurep 'lsp-ui)
	       (progn
		 (define-key lsp-ui-mode-map
			     [remap xref-find-references] #'lsp-ui-peek-find-references)
		 (define-key lsp-ui-mode-map (kbd "M-/") #'lsp-ui-peek-find-implementation)))
	   )))

(use-package rust-playground
  :config
  (define-key rust-playground-mode-map (kbd "C-<return>") #'rust-playground-exec)
  (setq rust-playground-basedir (expand-file-name "~/src/playground"))
  (setq rust-playground-run-command "cargo run --release")
  (setq rust-playground-cargo-toml-template
	"[package]\12name = \"foo\"\12version = \"0.1.0\"\12authors = [\"Rust Example <rust-snippet@example.com>\"]\12edition = \"2024\"\12\12[dependencies]")
  :hook ((rust-playground-mode) .
	 (lambda ()
	   (if (featurep 'lsp-mode)
	       (define-key rust-playground-mode-map (kbd "C-c C-c") lsp-command-map))
	   (if (> (buffer-size) 0)
	       (let* ((last-off (- (point) (point-min)))
		      (mode-title "// -*- mode: rust; mode: rust-playground -*-\n")
		      (len (string-width mode-title))
		      (first-line (buffer-substring-no-properties (point-min) (+ (point-min) len))))
		 (unless (or (string-blank-p first-line)
			     (string-search "mode" first-line))
		   (progn
		     (beginning-of-buffer)
		     (insert mode-title)
		     (goto-char (+ (point-min) (+ last-off len 1)))
		     )))
	     )))
  )

(advice-add 'rust-playground-rm :after
            (lambda (&rest _)
	      (lsp-shutdown-workspace)))

;; configuration for editing html/xhtml...
(add-hook 'text-mode-hook
	  (lambda ()
	    (setq fill-column 80)
	    (auto-fill-mode)
	    (setq bidi-display-reordering nil)
	    (setq line-move-visual nil)))
;; "custom-setting for c family language"
(setq c-default-style '((c-mode . "linux")
			(c++-mode . "stroustrup")
			(awk-mode . "awk")
			(python-mode . "python")
			(other . "gnu")))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (if (featurep 'lsp-mode)
		(lsp-deferred))
	    ;; comment-style
	    (setq comment-style 'extra-line)
	    ;; behavior of symbol `#', e.g. #define... #include...
	    (setq c-electric-pound-behavior '(alignleft))))


(use-package clang-format)
;;(add-to-list 'load-path (concat user-emacs-directory "github/bison-mode/"))
;;(require 'bison-mode)
(add-to-list 'auto-mode-alist '("\\.yy\\'" . bison-mode))

;; configuration for python programming language
(add-hook 'python-mode-hook #'eglot-ensure)

(use-package sql-indent
  :config
  (setq sql-indent-offset 8))

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :hook ((markdown-mode) . (lambda()
			     (auto-fill-mode 0))
	 ))
(use-package markdown-toc)

(use-package yaml-mode)

(use-package protobuf-mode)

(defun json-validator ()
  (condition-case nil
      (let ((buf (buffer-substring-no-properties (point-min) (point-max))))
	(unless (string-empty-p buf)
	  (json-parse-string
	   (replace-regexp-in-string
	    "{{.*}}" "0"
	    buf))))
    (debug "ill-formed json"))
  nil)

(add-hook 'js-mode-hook
	  (lambda ()
	    (if (string-suffix-p "json" (file-name-extension (buffer-name)))
		(add-hook 'write-file-functions #'json-validator nil t))))

(defun reset-font (&optional pixelsize)
  (interactive)
  (if (not (equal pixelsize nil))
      (set-frame-font (format "Mono-10:pixelsize=%d" pixelsize))
    (set-frame-font "Mono-10:pixelsize=14")))

(defun indent-buffer ()
  (if (featurep 'clang-format)
      (when (derived-mode-p
	     'c-mode 'c++-mode 'js-mode 'java-mode 'protobuf-mode)
	(setq-local indent-region-function 'clang-format)))
  (indent-region (point-min) (point-max)))

(add-hook 'prog-mode-hook
	  (lambda ()
	    (when (not (derived-mode-p 'makefile-mode 'snippet-mode))
	      (add-hook 'before-save-hook 'indent-buffer 0 t))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
