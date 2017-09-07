(use-package matlab
  ;; :ensure t
  :config
  (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
  (add-to-list 'auto-mode-alist
               '("\\.m$" . matlab-mode))
  (setq matlab-indent-function t)
  (setq matlab-shell-command "matlab")
  (setq matlab-verify-on-save-flag nil)    ; turn off auto-verify on save
  (defun my-matlab-mode-hook ()
    (setq fill-column 76)
    (imenu-add-to-menubar "Find"))        ; where auto-fill should wrap
  (add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
  )

(provide 'config-matlab)
