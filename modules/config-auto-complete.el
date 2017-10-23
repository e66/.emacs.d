(use-package popup
  :defer t
  :ensure t
  )


(defun my-verilog-mode-hook ()
  (
   (ac-config-default)
   (setq ac-use-quick-help nil)
   (setq auto-start 2) ;; 输入2个字符才开始补全
   )
  )


;; (use-package auto-complete-c-headers
;;   :ensure t
;;   :defer t
;;   :init
;;   (add-hook 'c-mode-hook
;;             (lambda ()
;;               (add-to-list 'ac-sources 'ac-source-c-headers)
;;               (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))
;;   )

;; (add-hook 'c-mode-hook
;;        (lambda ()
;;          (add-to-list 'ac-sources 'ac-source-c-headers)
;;          (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))

(use-package auto-complete
  :ensure t
  :defer t
  :init
  (require 'auto-complete-config)
  (ac-config-default)
  (setq ac-use-quick-help nil)
  (setq auto-start 2) ;; 输入2个字符才开始补全
  ;; (add-hook 'c-mode-common-hook (lambda() (require 'auto-complete-config)))
  ;; (add-hook 'verilog-mode-hook (lambda() (require 'auto-complete-config)))
  ;; (add-hook 'verilog-mode-hook 'my-verilog-mode-hook)
  ;; (require 'auto-complete-config)
  ;; (add-to-list 'ac-dictionary-directories " ~/.emacs.d/elpa/auto-complete-20161029.643/dict")
  ;; (global-set-key "\M-/" 'auto-complete) ) ;; 补全的快捷键
  )

(provide 'config-auto-complete)


