(set-default 'python-shell-interpreter "python3")
;; need python-lsp-server package
;; run: sudo snap install pylsp
(add-hook 'python-mode-hook #'lsp-deferred)
(provide 'init-python)
