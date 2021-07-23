(set-default 'python-shell-interpreter "python3")
;; need python-lsp-server package
;; run: sudo pip install python-lsp-server
(add-hook 'python-mode-hook #'lsp)
(provide 'init-python)
