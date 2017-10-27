;; emacs 配置 for myself and windows
;;设置环境变量
(setenv"HOME" "D:/program files/emacs")

(setenv"ARTISTIC_STYLE_OPTIONS" "D:/program files/emacs/bin/AStyle/astylerc.opt")

(setenv"PATH" "D:/program files/emacs/bin;D:/program files/emacs/UnxUtils/usr/local/wbin;D:/program files/Git/bin;D:/program files/Git/usr/bin;D:/program files/emacs/bin/Gnu_global/bin;D:/program files/LLVM/bin;D:/program files/emacs/bin/graphviz/bin;D:/program files/emacs/bin/AStyle/bin")
(setq default-directory"~/")


;;添加最新的源
(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(require 'config-general)
(require 'config-theme)
;; (require 'config-evil)
(require 'config-rely)
(require 'config-edit)

(require 'config-cedet-semantic)
(require 'config-auto-complete)
;; (require 'config-company)
(require 'config-helm)
(require 'config-c)
(require 'config-hdl)
(require 'config-magit)
(require 'config-org)
;; (require 'config-matlab)



