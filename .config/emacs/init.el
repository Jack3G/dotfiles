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
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package magit)

(use-package lua-mode)
(use-package org)

(use-package autothemer)
(use-package catppuccin-theme
  :after autothemer)


(load-theme 'catppuccin-macchiato)

(if (eq system-type 'windows-nt)
    (set-face-attribute 'default t :font "JetBrainsMono Nerd Font" :height 120)
    (set-face-attribute 'default t :font "JetBrainsMono" :height 120))


(setq default-frame-alist
      '((tool-bar-lines . 0)
        (vertical-scroll-bars . nil)))

(setq-default indent-tabs-mode nil)
(setq-default buffer-file-coding-system 'utf-8-unix)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(column-number-mode)

(setq-default fill-column 80)


;; yoink https://www.emacswiki.org/emacs/BackupDirectory
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/backup/emacs-backups/"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)
