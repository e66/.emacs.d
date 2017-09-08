;;保存的时候进行untabify，将TAB改为相应的空格数
(defvar untabify-this-buffer)
(defun untabify-all ()
  "Untabify the current buffer, unless `untabify-this-buffer' is nil."
  (and untabify-this-buffer (untabify (point-min) (point-max))))
(define-minor-mode untabify-mode
  "Untabify buffer on save." nil " untab" nil
  (make-variable-buffer-local 'untabify-this-buffer)
  (setq untabify-this-buffer (not (derived-mode-p 'makefile-mode)))
  (add-hook 'before-save-hook #'untabify-all))
(add-hook 'prog-mode-hook 'untabify-mode)

;;agreesive
(use-package aggressive-indent
  :ensure t
  :defer t
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'css-mode-hook #'aggressive-indent-mode)
  (add-hook 'c-mode-hook #'aggressive-indent-mode)
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

;;定义快捷键C-c C-/为注释和取消注释快捷键
(global-set-key [?\C-c ?\C-/] 'comment-or-uncomment-region)
;; ;如果选中多行则注释/反注释选中行，如果什么都没有选中，则针对当前光标所在行进行操作
(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg)
  )
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)

;;添加Yasnippet
(use-package yasnippet
  :defer t
  :init
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"
          "~/.emacs.d/elpa/yasnippet-20161110.1226/snippets")            ;; personal snippets
        )
  (yas-global-mode 1))

;;dired+
;; (use-package dired+
  ;; :defer t
  ;; :ensure t)

;; dired
(setq dired-dwim-target t)
;; allow dired to delete or copy dir
(setq dired-recursive-copies (quote always)) ; “always” means no asking
(setq dired-recursive-deletes (quote top)) ; “top” means ask once
(use-package dired-hacks-utils
  :ensure t
  )
;;dired-ranger
(use-package dired-ranger
  :ensure t
  :defer t
  :init
  (define-key dired-mode-map (kbd "z") 'dired-ranger-copy)
  (define-key dired-mode-map (kbd "W") 'dired-ranger-move) 
  (define-key dired-mode-map (kbd "Z") 'dired-ranger-paste) 
  )
;;multi-term
(use-package multi-term
  :ensure t
  :defer t
  )

;;emacs的默认compile命令是调用make -k，我把它改成了make。你也可以把它改成其他的，比如gcc之类的.
(setq compile-command "make")


;;打开多个shell窗口
(defun wcy-shell-mode-auto-rename-buffer (text)
  (if (eq major-mode 'shell-mode)
      (rename-buffer  (concat "shell:" default-directory) t)))
(add-hook 'comint-output-filter-functions'wcy-shell-mode-auto-rename-buffer)

;;按 C-M-n 可以连续下跳 5 行，按 C-M-p 可以连续上跳 5 行：
(global-set-key (kbd "C-M-n")
                (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "C-M-p")
                (lambda () (interactive) (previous-line 5)))

;;使用 C-w 来删除整行（操作时不用事先选中整行），同时不影响原有的剪切功能。M-w 也可以在不;;事先选中整行的情况下复制整行。
(defadvice kill-ring-save (before slickcopy activate compile)
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))


;;一边写代码一边看参照其他文档时。按 F11 键可以一键切换透明度，非常方便：
;;set transparent effect
(global-set-key [(f11)] 'loop-alpha)
                                        ;(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
(setq alpha-list '((110 110) (65 35)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
  )

;;根据菜单进行的自定义设置
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 ;; '(menu-bar-mode nil)
 '(show-paren-mode t)
 ;; ;;helper tools
 ;; '(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-idle-completions-mode
 ;;                                      global-semantic-idle-scheduler-mode global-semanticdb-minor-mode
 ;;                                      global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 ;; '(semantic-idle-scheduler-idle-time 3)
 )

(electric-layout-mode t)


;;expand-region
(use-package expand-region
  ;; :ensure t
  :defer t
  :bind(
        ("M-m" . er/expand-region)        
        ("M-s s" . er/mark-word)          
        ("M-s p" . er/mark-outside-pairs)         
        ("M-s P" . er/mark-inside-pairs)  
        ("M-s q" . er/mark-outside-quotes)  
        ("M-s Q" . er/mark-inside-quotes) 
        ("M-s m" . er/mark-comment)       ;;快捷键 C-M-h 标记一个函数  往后标记C-M-SPC
        ("M-s f" . er/mark-defun)
        )
  )
 ;;highlight-symbol 再按一次取消
(global-set-key (kbd "M--") 'highlight-symbol-at-point)
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)

;;开启ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;multiple-cursors-mode
(global-set-key (kbd "C-c m c")'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)



;;cua-mode
(cua-selection-mode t)
(setq visible-bell t)
(setq default-fill-column 60)
(setq frame-title-format "emacs@%b")

;; 如果文件已发生更改则自动更新
(global-auto-revert-mode t)

;;ivy
(use-package ivy
  :disabled
  :ensure t
  :defer t
  :config
  (ivy-mode 1)
  )

(use-package whitespace
  :ensure t
  :defer t
  :init
  (autoload 'whitespace-mode   "whitespace" "Toggle whitespace visualization."        t)
  )

(use-package iedit
  :ensure t
  :defer t
  )


(provide 'config-edit)


