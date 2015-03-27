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
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil))))
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
;;(setq-default TeX-PDF-mode t)
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
;;(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;;(setq TeX-source-correlate-start-server t)
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
;; ;;add latexmk 
;; (add-hook 'LaTeX-mode-hook (lambda ()
;;                              (push 
;;                               '("mklatex" "latexmk -pdf %s" TeX-run-TeX nil t
;;                                 :help "Run Latexmk on file")
;;                               TeX-command-list)))
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
;; (add-to-list 'LaTeX-clean-intermediate-suffixes "\\.fls" t)
;; (add-to-list 'LaTeX-clean-intermediate-suffixes "\\.fdb_latexmk" t)
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
(global-set-key (kbd "C-c f") 'helm-projectile)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-autoresize-mode t)
;;--------------------------------------------

;;------------------------------------------------
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
;;------------------------------------------------

;;--------------------------------------------
;;sync inverse forward search
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-master nil)
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list
   (quote
    (("Sumatra PDF"
      ("\"C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe\" -reuse-instance"
       (mode-io-correlate " -forward-search %b %n")
       " %o")))))
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and start")
     (output-dvi "Yap")
     (output-pdf "Sumatra PDF")
     (output-html "start")))))
;;--------------------------------------------

;;------------------------------------------------
;;texify
;;; http://www.emacswiki.org/emacs/TN
(require 'tex-buf)
(defun TeX-command-default (name)
  "Next TeX command to use. Most of the code is stolen from `TeX-command-query'."
  (cond ((if (string-equal name TeX-region)
             (TeX-check-files (concat name "." (TeX-output-extension))
                              (list name)
                              TeX-file-extensions)
           (TeX-save-document (TeX-master-file)))
         TeX-command-default)
        ((and (memq major-mode '(doctex-mode latex-mode))
              (TeX-check-files (concat name ".bbl")
                               (mapcar 'car
                                       (LaTeX-bibliography-list))
                               BibTeX-file-extensions))
         ;; We should check for bst files here as well.
         TeX-command-BibTeX)
        ((TeX-process-get-variable name
                                   'TeX-command-next
                                   TeX-view))
        (TeX-view)))

;;;  from wiki
(defcustom TeX-texify-Show t
  "Start view-command at end of TeX-texify?"
  :type 'boolean
  :group 'TeX-command)

(defcustom TeX-texify-max-runs-same-command 5
  "Maximal run number of the same command"
  :type 'integer
  :group 'TeX-command)

(defun TeX-texify-sentinel (&optional proc sentinel)
  "Non-interactive! Call the standard-sentinel of the current LaTeX-process.
If there is still something left do do start the next latex-command."
  (set-buffer (process-buffer proc))
  (funcall TeX-texify-sentinel proc sentinel)
  (let ((case-fold-search nil))
    (when (string-match "\\(finished\\|exited\\)" sentinel)
      (set-buffer TeX-command-buffer)
      (unless (plist-get TeX-error-report-switches (intern (TeX-master-file)))
        (TeX-texify)))))

(defun TeX-texify ()
  "Get everything done."
  (interactive)
  (let ((nextCmd (TeX-command-default (TeX-master-file)))
        proc)
    (if (and (null TeX-texify-Show)
             (equal nextCmd TeX-view))
        (when  (called-interactively-p 'any)
          (message "TeX-texify: Nothing to be done."))
      (TeX-command nextCmd 'TeX-master-file)
      (when (or (called-interactively-p 'any)
                (null (boundp 'TeX-texify-count-same-command))
                (null (boundp 'TeX-texify-last-command))
                (null (equal nextCmd TeX-texify-last-command)))
        (mapc 'make-local-variable '(TeX-texify-sentinel TeX-texify-count-same-command TeX-texify-last-command))
        (setq TeX-texify-count-same-command 1))
      (if (>= TeX-texify-count-same-command TeX-texify-max-runs-same-command)
          (message "TeX-texify: Did %S already %d times. Don't want to do it anymore." TeX-texify-last-command TeX-texify-count-same-command)
        (setq TeX-texify-count-same-command (1+ TeX-texify-count-same-command))
        (setq TeX-texify-last-command nextCmd)
        (and (null (equal nextCmd TeX-view))
             (setq proc (get-buffer-process (current-buffer)))
             (setq TeX-texify-sentinel (process-sentinel proc))
             (set-process-sentinel proc 'TeX-texify-sentinel))))))

(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (define-key LaTeX-mode-map (kbd "C-c C-a") 'TeX-texify)))
;;--------------------------------------------



