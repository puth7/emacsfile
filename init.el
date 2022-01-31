;;--------------------------------------------
(set-register ?i (cons 'file "~/.emacs.d/init.el"))
;;C-x r j i
;; (set-register ?1 (cons 'file "/home/puth/Documents/putranto/tue/research/binary_puzzle_as_erasure_decoding/binary_puzzle_as_erasure_coding.tex" )) 
;; (set-register ?2 (cons 'file "/home/puth/Documents/putranto/tue/research/binary_puzzle_as_erasure_decoding/poster-esit-2015.tex" ))
(global-set-key "\C-x\ \T" 'eshell)
;;--------------------------------------------

;;--------------------------------------------
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t) )
;;probably needed:
;;auctex
;;auto-complete-sage
;;auto-complete-auctex
;;auto-complete
;;show-paren-mode
;;helm
;;flycheck
;;sage-shell-mode ;; install to have support on sage file
;;flyspell

;;--------------------------------------------

;;--------------------------------------------
;;(global-linum-mode 1)
(add-hook 'prog-mode-hook 'linum-mode 1)
(add-hook 'text-mode-hook 'linum-mode 1)

;;--------------------------------------------
;;disable toolbar
(tool-bar-mode -1)
;;--------------------------------------------

;;--------------------------------------------
;;enter auto indent
;; (require 'auto-indent-mode)
;; ;;(setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
;; ;;(auto-indent-global-mode)
;; (add-to-list 'auto-indent-disabled-modes-list 'sage-shell:sage-mode)
;; (defun set-newline-and-indent ()
;;   "Map the return key with `newline-and-indent'"
;;   (local-set-key (kbd "RET") 'newline-and-indent))
;; (add-hook 'sage-shell:sage-mode-hook 'set-newline-and-indent)
;;------------------------------------------

;;--------------------------------------------
;;; parentheses marking
(show-paren-mode t) ;; turn paren-mode on
;; (set-face-foreground 'show-paren-mismatch-face "red")
;; (set-face-attribute 'show-paren-mismatch-face nil
;;                     :weight 'bold :underline t :overline nil :slant 'normal)
;;------------------------------------------

;;------------------------------------------
;; word wrap -- nice view
(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
;;-------------------------------------------

;;--------------------------------------------
;;helm mode
(require 'helm)
(require 'helm-config)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z
(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))
(setq helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount 8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-s o") 'helm-occur)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<menu>") 'helm-M-x)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(helm-autoresize-mode t)
;;-----------------------------------------------

;;----------------------------------------
;;on the fly
(require 'flyspell)
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
;(setq ispell-dictionary "indonesian") 
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))
;;----------------------------------------
(require 'langtool)
(setq langtool-language-tool-jar "/opt/program/nux/LanguageTool-5.1/languagetool-commandline.jar" )
(setq langtool--user-arguments '("--languagemodel" "/opt/program/nux/ngrams-en-20150817"))
;;---------------------
;;(setq synonyms-file        "/home/puth/.emacs.d/mthesaur.txt")
;;(setq synonyms-cache-file  "/home/puth/.emacs.d/mthesaur.txt.cache")
;;(require 'synonyms)
;;-----------------
;;(require 'writegood-mode)
;;-------------------

;;---------------------------
;; ;;magit shortcut/set key
;; (global-set-key (kbd "C-x v c") 'magit-commit)
;; (global-set-key (kbd "C-x v f") 'magit-pull)
;; (global-set-key (kbd "C-x v p") 'magit-push)


;;--------------------------------------------
					;;autocoomplete

;; (require 'auto-complete-sage)
;; (global-auto-complete-mode t)

;;  (require 'ac-helm)  ;; Not necessary if using ELPA package
;;  (global-set-key (kbd "C-:") 'ac-complete-with-helm)
;; (define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (ac-flyspell-workaround)                        ;----------------------------------------



;; ;;;  LATEX ;;;;
;; ;;--------------------------------------------
;; ;;inverse/forward search mode latex ;; press ctrl+left click on evince
 (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
 (setq TeX-source-correlate-start-server t)
;; ;;---------------------------

;; ;;---------------------------
;; ;;enable math mode
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; ;;-------------------------------

;;--------------------------------------------
;;;latex normal font-only work with auctex
;; Only change sectioning colour
;; (require 'auto-complete-auctex)
(setq font-latex-fontify-sectioning 'color)
;; super-/sub-script on baseline
(setq font-latex-script-display (quote (nil)))
;; Do not change super-/sub-script font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil))))
;; Exclude bold/italic from keywords
 (setq font-latex-deactivated-keyword-classes
     '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))
;;  (eval-after-load "tex-mode" '(fset 'tex-font-lock-suscript 'ignore)) ;; disable auto subscript for latex file. old (use this if auctex is not installed)
;;--------------------------------------------

;; ;;------------------------------------------------
;; (setq-default TeX-PDF-mode t)
;; (setq-default TeX-engine 'luatex)
;; ;;(setq latex-run-command "pdflatex")
;; ;;--------------------------------------------





;;;; to be considered  --> ??
;; ;;----------------------------------------
;; ;;add latexmk 
;; ;; (add-hook 'LaTeX-mode-hook (lambda ()
;; ;;                              (push 
;; ;;                               '("mklatex" "latexmk -pdf %s" TeX-run-TeX nil t
;; ;;                                 :help "Run Latexmk on file")
;; ;;                               TeX-command-list)))
;; (require 'auctex-latexmk)
;; (auctex-latexmk-setup)

;; (add-to-list 'LaTeX-clean-intermediate-suffixes "\\.fls" t)
;; (add-to-list 'LaTeX-clean-intermediate-suffixes "\\.fdb_latexmk" t)
;; ;;----------------------------------------

;; ;;----------------------------------------
(add-hook 'latex-mode-hook 'turn-on-reftex) 
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTex t)
;; ;;Once Reftex is loaded, you can invoke the table of contents buffer with C-c =
;; ;; ;;----------------------------------------


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "PDF Tools")
     (output-html "xdg-open"))))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (pdf-tools async auto-complete-sage helm-sage sage-shell-mode langtool auto-indent-mode auctex))))

(setq sage-shell:use-prompt-toolkit nil)

(pdf-tools-install)

(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
