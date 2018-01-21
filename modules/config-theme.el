(use-package zenburn-theme
  :defer t
  :init
  (load-theme 'zenburn t)
  )

(cond((equal system-type 'windows-nt)
      ;;set font family
      (set-default-font "-outline-consolas-normal-r-normal-normal-18-97-96-96-c-*-iso8859-1")  ;;此处的18对应font四号
      ))


;;cnfonts
(use-package cnfonts
  :defer t
  :init
  (cnfonts-enable)
  )



(provide 'config-theme)




