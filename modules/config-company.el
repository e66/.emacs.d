;; (use-package company-c-headers
;;   :ensure t
;;   :defer t
;;   :init
;;   (add-to-list 'company-backends 'company-c-headers))

(use-package company
  :ensure t
  :defer t
  :init
  (autoload 'company-mode "company" t)
  (add-hook 'after-init-hook #'global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  )


(provide 'config-company)









