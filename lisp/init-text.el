;; configuration for editing html/xhtml...

(add-hook 'text-mode-hook
	  (lambda ()
	    (setq fill-column 80)
	    (auto-fill-mode)
	    (setq bidi-display-reordering nil)
	    (setq line-move-visual nil)))

(provide 'init-text)
