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
(add-hook 'after-init-hook 'do_whatever_after_init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(column-number-mode t)
 '(display-time-mode t)
 '(electric-pair-mode t)
 '(icomplete-mode t)
 '(ido-enable-flex-matching t)
 '(ido-enable-regexp t)
 '(ido-mode (quote both) nil (ido))
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(mouse-avoidance-mode (quote animate) nil (avoid))
 '(package-selected-packages
   (quote
    (find-file-in-repository flycheck scala-mode ack flycheck-golangci-lint kotlin-mode company-jedi yaml-mode emojify neotree company-c-headers company-go markdown-mode async yasnippet sql-indent ggtags company)))
 '(server-mode t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
;; (global-hl-line-mode t)
;; This is an emacs elpa mirror from china: CST:China Standard Time
(if (equal (car (cdr (current-time-zone))) "CST")
    (setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
			     ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(when (not (package--user-selected-p 'company))
  (package-install-selected-packages))
(require 'company)
(require 'ggtags)
(require 'yasnippet)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; load initialization for c programming language and html mode
(require 'init-text)
(require 'init-c)
(require 'init-go)
(require 'init-python)
;; (require 'init-java)

(defun do_whatever_after_init ()
  (global-company-mode)
  (global-auto-revert-mode t))

(add-hook 'sql-mode-hook
	  (lambda ()
	    (sqlind-minor-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
