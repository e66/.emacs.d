;;调用git bash 实现shell功能
(setq explicit-shell-file-name  
      "D:/Program Files/Git/bin/sh.exe")  
(setq shell-file-name explicit-shell-file-name)  
(add-to-list 'exec-path "D:/Program Files/Git/bin")

(add-to-list 'exec-path "D:/program files/emacs/bin/find_grep_xargs")

(use-package magit-popup
  :ensure t
  :defer t
  )

(use-package with-editor
  :ensure t
  :defer t
  )

(use-package git-commit
  :ensure t
  :defer t
  )

(use-package magit
  :ensure t
  :defer t  
  :bind(
        ("C-x g" . magit-status)
        )
  )


(provide 'config-magit)
