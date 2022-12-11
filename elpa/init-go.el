(add-hook 'go-mode-hook (lambda ()
			  (subword-mode)
			  (setq gofmt-command "goimports")
			  (add-hook 'before-save-hook 'gofmt-before-save nil t)
			  (if (not (string-match "go" compile-command))
			      (set (make-local-variable 'compile-command)
				   "go vet && go test -v -failfast"))))

(use-package lsp-ui
  :init
  (setq lsp-ui-doc-enable nil)
  :config
  (add-hook 'go-mode-hook
	    (lambda ()
	      (flymake-mode)
	      (define-key lsp-ui-mode-map
			  [remap xref-find-references] #'lsp-ui-peek-find-references)
	      (define-key lsp-ui-mode-map (kbd "M-/") #'lsp-ui-peek-find-implementation))))

(use-package lsp-mode
  :config
  (add-hook 'go-mode-hook #'lsp-deferred))

(provide 'init-go)
