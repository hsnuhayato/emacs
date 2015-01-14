(setq load-path (cons "~/.emacs.d/elisp" load-path))
(require 'acp)
(add-hook 'emacs-lisp-mode-hook 'acp-mode)
(add-hook 'lisp-mode-hook 'acp-mode)
(add-hook 'c++-mode-hook 'acp-mode)
(add-hook 'tex-mode-hook 'acp-mode)
(setq acp-paren-alist
  '((?( . ?))
    (?[ . ?])
    (?{ . ?})
    (?$ . ?$)
    (?\" . ?\")
    (?\' . ?\')))
(setq acp-insertion-functions
   '((mark-active . acp-surround-with-paren)
     ((thing-at-point 'symbol) . acp-surround-symbol-with-paren)
     (t . acp-insert-paren)))
(defun acp-surround-symbol-with-paren (n)
  (save-excursion
    (save-restriction
      (narrow-to-region (car (bounds-of-thing-at-point 'symbol)) (cdr (bounds-of-thing-at-point 'symbol)))
      (goto-char (point-min))
      (insert-char (car (acp-current-pair)) n)
      (goto-char (point-max))
      (insert-char (cdr (acp-current-pair)) n))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tabbar)
(tabbar-mode)
;(global-set-key "\M-]" 'tabbar-forward)  ; 次のタブ
;(global-set-key "\M-[" 'tabbar-backward) ; 前のタブ
(global-set-key [M-right] 'tabbar-forward)  ; 次のタブ
(global-set-key [M-left] 'tabbar-backward) ; 前のタブ
(global-set-key [XF86Forward] 'tabbar-forward)  ; 次のタブ
(global-set-key [XF86Back] 'tabbar-backward) ; 前のタブ
;; タブ上でマウスホイールを使わない
(tabbar-mwheel-mode nil)
;; グループを使わない
(setq tabbar-buffer-groups-function nil)
;; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; 色設定
(set-face-attribute ; バー自体の色
  'tabbar-default nil
   :background "gray85"
   :family "Inconsolata"
   :height 1.0)
(set-face-attribute ; アクティブなタブ
  'tabbar-selected nil
   :background "black"
   :foreground "white"
   :weight 'bold
   :box nil)
(set-face-attribute ; 非アクティブなタブ
  'tabbar-unselected nil
   :background "gray85"
   :foreground "black"
   :box nil)
;; M-4 で タブ表示、非表示
(global-set-key "\M-4" 'tabbar-mode)
(global-set-key "\M-3" 'kill-buffer)
;off tool bar
(tool-bar-mode -1)
;;; 対応する括弧をハイライト
(show-paren-mode t)
;; c coding style // c言語用
(add-hook 'c++-mode-hook
'(lambda ()
(hs-minor-mode 1)))
(define-key global-map (kbd "C-x /") 'hs-toggle-hiding)
