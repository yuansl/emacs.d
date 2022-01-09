;; rust mode support
;; ```
;; snap install rustup
;; rustup install stable
;; rustup default stable
;; rustup component add rls rust-src rust-analysis
;; ```
(use-package lsp-ui
  :config
  (add-hook 'rust-mode-hook (lambda()
			    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))))

(use-package lsp-mode
  :config
  (add-hook 'rust-mode-hook #'lsp-deferred))

(provide 'init-rust)
