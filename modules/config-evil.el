(use-package evil-leader
  :ensure t
  :defer t
  :init
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  )

(use-package evil
  :ensure t
  :defer t
  :init
  (evil-mode 1)
  )

(use-package evil-escape
  :ensure t
  :defer t
  :init
  (evil-escape-mode)
  (setq-default evil-escape-delay 0.3)
  )

(use-package evil-surround
  :ensure t
  :defer t
  :init
  (global-evil-surround-mode 1)
    )

(provide 'config-evil)





