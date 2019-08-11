(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)
         ("\\.spec.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :config
  (setq-default tab-width 2)
  (setq-default js2-basic-offset 2)

  (setq-default js2-mode-indent-ignore-first-tab t)
  (setq-default js2-show-parse-errors nil)
  (setq-default js2-strict-inconsistent-return-warning nil)
  (setq-default js2-strict-var-hides-function-arg-warning nil)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-strict-trailing-comma-warning nil)
  (setq-default js2-strict-cond-assign-warning nil)
  (setq-default js2-strict-var-redeclaration-warning nil)

  (sp-with-modes '(js2-mode js2-jsx-mode)
    (sp-local-pair "<" ">")))

(use-package add-node-modules-path
  :hook ((js2-mode-hook . add-node-modules-path) (prettier-js-mode-hook .add-node-modules-path)))

(use-package prettier-js
  :demand t
  :after js2-mode
  :config
  (setq prettier-js-args '(
                           "--trailing-comma" "all"
                           "--bracket-spacing" "true"
                           "--jsx-bracket-same-line" "false"
                           "--single-quote" "true"
                           "--print-width" "100"
                           ))
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'json-mode-hook 'prettier-js-mode))

(provide 'config-js)
