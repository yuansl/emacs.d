(require 'company-jedi)
(add-to-list 'company-backends '(company-jedi company-files))
(set-default 'python-shell-interpreter "python3")
(add-hook 'python-mode-hook (lambda ()
			      (setq jedi:environment-virtualenv
				    (append python-environment-virtualenv
					    '("--python" "/usr/bin/python3")))
			      (setq jedi:use-shortcuts t)
			      (local-set-key (kbd "M-.") 'jedi:goto-definition)
			      (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
			      (jedi:setup)))
(provide 'init-python)
