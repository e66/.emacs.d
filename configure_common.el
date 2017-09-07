;;Linux kernel stytle
;; (defun c-lineup-arglist-tabs-only (ignored)
;;   "Line up argument lists by tabs, not spaces"
;;   (let* ((anchor (c-langelem-pos c-syntactic-element))
;;       (column (c-langelem-2nd-pos c-syntactic-element))
;;       (offset (- (1+ column) anchor))
;;       (steps (floor offset c-basic-offset)))
;;  (* (max steps 1)
;;     c-basic-offset)))

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             ;; Add kernel style
;;             (c-add-style
;;              "linux-tabs-only"
;;              '("linux" (c-offsets-alist
;;                         (arglist-cont-nonempty
;;                          c-lineup-gcc-asm-reg
;;                          c-lineup-arglist-tabs-only))))))
4
;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (let ((filename (buffer-file-name)))
;;               ;; Enable kernel mode for the appropriate files
;;               (when (and filename
;;                          (string-match (expand-file-name "~/src/linux-trees")
;;                                        filename))
;;                 (setq c-basic-offset 4
;;                                        indent-tabs-mode t
;;                                        default-tab-width 4)
;;                 (setq show-trailing-whitespace t)
;;                 (c-set-style "linux-tabs-only")))))

;; (require 'init-smex)
;; (require 'init-whitespace)


;; 浏览大的代码文件时，禁止更新 以后做更改添加对Linux内核的识别
;; (setq cscope-do-not-update-database t)
