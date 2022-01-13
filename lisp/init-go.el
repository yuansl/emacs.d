(use-package flycheck
  :config
  (add-hook 'go-mode-hook #'flycheck-mode))

(add-hook 'go-mode-hook (lambda ()
			  (subword-mode)
			  (setq gofmt-command "goimports")
			  (add-hook 'before-save-hook 'gofmt-before-save nil t)
			  (if (not (string-match "go" compile-command))
			      (set (make-local-variable 'compile-command)
				   "go vet && go test -v"))))

(provide 'init-go)
