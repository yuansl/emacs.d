"custom-setting for c family language"
(setq c-default-style '((c-mode . "linux")
			(c++-mode . "stroustrup")
			(awk-mode . "awk")
			(python-mode . "python")
			(other . "gnu")))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (setq fill-column 80)
	    (auto-fill-mode 1)
	    (when (derived-mode-p 'c++-mode 'c-mode)
	      (ggtags-mode)
	      (setenv "GTAGSLIBPATH" (file-truename "~/lib/systemsymbol"))
	      ;; behavior of symbol `#', e.g. #define... #include...
	      (setq c-electric-pound-behavior (quote (alignleft)))
	      (if (derived-mode-p 'c++-mode)
		  (setq company-clang-arguments '("-std=c++14"))
		(setq company-clang-arguments (list (concat
						     "-I"
						     (getenv "HOME")
						     "/lib")))))))
(provide 'init-c)
