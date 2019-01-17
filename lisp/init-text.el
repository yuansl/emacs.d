;; configuration for editing html/xhtml...
(add-hook 'sgml-mode-hook
	  (lambda ()
	    (yas-reload-all)
	    (yas-minor-mode 1)))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(add-hook 'text-mode-hook
	  (lambda ()
	    (setq fill-column 80)
	    (auto-fill-mode)
	    (setq bidi-display-reordering nil)
	    (setq line-move-visual nil)))

(provide 'init-text)
