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
(setq-default default-frame-alist '((font . "Monospace-10:pixelsize=14")))

(global-set-key (kbd "C-x f") 'project-find-file)

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
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(column-number-mode t)
 '(display-time-mode t)
 '(electric-pair-mode t)
 '(global-so-long-mode t)
 '(helm-display-buffer-height 10)
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
   '(helm go-playground rust-mode magit clang-format lsp-mode yasnippet-snippets which-key bui markdown-toc lsp lua-mode protobuf-mode go-mode lsp-ui use-package flycheck yaml-mode company-c-headers markdown-mode yasnippet sql-indent company))
 '(save-place-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(warning-suppress-log-types '((comp))))

;; load packages using package.el
(setq use-package-always-ensure t)

(use-package helm
  :ensure t
  :commands
  (helm-mode)
  :init
  (setq completion-styles '(flex))
  :bind
  ("C-x C-f" . helm-find-files)
  :bind
  ("M-x" . helm-M-x))

(use-package which-key
  :ensure t)

(use-package magit
  :ensure t
  :config
  (define-key magit-mode-map (kbd "C-x g") #'magit-status))

(use-package company
  :ensure t
  :config
  ;; we use lsp/clangd for code complete
  (delete 'company-clang company-backends)
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0))

(use-package sql-indent
  :init
  (setq sql-indent-offset 8))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode))

(use-package yasnippet
  :config
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package lsp-ui
  :ensure t)

(use-package lsp-mode
  :ensure t
  :init
  (setq read-process-output-max (* 1024 1024)) ; 1MiB
  (setq lsp-enable-file-watchers nil))

;; load initialization for c programming language and html mode
(add-to-list 'load-path (expand-file-name "elpa" user-emacs-directory))
(require 'init-text)
(require 'init-c)
(require 'init-go)
(require 'init-python)

(add-hook 'after-init-hook (lambda ()
			     (global-auto-revert-mode t)
			     (global-company-mode)
			     (which-key-mode)))

(defun json-validator ()
  (condition-case nil
      (json-parse-string
       (replace-regexp-in-string
	"{{.*}}" "0"
	(buffer-substring-no-properties (point-min) (point-max))))
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
	    (when (not (derived-mode-p 'makefile-mode))
	      (add-hook 'before-save-hook 'indent-buffer 0 t))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
