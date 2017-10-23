(require 'cedet)
(require 'semantic/ia)
(require 'semantic/analyze)
(require 'semantic)
(global-semantic-idle-scheduler-mode 1)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(semantic-mode 1)


(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-summary-mode 1)

;;Semantic DataBase存储位置
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semanticdb"))

(provide 'config-cedet-semantic)




