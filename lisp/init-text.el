;; configuration for editing html/xhtml...
(add-hook 'sgml-mode-hook
	  (lambda ()
	    (yas-reload-all)
	    (yas-minor-mode 1)))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(add-hook 'text-mode-hook
	  (lambda ()
	    (setq fill-column 80)
	    (auto-fill-mode)
	    (setq bidi-display-reordering nil)
	    (setq line-move-visual nil)))

(defun --set-emoji-font nil
  "Adjust the font settings of FRAME so Emacs can display emoji properly."
  (if (eq system-type 'darwin)
      ;; For NS/Cocoa
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend)
    ;; For Linux
    (set-fontset-font t 'symbol (font-spec :family "Symbola") nil 'prepend)))

(add-hook 'after-init-hook '--set-emoji-font)

(provide 'init-text)
