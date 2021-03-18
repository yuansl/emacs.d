(use-package lsp-mode
  :config
  (add-hook 'go-mode-hook #'lsp-deferred))

(use-package flycheck
  :config
  (add-hook 'go-mode-hook #'flycheck-mode))

(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(add-hook 'go-mode-hook (lambda ()
			  (lsp-ui-mode)
			  (go-imenu-setup)
			  (subword-mode)
			  (setq gofmt-command "goimports")
			  (add-hook 'before-save-hook 'gofmt-before-save)
			  (if (not (string-match "go" compile-command))
			      (set (make-local-variable 'compile-command)
				   "go vet && go test -v"))
			  (define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
			  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)))

(provide 'init-go)
