;;-----------------------------------------------------------------
;; Defaults
;;-----------------------------------------------------------------
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(show-paren-mode 1)
(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode nil)
(setq-default indicate-empty-lines t)
(setq-default tab-width 2)
(setq-default espresso-indent-level 2)
(defalias 'yes-or-no-p 'y-or-n-p)

;;-----------------------------------------------------------------
;; Load paths and folder variables
;;-----------------------------------------------------------------
;; Variables to help
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(setq packages-dir (concat dotfiles-dir "/packages"))

;; Add this directory to load path initially
(add-to-list 'load-path dotfiles-dir)

;; Don't clutter up directories with files~
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;;-----------------------------------------------------------------
;; Color Theme
;;-----------------------------------------------------------------
;; Add the color theme directory and theme directory to the load
;; path
(add-to-list 'load-path (concat packages-dir "/color-theme"))
(add-to-list 'load-path (concat dotfiles-dir "/themes"))

;; Initialize color-theme
(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(setq color-theme-is-cumulative t)
(setq color-theme-load-all-themes nil)

;;-----------------------------------------------------------------
;; Other Packages and Files
;;-----------------------------------------------------------------
(load "modes.el")
(load "keybindings.el")
(load "hooks.el")
(load "filetypes.el")

;; ido
(ido-mode t)
(setq ido-enable-flex-matching t)

;;-----------------------------------------------------------------
;; System/User-specific configuration
;;-----------------------------------------------------------------
;; Loads system-type config first. e.g. "darwin.el" on mac
(let ((system-type-config (concat dotfiles-dir (symbol-name system-type) ".el")))
  (if (file-exists-p system-type-config)
    (load system-type-config)))

;; Load user-specific config next
(let ((user-login-config (concat dotfiles-dir user-login-name ".el")))
  (if (file-exists-p user-login-config)
    (load user-login-config)))

(provide 'init)
