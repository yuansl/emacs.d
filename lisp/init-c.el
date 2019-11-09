"custom-setting for c family language"
(setq c-default-style '((c-mode . "linux")
			(c++-mode . "stroustrup")
			(awk-mode . "awk")
			(python-mode . "python")
			(other . "gnu")))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; comment-style
	    (setq comment-style 'extra-line)
	    ;; behavior of symbol `#', e.g. #define... #include...
	    (setq c-electric-pound-behavior '(alignleft))
	    (setq company-clang-arguments
		  (append '("-I~/lib")
		   (if (derived-mode-p 'c++-mode) '("-std=c++14"))))
	    (when (derived-mode-p 'c++-mode 'c-mode)
	      (ggtags-mode)
	      (setenv "GTAGSLIBPATH" (file-truename "~/lib/systemsymbol")))))

;(add-to-list 'load-path (concat user-emacs-directory "github/bison-mode/"))
;(require 'bison-mode)
(add-to-list 'auto-mode-alist '("\\.yy\\'" . bison-mode))

(use-package company-c-headers
  :commands company-c-headers)

(provide 'init-c)
