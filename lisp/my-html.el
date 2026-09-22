(defun my-prettier-format ()
  "Format the current buffer with Prettier."
  (interactive)
  (let ((file (or buffer-file-name "file.html"))
        (out (generate-new-buffer " *prettier*")))
    (unwind-protect
        ;; Send the buffer to prettier; its output goes to `out'.
        ;; --stdin-filepath lets Prettier pick the parser from the file
        ;; extension and find your .prettierrc.
        (if (zerop (call-process-region (point-min) (point-max)
                                        "prettier" nil out nil
                                        "--stdin-filepath" file))
            ;; Success: swap in the result, keeping the cursor in place
            (replace-buffer-contents out)
          ;; Failure: leave the buffer alone and show the error
          (message "Prettier failed: %s"
                   (with-current-buffer out (buffer-string))))
      ;; Always clean up the temporary buffer
      (kill-buffer out))))

(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "C-c f") #'my-prettier-format))

;; so when writing <p> I get </p> directly when closing
(use-package web-mode
  :ensure t
  :mode ("\\.html?\\'" . web-mode)   ; use web-mode for .html/.htm files
  :config
  ;; 2 = insert </tag> automatically when you type the > of an opening tag
  (setq web-mode-auto-close-style 2)
  (setq web-mode-enable-auto-closing t))
