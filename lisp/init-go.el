(add-hook 'go-mode-hook #'lsp-deferred)

(add-hook 'go-mode-hook (lambda ()
			  (subword-mode)
			  (setq gofmt-command "goimports")
			  (add-hook 'before-save-hook 'gofmt-before-save)
			  (if (not (string-match "go" compile-command))
			      (set (make-local-variable 'compile-command)
				   "go vet && go test -v"))
			  (local-set-key (kbd "M-.") 'godef-jump)))

(provide 'init-go)
