;;--------------------------------------------
(set-register ?i (cons 'file "~/.emacs.d/init.el"))
;;C-x r j i
(global-set-key "\C-x\ \T" 'eshell)
;;--------------------------------------------

;;--------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)  (package-refresh-contents))
(unless (package-installed-p 'use-package)  (package-install 'use-package))

;;probably needed:
;;auctex
;;auto-complete-sage
;;auto-complete-auctex
;;auto-complete
;;show-paren-mode
;;vertico
;;flycheck
;;sage-shell-mode ;; install to have support on sage file
;;flyspell
;;Writegood Mode
;;magit
;;--------------------------------------------

;;--------------------------------------------
;;Line numbering

(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
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
(unless (package-installed-p `orderless) (package-install `orderless))
(unless (package-installed-p `vertico) (package-install `vertico))
(unless (package-installed-p `consult) (package-install `consult))

(use-package vertico
  :custom
  (vertico-count 20)  ;; limit to a fixed size
  :bind (:map vertico-map
    ;; Use page-up/down to scroll vertico buffer, like ivy does by default.
    ("<prior>" . 'vertico-scroll-down)
    ("<next>"  . 'vertico-scroll-up))
  :init
  ;; Activate vertico
  (vertico-mode 1))

;; Convenient path selection
(use-package vertico-directory
  :after vertico
  :ensure nil  ;; no need to install, it comes with vertico
  :bind (:map vertico-map
    ("DEL" . vertico-directory-delete-char)))

(use-package orderless
  :custom
  ;; Activate orderless completion
  (completion-styles '(orderless basic))
  ;; Enable partial completion for file wildcard support
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :custom
  ;; Disable preview
  (consult-preview-key nil)
  :bind
  (("C-x b" . 'consult-buffer)    ;; Switch buffer, including recentf and bookmarks
   ("M-l"   . 'consult-git-grep)  ;; Search inside a project
   ("M-y"   . 'consult-yank-pop)  ;; Paste by selecting the kill-ring
   ("M-s"   . 'consult-line)      ;; Search current buffer, like swiper
   ))

(use-package embark
  :bind
  (("C-."   . embark-act)         ;; Begin the embark process
   ("C-;"   . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :config
  (use-package embark-consult))
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

;;-----------------
;;### pdf-tools
(unless (package-installed-p 'pdf-tools)  (package-install 'pdf-tools))

;; This is an alternative to the built-in DocView package.
;; I allows smooth scrolling and it superior in general.
;; I could load several PDFs, including 500 pages books.
;; 
;; 
;; The pdf-tools package runs on top of pdf-view package.
;; This making capturing text from PDFs much easier.
;; 
;; I followed a [[http://pragmaticemacs.com/emacs/view-and-annotate-pdfs-in-emacs-with-pdf-tools][blog post]].
;; You enter highlights by selecting with the mouse and entering C-c C-a h.
;; An annotation menu opens in the minibuffer.
;; Enter ~C-c C-c~ to save the annotation.
;; Enter ~C-c C-a t~ to enter text notes.
;; Enter the note and enter ~C-c C-c~ to save.
;; Right-click the mouse to get a menu of more options.


(use-package pdf-tools
  ;;:pin manual ;; manually update
  :config
  ;; initialise
  (pdf-tools-install)

  ;; This means that pdfs are fitted to width by default when you open them
  (setq-default pdf-view-display-size 'fit-width)
  ;; open pdfs scaled to fit page
  ;;  (setq-default pdf-view-display-size 'fit-page)
   ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  ;; use normal isearch
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))
  ;; Setting for sharper images with Macs with Retina displays
  (setq pdf-view-use-scaling t)

;;  (load "pdf-tools")

;;(setq TeX-view-program-selection '((output-pdf "PDF Tools"))) ;; <-- THIS one

;; **** Useful keybindings for viewing PDFs
;; |------------------------------------------+-----------------|
;; | Display                                  |                 |
;; |------------------------------------------+-----------------|
;; | Zoom in / Zoom out                       | ~+~ / ~-~       |
;; | Fit height / Fit width / Fit page        | ~H~ / ~W~ / ~P~ |
;; | Trim margins (set slice to bounding box) | ~s b~           |
;; | Reset margins                            | ~s r~           |
;; | Reset z oom                              | ~0~             |
;; |------------------------------------------+-----------------|
;; 
;; **** Useful keybindings for navigating PDFs
;; 
;; |-----------------------------------------------+-----------------------|
;; | Navigation                                    |                       |
;; |-----------------------------------------------+-----------------------|
;; | Scroll Up / Down by Page-full                 | ~space~ / ~backspace~ |
;; | Scroll Up / Down by Line                      | ~C-n~ / ~C-p~         |
;; | Scroll Right / Left                           | ~C-f~ / ~C-b~         |
;; | First Page / Last Page                        | ~<~ / ~>~             |
;; | Next Page / Previous Page                     | ~n~ / ~p~             |
;; | First Page / Last Page                        | ~M-<~ / ~M->~         |
;; | Incremental Search Forward / Backward         | ~C-s~ / ~C-r~         |
;; | Occur (list all lines containing a phrase)    | ~M-s o~               |
;; | Jump to Occur Line                            | ~RETURN~              |
;; | Pick a Link and Jump                          | ~F~                   |
;; | Incremental Search in Links                   | ~f~                   |
;; | History Back / Forwards                       | ~l~ / ~r~             |
;; | Display Outline                               | ~o~                   |
;; | Jump to Section from Outline                  | ~RETURN~              |
;; | Jump to Page                                  | ~M-g g~               |
;; | Store position / Jump to position in register | ~m~ / ~'~             |
;; |-----------------------------------------------+-----------------------|
;; 

;;--------------------------------------------



;; ;;;  LATEX ;;;;
(unless (package-installed-p `auctex) (package-install `auctex))
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
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection '((output-pdf "PDF Tools")))
 '(package-selected-packages '(auctex consult orderless pdf-tools vertico))
 '(safe-local-variable-values '((TeX-master . "main"))))





