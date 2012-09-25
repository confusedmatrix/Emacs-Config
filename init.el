;;Load all extensions in .emacs.d
(add-to-list 'load-path "~/.emacs.d")  

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Some single liners
(show-paren-mode 1)
(electric-pair-mode 1)

(global-ede-mode 1) 

(global-linum-mode 1)
(setq linum-format "%4d ")
(setq standard-indent 4)
(column-number-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 200 4))

(fset 'yes-or-no-p 'y-or-n-p)

;; Setup Solarized color theme
(add-to-list 'load-path "~/.emacs.d/themes/solarized")
(if
    (equal 0 (string-match "^24" emacs-version))
    ;; it's emacs24, so use built-in theme
    (require 'solarized-dark-theme)
  ;; it's NOT emacs24, so use color-theme
  (progn
    (require 'color-theme)
    (color-theme-initialize)
    (require 'color-theme-solarized)
    (color-theme-solarized-dark)))

;; Setup JavaScript support
;;(autoload 'js2-mode "js2" nil t)                                     
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)) 

;; Setup PHP support
(add-to-list 'load-path "~/.emacs.d")
(require 'php-mode)
(require 'flymake)

(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns 
  '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
(add-hook 'php-mode-hook (lambda ()
  (require 'php-completion)
  (php-completion-mode t)
  (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
  (when (require 'auto-complete nil t)
    (make-variable-buffer-local 'ac-sources)
    (add-to-list 'ac-sources 'ac-source-php-completion)
    ;;(add-to-list 'ac-sources 'ac-source-php-completion-partial)
    (auto-complete-mode t))))

(define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
(define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)

;; Python support
(add-to-list 'load-path "~/.emacs.d/python-mode")
(require 'python-mode)
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;; IDO support
(setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

;; Yasnippet support
;;(add-to-list 'load-path "~/.emacs.d/yasnippet")
;;(require 'yasnippet)
;;(yas-global-mode 1)
;;(local-set-key [tab] 'yas/expand)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
