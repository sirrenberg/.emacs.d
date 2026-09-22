;; Use clangd-22 as the language server for C/C++
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode c-ts-mode c++-ts-mode) . ("clangd-22"))))

;; For each C/C++ mode: start Eglot
(dolist (hook '(c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook))
  (add-hook hook #'eglot-ensure))

;; C-c f formats the buffer (or the selected region) with clangd
(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c f") #'eglot-format))
