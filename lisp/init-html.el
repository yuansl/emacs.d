;; configuration for editing html/xhtml...
(add-hook 'sgml-mode-hook
	  (lambda ()
	    (yas-reload-all)
	    (yas-minor-mode 1)))

(provide 'init-html)
