;;设置粘贴复制缓冲条目数
(setq kill-ring-max 200)
;;鼠标避让
(mouse-avoidance-mode 'animate)
;;光标始终保持在行尾
(setq track-eol t)
;;删除整行
(setq-default kill-whole-line t)
;;鼠标中键粘贴
(setq mouse-yank-at-point t)
;;跳转到上一个buffer，或下一个buffer
(global-set-key (kbd "C-7") 'switch-to-prev-buffer)
(global-set-key (kbd "C-8") 'switch-to-next-buffer)
;;bookmark
(global-set-key (kbd "C--") 'bookmark-set)
(global-set-key (kbd "C-=") 'bookmark-jump)
;; 重新设置C-x s为保存所有的缓冲区
(defun save-all () (interactive) (save-some-buffers t))
(global-set-key (kbd "C-x s") 'save-all)
;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)
(windmove-default-keybindings)
(global-set-key (kbd "C-,") 'hide/show-comments-toggle)
;; 在有yes-or-no选项时，y代表yes，n代表n
(fset 'yes-or-no-p 'y-or-n-p)
;; 结尾换行自动插入新行
(setq next-line-add-newlines t)
;; 高亮括号匹配
(setq show-paren-style 'parenthesis)
;; 设置为80列
(setq-default fill-column 80)
(add-to-list 'default-frame-alist '(height . 28))
(add-to-list 'default-frame-alist '(width . 100))
;;关闭启动画面、菜单、工具条
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

(defun emacs-maximize ()    
  "Maximize emacs window in windows os"    
  (interactive)    
  (w32-send-sys-command 61488))        ; WM_SYSCOMMAND #xf030 maximize

(defun emacs-normal ()    
  "Normal emacs window in windows os"    
  (interactive)    
  (w32-send-sys-command #xf120))    ; #xf120 normalimize    

(global-set-key (kbd  "C-9") 'emacs-maximize)  
;; (global-set-key (kbd  "C-\") 'emacs-maximize)  

(use-package smartparens 
  :ensure t
  :defer t
  :init
  (add-hook 'c-mode-hook #'smartparens-mode)
  (add-hook 'c++-mode-hook #'smartparens-mode)
  (add-hook 'asm-mode-hook #'smartparens-mode)
  (add-hook 'verilog-mode-hook #'smartparens-mode)
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
  (add-hook 'matlab-mode-hook #'smartparens-mode)
  (add-hook 'org-mode-hook #'smartparens-mode)
  (add-hook 'python-mode-hook #'smartparens-mode)

  )


;;添加 go to char
;;通过这个，我们可以通过 C-t 加上指定字符向后跳，后者 C-u C-t 向前跳。比如C-t w w w w …就一直往后跳到后续的w处。
;; (defun my-go-to-char (n char)
;;   "Move forward to Nth occurence of CHAR.
;; Typing `my-go-to-char-key' again will move forwad to the next Nth
;; occurence of CHAR."
;;   (interactive "p\ncGo to char: ")
;;   (let ((case-fold-search nil))
;;     (if (eq n 1)
;;         (progn                            ; forward
;;           (search-forward (string char) nil nil n)
;;           (backward-char)
;;           (while (equal (read-key)
;;                         char)
;;             (forward-char)
;;             (search-forward (string char) nil nil n)
;;             (backward-char)))
;;       (progn                              ; backward
;;         (search-backward (string char) nil nil )
;;         (while (equal (read-key)
;;                       char)
;;           (search-backward (string char) nil nil )))))
;;   (setq unread-command-events (list last-input-event)))
;; (global-set-key (kbd "C-t") 'my-go-to-char)

;;重新设定标记功能 M-SPC
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "M-SPC") 'set-mark-command)

;;设置光标不闪
(blink-cursor-mode 0)
;; (global-linum-mode t)
;;显示时间
;; (display-time-mode t)
;;显示buffer-size
(size-indication-mode t)
;;高亮当前行
(use-package hl-line
  :ensure t
  :defer t
  :init
  (global-hl-line-mode t)
  )

(column-number-mode t)
;;自动在文件末增加一新行
(setq require-final-newline t)

(global-set-key (kbd "RET") 'newline-and-indent) ;; automatically indent when press RET
;; 打开代码折叠功能
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'verilog-mode-hook 'hs-minor-mode)
(add-hook 'vhdl-mode-hook 'hs-minor-mode)
;;在模式栏中显示当前光标所在的函数
(which-function-mode)
;;实现鼠标选中后直接用新内容替换掉
(delete-selection-mode t)
;;代码折叠展开翻转
(global-set-key (kbd"C-0") 'hs-toggle-hiding)
(global-set-key (kbd"C-'") 'hs-hide-all)
(use-package sr-speedbar
  :ensure t
  :defer t
  :bind(
        ([f7] . sr-speedbar-toggle)
        )
  :config
  (setq speedbar-use-images nil)
  )
;; (use-package auto-save
;;   :defer t
;;   :load-path "~/.emacs.d/elpa/customize"
;;   :init
;;   (auto-save-enable 1)
;;   (setq auto-save-slient t)
;;  )
(add-to-list 'load-path "~/.emacs.d/elpa/goto-chg-20131228.659")
(require 'goto-chg)
(global-set-key (kbd"C-c w") 'goto-last-change)
(global-set-key (kbd"C-c e") 'goto-last-change-reverse)

(add-to-list 'load-path "~/.emacs.d/elpa/customize")
(require 'auto-save)
(auto-save-enable)
(setq auto-ave-slient t)

(use-package highlight-indent-guides
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character) ;column fill character
  (setq highlight-indent-guides-character ?\|)
  ;; (setq highlight-indent-guides-character ':)
  )

(require 'vlf-setup)
(custom-set-variables
 '(vlf-application 'dont-ask))

;; (defun my-find-file-check-make-large-file-read-only-hook ()
;;   "If a file is over a given size, make the buffer read only."
;;   (when (> (buffer-size) (* 1024 1024))
;;     (setq buffer-read-only t)
;;     (buffer-disable-undo)
;;     (fundamental-mode)))

;; (add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)

(provide 'config-general)






