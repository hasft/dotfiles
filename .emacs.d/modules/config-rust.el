(use-package rust-mode
  :defer t
  :init
  (require 'rust-mode)
  (global-company-mode)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

  :config
  (use-package company-racer)
  (use-package flycheck-rust)
  (use-package racer
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)

  (add-hook 'racer-mode-hook #'company-mode)

  (require 'rust-mode)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t))
)

(provide 'config-rust)
