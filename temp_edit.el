(use-package projectile
  :ensure t
  :defer t
  :bind (
         ("M-s" . projectile-ripgrep)
         )
  :init
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'alien)
  )


test0 
