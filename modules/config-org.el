;;mobile org
(setq org-mobile-directory "~/mobile-org")
(setq org-mobile-files (list "~/pc_org/数字设计.org" "~/pc_org/面试.org" "~/pc_org/my_target.org" "~/pc_org/gtd.org"))
(setq org-directory "~/pc_org")
(setq org-agenda-files "~/pc_org/gtd.org")
(setq org-mobile-inbox-for-pull "~/pc_org/inbox.org")
(setq org-default-notes-file (concat org-directory "notes.org"))
;; 自己的pc
(defcustom org-mobile-checksum-binary (or (executable-find "~/bin/GnuWin32/bin/md5sum.exe"))
  "Executable used for computing checksums of agenda files."
  :group 'org-mobile
  :type 'string)


(defun my-org-mode-config ()
  "For use in `org-mode-hook'."
  (local-set-key  (kbd "C-c l") 'org-store-link)
  (local-set-key  (kbd "C-c a") 'org-agenda) 
  ;; (local-set-key  (kbd "C-c c") 'org-capture) 
  )
;; add to hook
(add-hook 'org-mode-hook 'my-org-mode-config)
;;org-key settings
;; (global-set-key "\C-c \C-l" 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;; (global-set-key "\C-c \C-b" 'org-iswitchb)

;;神奇的org-mode
(setq org-startup-indented t)
(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

;;UTF8
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(provide 'config-org)





