(set-default 'python-shell-interpreter "python3")

(require 'company-jedi)
(add-to-list 'company-backends '(company-jedi))
(add-hook 'python-mode-hook (lambda ()
			      (setq jedi:use-shortcuts t); use key-binding 'M-.' and 'M-,'
			      (setq jedi:environment-virtualenv
				    (append python-environment-virtualenv
					    '("--python" "python3")))
			      (jedi:setup)))
(provide 'init-python)
