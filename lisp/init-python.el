;; need python-lsp-server package
;; run: sudo snap install pylsp
(provide 'init-python)

(use-package lsp-mode
  :config
  (add-hook 'python-mode-hook #'lsp-deferred))
