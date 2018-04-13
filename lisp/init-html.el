;; configuration for editing html/xhtml...
(add-hook 'sgml-mode-hook
	  (lambda ()
	    (yas-reload-all)
	    (yas-minor-mode 1)))
(mmm-add-mode-ext-class 'html-mode nil 'html-js)
(mmm-add-mode-ext-class 'html-mode nil 'html-php)
(mmm-add-mode-ext-class 'html-mode nil 'html-css)
(mmm-add-mode-ext-class 'html-mode nil 'sgml-dtd)
(mmm-add-mode-ext-class 'html-mode nil 'jsp)

(provide 'init-html)
