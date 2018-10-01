(require 'company-jedi)
(add-to-list 'company-backends '(company-jedi company-files))
(set-default 'python-shell-interpreter "python3")
(add-hook 'python-mode-hook (lambda ()
			      (setq jedi:environment-root "python3jedi")
			      (setq jedi:environment-virtualenv
				    (append python-environment-virtualenv
					    '("--python" "/usr/local/bin/python3")))
			      (setq jedi:use-shortcuts t)
			      ;; (local-unset-key (kbd "M-."))
			      ;; (local-set-key (kbd "M-.") 'jedi:goto-definition)
			      ;; (local-unset-key (kbd "M-,"))
			      ;; (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
			      ;; (setq python-environment-virtualenv
			      ;; 	    (append python-environment-virtualenv
			      ;; 		    '("-p" "/usr/local/bin/python3")))
			      (jedi:setup)))
(provide 'init-python)
