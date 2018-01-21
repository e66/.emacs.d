;; emacs 配置 for myself and windows
;;设置环境变量
(cond((equal system-type 'windows-nt)
      (setenv"HOME" "D:/program files/emacs")
      (setenv"ARTISTIC_STYLE_OPTIONS" "D:/program files/emacs/bin/AStyle/astylerc.opt")
      (setenv"PATH" "D:/program files/emacs/bin;D:/program files/emacs/UnxUtils/usr/local/wbin;D:/program files/Git/bin;D:/program files/Git/usr/bin;D:/program files/emacs/bin/Gnu_global/bin;D:/program files/LLVM/bin;D:/program files/emacs/bin/graphviz/bin;D:/program files/emacs/bin/AStyle/bin;D:/Program Files/python;D:/Program Files/python/Scripts;c:/Windows/System32")
      (setq default-directory "~/")
      ))

;;添加最新的源
(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

 (package-initialize)

 (when (not package-archive-contents)
   (package-refresh-contents))

 (unless (package-installed-p 'use-package)
   (package-install 'use-package))
(add-to-list 'load-path "~/.emacs.d/elpa/use-package-20170812.2256")


(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(require 'config-theme)
(require 'config-general)
(require 'config-edit)
;; (require 'config-evil)
(require 'config-rely)
;; (require 'config-cedet-semantic)
(require 'config-auto-complete)
;; (require 'config-company)
(require 'config-helm)
(require 'config-c)
(require 'config-hdl)
(require 'config-magit)
(require 'config-org)

;; (load 'auctex.el' nil t t)
;; (load 'preview-latex.el' nil t t)

(cond((equal system-type 'gnu/linux)
      (add-to-list 'load-path "~/.emacs.d/elpa/auctex")

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq preview-scale-function 1.3)
(setq LaTeX-math-menu-unicode t)
(setq TeX-insert-braces nil)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(require 'tex-mik)
))



;; (require 'config-matlab)
;; (global-font-lock-mode -1)
;; (setq jit-lock-defer-time 0.05)
;; (desktop-save-mode t)



