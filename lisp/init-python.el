(set-default 'python-shell-interpreter "python3")

(require 'company-jedi)
(add-to-list 'company-backends '(company-jedi company-files))
(add-hook 'python-mode-hook (lambda ()
			      (setq jedi:environment-virtualenv
				    (append python-environment-virtualenv
					    '("--python" "python3")))
			      (setq jedi:use-shortcuts t) ; use key-binding 'M-.' and 'M-,'
			      (jedi:setup)))
(provide 'init-python)
