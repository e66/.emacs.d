;;org 设置
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

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


;;神奇的org-mode
(setq org-startup-indented t)
(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

(provide 'config-org)



