;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; *****************************************************************************************
;;
;; tty-8color-theme: A theme to use on tty with limited color palete 
;;
;; *****************************************************************************************

(deftheme tty-8color "A Restricted Color Enviroment based theme")

  (custom-theme-set-variables
    'tty-8color
    '(linum-format " %5i "))

  (let ((background "#000000")
        (gutters    "#000000")
        (gutter-fg  "#ffffff")
        (gutters-active "#0000ff")
        (builtin      "#ff0000")
        (foreground "#ffffff")
        (invisibles "#ffff00")
        (lineHighlight "#00ffff")
        (selection  "#0000ff")
        (text       "#ffffff")
        (comments   "#ffff00")
	(comments-bg "#0000ff")
        (punctuation "#ffffff")
        (delimiters "#00ff00")
        (operators "#ff0000")
        (keywords "#ff00ff")
        (variables "#00ffff")
        (functions "#00ffff")
        (methods    "#00ffff")
        (strings    "#ffff00")
        (constants "#00ff00")
        (white     "#ffffff"))

  (custom-theme-set-faces
   'tty-8color

;; Default colors
;; *****************************************************************************************

   `(default   ((t (:foreground ,text :background ,background))))
   `(region    ((t (:background ,selection                       ))))
   `(cursor    ((t (:background ,white                        ))))
   `(fringe    ((t (:background ,background   :foreground ,white))))
   `(linum     ((t (:background ,background :foreground ,gutter-fg))))
   `(mode-line   ((t (:foreground ,gutters :background ,gutter-fg  ))))
   `(mode-line-inactive  ((t (:foreground ,gutter-fg :background ,gutters  ))))

;; Font lock faces
;; *****************************************************************************************
 
   `(font-lock-keyword-face           ((t (:foreground ,keywords))))
   `(font-lock-type-face              ((t (:foreground ,punctuation))))
   `(font-lock-constant-face          ((t (:foreground ,constants))))
   `(font-lock-variable-name-face     ((t (:foreground ,variables))))
   `(font-lock-builtin-face           ((t (:foreground ,builtin))))
   `(font-lock-string-face            ((t (:foreground ,strings))))
   `(font-lock-comment-face           ((t (:foreground ,comments :background ,comments-bg))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,delimiters))))
   `(font-lock-function-name-face     ((t (:foreground ,functions))))
   `(font-lock-doc-string-face        ((t (:foreground ,strings))))
   `(magit-section-highlight       ((t (:foreground "#ff0000" :weigth bold))))
   `(magit-section-heading       ((t (:foreground "LightGoldenrod2" :weight bold))))
   `(magit-hash                   ((t (:foreground ,strings))))
   '(corfu-default               ((t (:foreground "cyan" :background "blue"))))
;; *****************************************************************************************

   ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;; *****************************************************************************************

(provide-theme 'tty-8color)

;; Local Variables:
;; no-byte-compile: t
;; End:
