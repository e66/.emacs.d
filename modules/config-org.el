;;mobile org
(setq org-mobile-directory "~/mobile-org")
(setq org-mobile-files (list  "~/agenda/gtd.org"))
(setq org-directory "~/agenda")
(setq org-agenda-files (list "~/agenda/gtd.org"))
(setq org-mobile-inbox-for-pull "~/agenda/inbox.org")
(setq org-default-notes-file (concat org-directory "notes.org"))
;; 自己的pc
(defcustom org-mobile-checksum-binary (or (executable-find "~/bin/GnuWin32/bin/md5sum.exe"))
  "Executable used for computing checksums of agenda files."
  :group 'org-mobile
  :type 'string)


;; (defun my-org-mode-config ()
;;   "For use in `org-mode-hook'."
;;   (local-set-key  (kbd "C-c l") 'org-store-link)
;;   (local-set-key  (kbd "C-c a") 'org-agenda) 
;;   ;; (local-set-key  (kbd "C-c c") 'org-capture) 
;;   )
;; ;; add to hook
;; (add-hook 'org-mode-hook 'my-org-mode-config)
;;org-key settings
;; (global-set-key "\C-c \C-l" 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;;神奇的org-mode
(setq org-startup-indented t)
(setq org-todo-keywords
      '((sequence "TODO" "DONE")))


(setq calendar-latitude 40.2)
(setq calendar-longitude 116.2)
(setq calendar-location-name "Beijing, Changping")



;; Auto-export org files to html when saved 
;; (defun org-mode-export-hook()
;;   "Auto export html"
;;   (when (eq major-mode 'org-mode)
;;     (org-export-as-html t)))

;; (add-hook 'after-save-hook 'org-mode-export-hook)

;;UTF8
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(provide 'config-org)





