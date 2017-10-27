;;缩进4个空格的TAB设置
(defun my-c-mode-hook ()
  (setq c-basic-offset 4          ;; 基本缩进宽度
        indent-tabs-mode nil        ;; 允许空格替换Tab
        default-tab-width 4))     ;; 默认Tab宽度
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

;;auto-newline
(add-hook 'c-mode-common-hook 'my-c-common-mode)  
(defun my-c-common-mode ()  
  ;; 此模式下，当按Backspace时会删除最多的空格  
  (c-toggle-hungry-state))

;;加载xcscope
(use-package xcscope
  :ensure t
  :defer t
  :bind (
         ("C-2" . cscope-find-this-symbol)       
         ("C-3" . cscope-find-global-definition) 
         ("C-4" . cscope-find-this-file)         
         ("C-5" . cscope-pop-mark)
         )
  :init
  (add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
  (add-hook 'c++-mode-common-hook '(lambda() (require 'xcscope)))
  )

;; 浏览大的代码文件时，禁止更新 以后做更改添加对Linux内核的识别
;; (setq cscope-do-not-update-database t)

;; ;;添加Google-c-style
(use-package google-c-style
  :ensure t
  :defer t
  :init
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  )

;;style google linux allman
(let ((style "allman"))
  (setq format-command (format "astyle --style=%s -S -p -F -xg -xe -n" style)))

(defun format-code ()
  "Format current buffer"
  (interactive)
  (let ((file (buffer-file-name)))
    (save-excursion
      (shell-command-to-string (format "%s %s" format-command file))
      (message "Code formatted"))))

(global-set-key (kbd"C-c q") 'format-code)

(provide 'config-c)






