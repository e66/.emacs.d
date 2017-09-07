(use-package verilog-mode
  :ensure t
  :defer t
  :init
  ;;;; User customization for Verilog mode
  (setq verilog-indent-level             4
        verilog-indent-level-module      4
        verilog-indent-level-declaration 4
        verilog-indent-level-behavioral  4)
  (autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
  (add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode)))


;;vhdl-capf
(use-package vhdl-capf
  :ensure t
  :defer t
  :config
  (when (require 'vhdl-capf)
    (vhdl-capf-enable))
  )

(provide 'config-hdl)
