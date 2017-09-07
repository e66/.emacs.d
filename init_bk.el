;; emacs 配置 for myself and windows
;;设置环境变量
(setenv"HOME" "D:/program files/emacs")
(setenv"PATH" "D:/program files/emacs/bin;D:/program files/emacs/UnxUtils/usr/local/wbin;D:/program files/Git/bin;D:/program files/Git/usr/bin;D:/program files/emacs/bin/Gnu_global/bin;D:/program files/LLVM/bin")
(setq default-directory"~/")

;;添加路径
(add-to-list 'load-path "~/share/emacs/site-lisp")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;;添加功能插件
(require 'init-site-lisp)

;; ;;添加Google-c-style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;设置粘贴复制缓冲条目数
(setq kill-ring-max 200)
;;鼠标避让
(mouse-avoidance-mode 'animate)
;;光标始终保持在行尾
(setq track-eol t)
;;鼠标中键粘贴
(setq mouse-yank-at-point t)
;;dash
(add-to-list 'load-path "~/.emacs.d/elpa/dash-20170613.151")
(require 'dash)

;;跳转到上一个buffer，或下一个buffer
(global-set-key (kbd "C-7") 'switch-to-prev-buffer)
(global-set-key (kbd "C-8") 'switch-to-next-buffer)


;;bookmark
(global-set-key (kbd "C-c c") 'bookmark-set)
(global-set-key (kbd "C-c v") 'bookmark-jump)

;;agreesive
(add-to-list 'load-path "~/.emacs.d/elpa/aggressive-indent-20170627.1223")
(require 'aggressive-indent)
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(add-hook 'c-mode-hook #'aggressive-indent-mode)
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;;multi-term
(add-to-list 'load-path "~/.emacs.d/elpa/multi-term-20160619.233")
(require 'multi-term)
;; (setq multi-term-program "~/UnxUtils/usr/local/wbin")

;; pop-tips
(add-to-list 'load-path "~/.emacs.d/elpa/pos-tip-20150318.813")
(require 'pos-tip)

;;缩进4个空格的TAB设置
(defun my-c-mode-hook ()
  (setq c-basic-offset 4          ;; 基本缩进宽度
        indent-tabs-mode nil        ;; 允许空格替换Tab
        default-tab-width 4))     ;; 默认Tab宽度
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)


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

;;auto-newline
(add-hook 'c-mode-common-hook 'my-c-common-mode)  
(defun my-c-common-mode ()  
  ;; 此模式下，当按Backspace时会删除最多的空格  
  (c-toggle-hungry-state))


;; AC 辅助插件 要在AC之前
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/popup-el-master"))

;; ;定义快捷键C-c C-/为注释和取消注释快捷键
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


;; 在有yes-or-no选项时，y代表yes，n代表n
(fset 'yes-or-no-p 'y-or-n-p)

;; 显示行号
;; (global-linum-mode)

;; 结尾换行自动插入新行
(setq next-line-add-newlines t)

;; 高亮括号匹配
(setq show-paren-style 'parenthesis)

;; 设置为80列
;; (setq-default fill-column 80)
;; (add-to-list 'default-frame-alist '(height . 28))
;; (add-to-list 'default-frame-alist '(width . 100))

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

;; (emacs-maximize)    
(global-set-key (kbd  "C-x a") 'emacs-maximize)  



;;加载xcscope
(require 'xcscope)
(add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
(add-hook 'c++-mode-common-hook '(lambda() (require 'xcscope)))


;; 重新设置常用键
(global-set-key (kbd "C-2") 'cscope-find-this-symbol)
(global-set-key (kbd "C-3") 'cscope-find-global-definition)
(global-set-key (kbd "C-4") 'cscope-find-this-file)
(global-set-key (kbd "C-5") 'cscope-pop-mark)

;; 浏览大的代码文件时，禁止更新 以后做更改添加对Linux内核的识别
;; (setq cscope-do-not-update-database t)

;;添加Yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20161110.1226")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        "~/.emacs.d/elpa/yasnippet-20161110.1226/snippets")            ;; personal snippets
      )
(yas-global-mode 1)

;; Dired-Plus
(add-to-list 'load-path "~/.emacs.d/elpa/dired+-20170530.1023")
(require 'dired+)


;; dired
(setq dired-dwim-target t)
;; allow dired to delete or copy dir
(setq dired-recursive-copies (quote always)) ; “always” means no asking
(setq dired-recursive-deletes (quote top)) ; “top” means ask once

;;dired ranger 
(add-to-list 'load-path "~/.emacs.d/elpa/dired-hacks-utils-20160527.1436")
(require 'dired-hacks-utils)
(add-to-list 'load-path "~/.emacs.d/elpa/dired-ranger-20160924.335")
(require 'dired-ranger)
(define-key dired-mode-map (kbd "W") 'dired-ranger-copy)
(define-key dired-mode-map (kbd "X") 'dired-ranger-move) 
(define-key dired-mode-map (kbd "Y") 'dired-ranger-paste) 

;;添加auto-complete功能
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20161029.643")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories " ~/.emacs.d/elpa/auto-complete-20161029.643/dict")
(ac-config-default)
(setq ac-use-quick-help nil)
(setq ac-auto-start 2) ;; 输入2个字符才开始补全
(global-set-key "\M-/" 'auto-complete)  ;; 补全的快捷键，

;;clang
;; (add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-clang-20140409.52")
;; (require 'auto-complete-clang)

;; 添加c-mode和c++-mode的hook，开启auto-complete的clang扩展  
;; (defun wttr/ac-cc-mode-setup ()  
;;  (make-local-variable 'ac-auto-start)  
;;  (setq ac-auto-start nil)              ;auto complete using clang is CPU sensitive  
;; (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
;;(add-hook 'c-mode-hook 'wttr/ac-cc-mode-setup)  
;;(add-hook 'c++-mode-hook 'wttr/ac-cc-mode-setup)

;;(setq ac-clang-flags  (list   
;;                     "-ID:/program files/mingw/include"  
;;                   "-ID:/program files/mingw/lib/gcc/mingw32/4.8.1/include"  
;;                 "-ID:/program files/mingw/lib/gcc/mingw32/4.8.1/include/c++"  
;;               "-ID:/program files/mingw/lib/gcc/mingw32/4.8.1/include/c++"  
;;             "-D__MSVCRT__="))  


;;添加最新的源
(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;;emacs的默认compile命令是调用make -k，我把它改成了make。你也可以把它改成其他的，比如gcc之类的.
(setq compile-command "make")

;;zenburn-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-emacs-master")
(load-theme 'zenburn t)

;;set font family
(set-default-font "-outline-consolas-normal-r-normal-normal-18-97-96-96-c-*-iso8859-1")  ;;此处的18对应font四号


;;cnfonts
(add-to-list 'load-path "~/.emacs.d/elpa/cnfonts-20170731.637")
(require 'cnfonts)
(cnfonts-enable)

;; 重新设置C-x s为保存所有的缓冲区
(defun save-all () (interactive) (save-some-buffers t))
(global-set-key (kbd "C-x s") 'save-all)

;;配置cedet
(require 'cedet)
(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)


;;配置ecb
;; (setq ecb-version-check nil)
;; (add-to-list 'load-path "~/.emacs.d/elpa/ecb-2.40")
;; (require 'ecb)
;; (require 'ecb-autoloads)
;; (setq ecb-tip-of-the-day nil)
;;;一键开关
;; (defun my-ecb-active-or-deactive ()
;; (interactive)
;; (if ecb-minor-mode
;; (ecb-deactivate)
;; (ecb-activate)))
;; (global-set-key (kbd "<f12>") 'my-ecb-active-or-deactive)
;; (setq stack-trace-on-error t)
;; (setq ecb-auto-activate nil)  ;;ecb默认开启
;; (global-set-key (kbd "<f12>") 'ecb-activate)
;; (setq ecb-tip-of-the-day nil)
;; (global-set-key (kbd "<f7>") 'ecb-minor-mode)   ; 打开ecb
;;;;ecb 快捷键
;; (global-set-key (kbd "C-<left>") 'windmove-left)   ;左边窗口
;; (global-set-key (kbd "C-<right>") 'windmove-right)  ;右边窗口
;; (global-set-key (kbd "C-<up>") 'windmove-up)     ; 上边窗口
;; (global-set-key (kbd "C-<down>") 'windmove-down)   ; 下边窗口
;;end ecb

;; senantic
(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)

;;添加company自动补全功能
(add-to-list 'load-path "~/.emacs.d/elpa/company-20161126.1629")
(autoload 'company-mode "company" t)
(add-hook 'after-init-hook #'global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 6)


;; (add-to-list 'load-path "~/.emacs.d/elpa/company-c-headers-20170531.1330")
;; (require 'company-c-headers)
;; (add-to-list 'company-backends 'company-c-headers)     
;; (setq company-backends (delete 'company-semantic company-backends))
;; (define-key c-mode-map (kbd "C-1")'company-complete)
;; (define-key c++-mode-map (kbd "C-1") 'company-complete)
;;mingw
;; (add-to-list 'company-c-headers-path-system 
;; "D:/program files/mingw/include"                           
;; "D:/program files/mingw/lib/gcc/mingw32/4.8.1/include"     
;; "D:/program files/mingw/lib/gcc/mingw32/4.8.1/include/c++" 
;; "D:/program files/mingw/lib/gcc/mingw32/4.8.1/include/c++" )
;;vs
;; (add-to-list 'company-c-headers-path-system "D:/program files/vs2013/VC/include"
;; )
;; (add-to-list 'company-c-headers-path-user 
;; )


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

;; smart complitions
(require 'semantic/ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

;;Semantic DataBase存储位置
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semanticdb"))


;;添加括号补全 smartparents 内部的功能
;; Always start smartparens mode in js-mode.
(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'c++-mode-hook #'smartparens-mode)
(add-hook 'asm-mode-hook #'smartparens-mode)
(add-hook 'verilog-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(add-hook 'matlab-mode-hook #'smartparens-mode)

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

;;expand-region
(add-to-list 'load-path "~/.emacs.d/elpa/expand-region-0.10.0")
(require 'expand-region)

;;快捷键 C-M-h 标记一个函数  往后标记C-M-SPC
(global-set-key (kbd "M-m") 'er/expand-region)
(global-set-key (kbd "M-s s") 'er/mark-word)
(global-set-key (kbd "M-s p") 'er/mark-outside-pairs)
(global-set-key (kbd "M-s P") 'er/mark-inside-pairs)
(global-set-key (kbd "M-s q") 'er/mark-outside-quotes)
(global-set-key (kbd "M-s Q") 'er/mark-inside-quotes)
(global-set-key (kbd "M-s m") 'er/mark-comment)
(global-set-key (kbd "M-s f") 'er/mark-defun)


;;highlight-symbol 再按一次取消
(global-set-key (kbd "M--") 'highlight-symbol-at-point)
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)


;;交换两个buffer C-9
;; (defun transpose-buffers (arg)
;;   "Transpose the buffers shown in two windows."
;;   (interactive "p")
;;   (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
;;     (while (/= arg 0)
;;       (let ((this-win (window-buffer))
;;             (next-win (window-buffer (funcall selector))))
;;         (set-window-buffer (selected-window) next-win)
;;         (set-window-buffer (funcall selector) this-win)
;;         (select-window (funcall selector)))
;;       (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
;; (global-set-key (kbd "C-9") 'transpose-buffers)


;;设置光标不闪
(blink-cursor-mode 0)

;;显示时间
(display-time-mode t)

;;高亮当前行
(require 'hl-line)
(global-hl-line-mode t)

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
(global-set-key [f1] 'hs-toggle-hiding)
(global-set-key [f2] 'hs-hide-all)

;;开启ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;multiple-cursors-mode
(global-set-key (kbd "C-c m c")'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;c# configuration
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;;verilog configuration
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

;; 列操作设置
(cua-selection-mode t)
(setq visible-bell t)
(setq default-fill-column 60)
(setq frame-title-format "emacs@%b")

;;;; User customization for Verilog mode
(setq verilog-indent-level             4
      verilog-indent-level-module      4
      verilog-indent-level-declaration 4
      verilog-indent-level-behavioral  4)

;; 如果文件已发生更改则自动更新
(global-auto-revert-mode t)


;; Matlab mode
(add-to-list 'load-path "~/.emacs.d/elpa/matlab-mode-20160902.459")
(require 'matlab-load)
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list 'auto-mode-alist
             '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")
(setq matlab-verify-on-save-flag nil)    ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
  (setq fill-column 76)
  (imenu-add-to-menubar "Find"))        ; where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)


;; ivy-mode
(add-to-list 'load-path "~/.emacs.d/elpa/ivy-20161129.516")
(require 'ivy)
(ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)

;; whitespace
;; (setq-default show-trailing-whitespace t)
(require 'whitespace)
(autoload 'whitespace-mode   "whitespace" "Toggle whitespace visualization."        t)


;;vhdl-capf
(add-to-list 'load-path "~/.emacs.d/elpa/vhdl-capf-20160221.934")
(when (require 'vhdl-capf)
  (vhdl-capf-enable))


;; iedit
(add-to-list 'load-path "~/.emacs.d/elpa/iedit-20161030.1920")
(require 'iedit)

;;async
(add-to-list 'load-path "~/.emacs.d/elpa/async-20170610.2241")
(require 'async)

;; helm 2017保留
;; (add-to-list 'load-path "~/.emacs.d/elpa/helm-core-20170621.828")
;; (add-to-list 'load-path "~/.emacs.d/elpa/helm-20170622.126")
;; (require 'helm)
;; (require 'helm-config)
;; (helm-mode 1)
(add-to-list 'load-path "~/.emacs.d/elpa/helm-core-20160303.1321")
(require 'helm-config)
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-c") 'helm-find-files-copy)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

(setq helm-split-window-in-side-p           t
      helm-buffers-fuzzy-matching           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-ff-file-name-history-use-recentf t)
(setq helm-chrome-use-urls t)

;;工程管理 projectile
(add-to-list 'load-path "~/.emacs.d/elpa/projectile-20170416.148")
(require 'projectile)
(add-to-list 'load-path "~/.emacs.d/elpa/helm-projectile-20170613.14")
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)

;;gtags
(add-to-list 'load-path "~/bin/Gnu_global/share/gtags")
(require 'gtags)

;;helm-gtags
(add-to-list 'load-path "~/.emacs.d/elpa/helm-gtags-20170115.2129")
(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-j") 'helm-gtags-select)
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "C-c r") 'helm-gtags-pop-stack)
     (define-key helm-gtags-mode-map (kbd "C-c q") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "C-c w") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "C-c e") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "C-c a") 'helm-gtags-find-files)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)))

;;helm-swoop
(add-to-list 'load-path "~/.emacs.d/elpa/helm-swoop-20160619.953")
(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
(setq helm-multi-swoop-edit-save t)
(setq helm-swoop-use-line-number-face t)


;; VI-mode evil  有空再弄它  leader key 功能很有趣
;; (add-to-list 'load-path "~/.emacs.d/elpa/evil-20170419.37")
;; (require 'evil)
;; (set evil-default-state 'emacs)
;; (evil-mode 1)
;; 默认是emacs模式

;;mobile org
(setq org-mobile-directory "~/mobile-org")
(setq org-mobile-files (list "~/pc_org/数字设计.org" "~/pc_org/面试.org" "~/pc_org/my_target.org"))
(setq org-directory "~/pc_org")
(setq org-mobile-inbox-for-pull "~/pc_org/inbox.org")

;; 自己的pc
(defcustom org-mobile-checksum-binary (or (executable-find "~/bin/GnuWin32/bin/md5sum.exe"))
  "Executable used for computing checksums of agenda files."
  :group 'org-mobile
  :type 'string)

;; 公司的pc
;; (defcustom org-mobile-checksum-binary (or (executable-find "~/bin/md5sum.exe"))
;; "Executable used for computing checksums of agenda files."
;; :group 'org-mobile
;; :type 'string)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; speedbar
(add-to-list 'load-path "~/.emacs.d/elpa/sr-speedbar-20161025.131")
(require 'sr-speedbar)
(global-set-key [f7] 'sr-speedbar-toggle)
(setq speedbar-use-images nil)
;; (with-current-buffer sr-speedbar-buffer-name
;; (setq window-size-fixed 'width))
;; (add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用

;;神奇的org-mode
(setq org-startup-indented t)
(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))


;; (require 'tex)
;; (TeX-global-PDF-mode t)


;;调用git bash 实现shell功能
(setq explicit-shell-file-name  
      "D:/Program Files/Git/bin/sh.exe")  
(setq shell-file-name explicit-shell-file-name)  
(add-to-list 'exec-path "D:/Program Files/Git/bin")

(add-to-list 'exec-path "D:/program files/emacs/bin/find_grep_xargs")

(add-to-list 'load-path "~/.emacs.d/elpa/magit-popup-20170609.2310")
(require 'magit-popup)

;; with-editor
(add-to-list 'load-path "~/.emacs.d/elpa/with-editor-20170517.1242")
(require 'with-editor)
;;git commit
(add-to-list 'load-path "~/.emacs.d/elpa/git-commit-20170609.2310")
(require 'git-commit)

;;magit 
(add-to-list 'load-path "~/.emacs.d/elpa/magit-20170723.1326")
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;;ac-clang
;; (add-to-list 'load-path "~/.emacs.d/elpa/ac-clang-20170615.838")
;; (require 'ac-clang)
;; (setq w32-pipe-read-delay 0)          ;; <- Windows Only
;; (when (ac-clang-initialize)
;; (add-hook 'c-mode-common-hook '(lambda ()
;; (setq ac-clang-cflags CFLAGS)
;; (ac-clang-activate-after-modify))))

;; (ac-clang-activate)

;;function-args-mode
;; (add-to-list 'load-path "~/.emacs.d/function-args-20170303.515")
;; (require 'function-args)
;; (fa-config-default)


;;helm-cscope 
;; (add-to-list 'load-path "~/.emacs.d/elpa/helm-cscope-20170326.22")
;; (require 'helm-cscope)


;; (add-hook 'c-mode-common-hook 'helm-cscope-mode)
;; (eval-after-load "helm-cscope"
;;   '(progn
;;      (define-key helm-cscope-mode-map (kbd "C-2") 'helm-cscope-find-global-definition)
;;      (define-key helm-cscope-mode-map (kbd "C-3") 'helm-cscope-find-calling-this-function)
;;      (define-key helm-cscope-mode-map (kbd "C-4") 'helm-cscope-find-this-symbol)
;;      (define-key helm-cscope-mode-map (kbd "C-5") 'helm-cscope-pop-mark)))

;;helm-do-ag
(add-to-list 'load-path "~/.emacs.d/elpa/helm-ag-20170209.745")
(require 'helm-ag)

(global-set-key (kbd "C-x a") 'helm-do-ag)


;;auto save

(add-to-list 'load-path "~/.emacs.d/elpa/autosave")
(require 'auto-save)
(auto-save-enable)
(setq auto-save-slient t)
;; special configure
;;添加window-numbering,winner-mode 不能再ECB中使用故将其放在最后
(add-to-list 'load-path "~/.emacs.d/elpa/window-numbering-20150228.1247")
(require 'window-numbering)
(window-numbering-mode 1)
(winner-mode 1)
(global-set-key (kbd "C-x 4 u") 'winner-undo)
(global-set-key (kbd "C-x 4 r") 'winner-redo)





