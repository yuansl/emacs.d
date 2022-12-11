;; need python-lsp-server package
;; run: sudo snap install pylsp
(provide 'init-python)

(add-hook 'python-mode-hook #'eglot-ensure)
