;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


(require 'use-package-ensure)
(setq use-package-always-ensure t)

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)


(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t))


;;; dependencies
(use-package autothemer)
(use-package all-the-icons)


;;; functionality
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package magit)

(use-package dashboard
  :init
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-footer-icon (all-the-icons-faicon "angle-right"
                                                    :height 1.1
                                                    :v-adjust -0.05
                                                    :face 'font-lock-keyword-face))
  (setq dashboard-items '((agenda . 4)
                          (projects . 4)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-page-separator "\n\f\n")
  :config
  (dashboard-setup-startup-hook)
  :after (all-the-icons page-break-lines))

(use-package evil-collection
  :config
  (evil-collection-init))

(use-package projectile
  :config
  (projectile-mode +1))

(use-package calfw)


;;; languages
(use-package lua-mode)
(use-package org
  :init
  ;; https://lucidmanager.org/productivity/ricing-org-mode/
  (setq org-startup-indented t
        org-pretty-entities t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-hide-leading-stars t))
(use-package gdscript-mode)


;;; looks
(use-package catppuccin-theme
  :after autothemer)

(use-package rainbow-delimiters
  :config
  (rainbow-delimiters-mode 1))

(use-package page-break-lines
  :config
  (global-page-break-lines-mode))

(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))

(use-package org-appear
  :hook
  (org-mode . org-appear-mode))


;;; settings
(load-theme 'catppuccin-macchiato)

(defun config-setup-fonts ()
  (if (eq system-type 'windows-nt)
      (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 120)
    (set-face-attribute 'default nil :font "JetBrainsMono" :height 120))
  ;; (set-face-attribute 'variable-pitch nil :font "Lora" :height 130))
  (set-face-attribute 'variable-pitch nil :font "Source Sans Pro" :height 135))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (config-setup-fonts))))
  (config-setup-fonts))

(setq default-frame-alist
      '((tool-bar-lines . 0)
        (vertical-scroll-bars . nil)))
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(setq-default indent-tabs-mode nil)
(setq-default buffer-file-coding-system 'utf-8-unix)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(column-number-mode)

(setq-default fill-column 80)

(setq
 scroll-conservatively 10000
 scroll-margin 2)


;; yoink https://www.emacswiki.org/emacs/BackupDirectory
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/backup/emacs-backups/"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)


;; IBuffer
(setq ibuffer-saved-filter-groups
  '(("home"
     ("My Config" (or (filename . "init.el")))
     ;; ("Org Mode" (or (mode . org-mode)))
     ("Help" (or (name . "\*Help\*")
                 (name . "\*Apropos\*")
                 (name . "\*info\*")))
     ("School" (or (filename . "school")))
     ("Builtin" (or (name . "\*scratch\*")
                    (name . "\*Messages\*")
                    (name . "\*Completions\*")
                    (name . "\*Backtrace\*")
                    (name . "\*Compile-Log\*"))))))

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-switch-to-saved-filter-groups "home")
             (ibuffer-auto-mode 1)))

(setq ibuffer-expert t)


;; https://stackoverflow.com/a/9697222
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))


;; Keybindings
(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>oa") 'org-agenda)
(evil-define-key '(normal visual) 'global (kbd "gc") 'comment-or-uncomment-region-or-line)
(evil-define-key 'normal 'global (kbd "<leader>p") 'projectile-command-map)

(global-set-key (kbd "C-x C-b") 'ibuffer)
