;; Install Evil if missing, then turn it on
(use-package evil
  :ensure t          ; download from the package archive if not installed
  :init
  (setq evil-want-C-u-scroll t)  ; make C-u scroll up like in Vim
  :config
  (evil-mode 1))     ; enable Evil everywhere

;; Show line numbers relative to the cursor, like Vim's relativenumber
(setq display-line-numbers-type 'relative)
;; Turn line numbers on in every buffer
(global-display-line-numbers-mode 1)

;; Sync the kill ring with the system clipboard in terminal Emacs
(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

