;;--------------------------------------------
(set-register ?i (cons 'file "~/.emacs.d/init.el"))
(set-register ?1 (cons 'file "E:/s3/coding_theory/binary_puzzle_as_erasure_decoding/binary_puzzle_as_erasure_coding.tex" ))
(set-register ?2 (cons 'file "E:/s3/coding_theory/binary_puzzle_as_erasure_decoding/poster-esit-2015.tex" ))
;;--------------------------------------------

;;--------------------------------------------
(define-key global-map (kbd "<apps>") 'execute-extended-command);; untuk winsdows (komoputer kantor
;;----------------------------------------

;;--------------------------------------------
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t) )

;;probably needed:
;; magit
;;auctex
;;auto-complete-sage
;;auto-complete-auctex
;;auto-complete
;;show-paren-mode
;;
;;--------------------------------------------

;;--------------------------------------------
(global-linum-mode 1)
;;--------------------------------------------

;;--------------------------------------------
;;autocoomplete
(require 'auto-complete-sage)
(global-auto-complete-mode t)
(require 'auto-complete-auctex)
;;----------------------------------------

;;--------------------------------------------
;;; parentheses marking
(show-paren-mode t)               ;; turn paren-mode on
(set-face-foreground 'show-paren-mismatch-face "red") 
(set-face-attribute 'show-paren-mismatch-face nil 
                    :weight 'bold :underline t :overline nil :slant 'normal)
;;------------------------------------------

;;--------------------------------------------
;;;latex normal font-only work with auctex
;; Only change sectioning colour
(setq font-latex-fontify-sectioning 'color)
;; super-/sub-script on baseline
(setq font-latex-script-display (quote (nil)))
;; Do not change super-/sub-script font
(custom-set-faces
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 )
;; Exclude bold/italic from keywords
(setq font-latex-deactivated-keyword-classes
      '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))
;;  (eval-after-load "tex-mode" '(fset 'tex-font-lock-suscript 'ignore)) ;; disable auto subscript for latex file
;;--------------------------------------------

;;--------------------------------------------
;;enable reference with bibtex
(require 'bibtex)
;;--------------------------------------------

;;-------------------------------------------
;;(cd "/home/puth/Documents/Putranto/TUe/Binary sudoku") not working
;;--------------------------------------------

;;------------------------------------------------
(setq-default TeX-PDF-mode t)
(setq-default TeX-engine 'luatex)
;;(setq latex-run-command "pdflatex")
;;--------------------------------------------



;;--------------------------------------------
;;enter auto indent
(setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
(require 'auto-indent-mode)
(auto-indent-global-mode)
;;(electric-indent-mode 1)
;;(define-key global-map (kbd "RET") 'newline-and-indent)
;;(add-hook 'lisp-mode-hook '(lambda ()  (local-set-key (kbd "RET") 'newline-and-indent))) ;;not working
;;; Indentation for python
;; Enter key executes newline-and-indent
;; (defun set-sage-newline-and-indent ()
;;   "change auto indent with normal one"
;;   (setq auto-indent-newline-function 'newline-and-indent))
;; (add-hook 'sage-shell:sage-mode-hook 'set-sage-newline-and-indent)
(add-to-list 'auto-indent-disabled-modes-list 'sage-shell:sage-mode)
(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'sage-shell:sage-mode-hook 'set-newline-and-indent)
;;------------------------------------------

;;--------------------------------------------
;;inverse/forward search mode latex
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-start-server t)
;;---------------------------

;;---------------------
;; word wrap -- nice view
(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
;;-------------------------

;;---------------------------
;;enable math mode
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;;-------------------------------

;;----------------------------------------
;;add latexmk 
(add-hook 'LaTeX-mode-hook (lambda ()
                             (push 
                              '("mklatex" "latexmk -pdf %s" TeX-run-TeX nil t
                                :help "Run Latexmk on file")
                              TeX-command-list)))
;;----------------------------------------

;;----------------------------------------
;;on the fly 
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))
;;----------------------------------------

;;----------------------------------------
;;(add-hook 'latex-mode-hook 'turn -on-reftex) 
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTex t)
;;Once Reftex is loaded, you can invoke the table of contents buffer with C-c =
(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq LaTeX-eqnarray-label "eq"
      LaTeX-equation-label "eq"
      LaTeX-figure-label "fig"
      LaTeX-table-label "tab"
      LaTeX-myChapter-label "chap"
      TeX-auto-save t
      TeX-newline-function 'reindent-then-newline-and-indent
      TeX-parse-self t
      TeX-style-path
      '("style/" "auto/"
        "/usr/share/emacs21/site-lisp/auctex/style/"
        "/var/lib/auctex/emacs21/"
        "/usr/local/share/emacs/site-lisp/auctex/style/")
      LaTeX-section-hook
      '(LaTeX-section-heading
        LaTeX-section-title
        LaTeX-section-toc
        LaTeX-section-section
        LaTeX-section-label))
;;----------------------------------------


;;------------------------------------------------
;;recent file open
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
;;--------------------------------------------


;;--------------------------------------------
(add-to-list 'LaTeX-clean-intermediate-suffixes "\\.fls" t)
(add-to-list 'LaTeX-clean-intermediate-suffixes "\\.fdb_latexmk" t)
;;--------------------------------------------

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
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "M-x") 'helm-M-x)
(helm-autoresize-mode t)
;;--------------------------------------------
