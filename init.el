;; alias
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'list-buffers 'ibuffer)

;; frame-title-format:
;; `%F': frame-name
;; `%@': '@'(if at a remote machine) or '-'(if at localhost)
;; `%f': file-name
(setq-default frame-title-format "%F %@ %f")
(setq-default major-mode 'text-mode)
(global-set-key (kbd "C-x f") 'find-file-in-repository)
(setq-default ring-bell-function 'ignore)

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
 '(icomplete-mode t)
 '(ido-enable-flex-matching t)
 '(ido-enable-regexp t)
 '(ido-mode 'both nil (ido))
 '(ido-use-filename-at-point t)
 '(ido-use-url-at-point t)
 '(inhibit-startup-screen t)
 '(lsp-enable-file-watchers nil)
 '(mouse-avoidance-mode 'animate nil (avoid))
 '(package-selected-packages
   '(lsp lua-mode protobuf-mode go-snippets projectile-speedbar projectile lsp-treemacs go-imenu go-tag go-imports go-fill-struct go-impl scala-mode go-mode lsp-ui use-package find-file-in-repository flycheck ack yaml-mode company-c-headers markdown-mode yasnippet sql-indent company))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(unless (string-equal system-type "darwin")
   (menu-bar-mode 0))

;; (global-hl-line-mode t)
;; This is an emacs elpa mirror from china: CST:China Standard Time
(if (equal (car (cdr (current-time-zone))) "CST")
    (setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
			     ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (< emacs-major-version 27)
  (package-initialize))

;; if `use-package' does not exist, then refresh package contents from (m)elpa
;; and install selected packages
;; (package-refresh-contents t)

(require 'use-package)
(setq use-package-always-ensure t)

(add-hook 'after-init-hook (lambda ()
			     (global-auto-revert-mode t)
			     (global-company-mode)))

(use-package company
  :init
  (set-variable 'company-backends '(company-capf company-dabbrev company-dabbrev-code company-files company-keywords
	      (company-clang company-gtags company-etags company-cmake company-semantic)
	        company-bbdb company-oddmuse))
  :config
  (setq company-minimum-prefix-length 1
      company-idle-delay 0.0))

(use-package lsp-mode
  :init
  (setq lsp-diagnostic-package :auto)
  :commands (lsp lsp-deferred))

;; optional - provides fancier overlays
(use-package lsp-ui
  :init
  (setq lsp-ui-doc-enable nil)
  :commands lsp-ui-mode)

(use-package sql-indent
  :init
  (setq sql-indent-offset 8))

;; load initialization for c programming language and html mode
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-text)
(require 'init-c)
(require 'init-go)
(require 'init-python)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
