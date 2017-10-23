;;; fit-frame-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "fit-frame" "fit-frame.el" (22918 59895 0 0))
;;; Generated autoloads from fit-frame.el

(let ((loads (get 'fit-frame 'custom-loads))) (if (member '"fit-frame" loads) nil (put 'fit-frame 'custom-loads (cons '"fit-frame" loads))))

(defvar fit-frame-inhibit-fitting-flag nil "\
*Non-nil means command `fit-frame' does nothing.
You can bind this to non-`nil' to temporarily inhibit frame fitting:
    (let ((fit-frame-inhibit-fitting-flag  t))...)")

(custom-autoload 'fit-frame-inhibit-fitting-flag "fit-frame" t)

(defvar fit-frame-crop-end-blank-flag nil "\
*Non-nil means `fit-frame' doesn't count blank lines at end of buffer.
If nil, then fitting leaves room for such blank lines.")

(custom-autoload 'fit-frame-crop-end-blank-flag "fit-frame" t)

(defvar fit-frame-min-width window-min-width "\
*Minimum width, in characters, that `fit-frame' gives to a frame.
The actual minimum is at least the greater of this and `window-min-width'.")

(custom-autoload 'fit-frame-min-width "fit-frame" t)

(defvar fit-frame-max-width nil "\
*Maximum width, in characters, that `fit-frame' gives to a frame.
If nil, then the function `fit-frame-max-width' is used instead.")

(custom-autoload 'fit-frame-max-width "fit-frame" t)

(defvar fit-frame-max-width-percent 94 "\
*Maximum percent of display width that `fit-frame' gives to a frame'.
See function `fit-frame-max-width'.
Not used unless `fit-frame-max-width' is nil.")

(custom-autoload 'fit-frame-max-width-percent "fit-frame" t)

(defvar fit-frame-min-height window-min-height "\
*Minimum height, in lines, that `fit-frame' gives to a frame.
The actual minimum is at least the greater of this and `window-min-height'.")

(custom-autoload 'fit-frame-min-height "fit-frame" t)

(defvar fit-frame-max-height nil "\
*Maximum height, in lines, that `fit-frame' gives to a frame.
If nil, then the function `fit-frame-max-height' is used instead.")

(custom-autoload 'fit-frame-max-height "fit-frame" t)

(defvar fit-frame-max-height-percent 82 "\
*Maximum percent of display height that `fit-frame' gives to a frame.
See function `fit-frame-max-height'.
Not used unless `fit-frame-max-height' is nil.")

(custom-autoload 'fit-frame-max-height-percent "fit-frame" t)

(defvar fit-frame-empty-width (or (cdr (assq 'width default-frame-alist)) 80) "\
*Width, in characters, that `fit-frame' gives to an empty frame.")

(custom-autoload 'fit-frame-empty-width "fit-frame" t)

(defvar fit-frame-empty-height (or (cdr (assq 'height default-frame-alist)) 35) "\
*Height, in lines, that `fit-frame' gives to an empty frame.")

(custom-autoload 'fit-frame-empty-height "fit-frame" t)

(defvar fit-frame-empty-special-display-width 80 "\
*Width, in chars, that `fit-frame' gives to an empty special-display frame.
If this is nil, it is ignored.")

(custom-autoload 'fit-frame-empty-special-display-width "fit-frame" t)

(defvar fit-frame-empty-special-display-height 9 "\
*Height, in lines, that `fit-frame' gives to an empty special-display frame.
If this is nil, it is ignored.")

(custom-autoload 'fit-frame-empty-special-display-height "fit-frame" t)

(defvar fit-frame-fill-column-margin 7 "\
*Difference between `fill-column' and frame width after fitting a frame.
Used when `fit-frame' fits a frame, if the prefix arg is negative.
Depending on the average word length of the language used in the
selected window, you might want different values for this.  This
variable is buffer-local.")

(custom-autoload 'fit-frame-fill-column-margin "fit-frame" t)

(defvar fit-frame-skip-header-lines-alist '((Info-mode . 1) (dired-mode . 3) (compilation-mode . 2)) "\
*Alist of major-modes and header lines to ignore.
When `fit-frame' calculates the width of the current buffer, it can
first skip some lines at the buffer beginning, ignoring their
widths.  For example, Info, Dired, and compilation buffers sometimes
have a long header line at the top.  You can use this alist to tell
`fit-frame' to ignore the width of these header lines.

Each item in the alist is of form (MODE . LINES).
 MODE is a major-mode name.
 LINES is the number of lines to skip at the beginning of the buffer.")

(custom-autoload 'fit-frame-skip-header-lines-alist "fit-frame" t)

(autoload 'fit-frame "fit-frame" "\
Resize FRAME to fit its buffer(s).
Does nothing if `fit-frame-inhibit-fitting-flag' is non-nil.

FRAME defaults to the current (i.e. selected) frame.

If non-nil, WIDTH and HEIGHT specify the frame width and height.  To
define them interactively, use a non-negative prefix arg (e.g. `C-9').

To set the width to `fill-column' + `fit-frame-fill-column-margin',
use a negative prefix arg (e.g. `M--').

To fit the frame to all of its displayed buffers, use no prefix arg.
To fit it to just the current buffer, use a plain prefix arg (`C-u').

Fitting a non-empty buffer means resizing the frame to the smallest
size such that the following are both true:

 * The width is at least `fit-frame-min-width' and `window-min-width'.
   The width is at most `fit-frame-max-width(-percent)' and the
   longest line length.

   (However, extra width is allowed for fringe, if shown.)

 * The height is at least `fit-frame-min-height' and
   `window-min-height'.  The height is at most
   `fit-frame-max-height(-percent)' and the number of lines.

You can thus use those user variables to control the maximum and
minimum frame sizes.  The `*-percent' options let you specify the
maximum as a percentage of your display size.

See also options `fit-frame-skip-header-lines-alist' and
`fit-frame-crop-end-blank-flag'.

The following user options control how an empty frame is fit.
An empty frame is a one-window frame displaying an empty buffer.

 * `fit-frame-empty-width', `fit-frame-empty-height' (normal buffer)
 * `fit-frame-empty-special-display-width',
   `fit-frame-empty-special-display-height' (special-display buffer)

Note: `fit-frame' does not take into account wrapping of a menu-bar
line.  There is no easy way to calculate the number of display lines
from such wrapping.

\(fn &optional FRAME WIDTH HEIGHT ALL-WINDOWS-P INTERACTIVEP)" t nil)

(autoload 'fit-frame-to-image "fit-frame" "\
Fit FRAME to the current image.
If FRAME is not the selected frame, fit it to its first image.
Interactively, if frame has already been fit to the image, then
 restore the size from before it was fit.
This function assumes that FRAME has only one window.

\(fn INTERACTIVEP &optional FRAME)" t nil)

(autoload 'fit-frame-or-mouse-drag-vertical-line "fit-frame" "\
If only window in frame, `fit-frame'; else `mouse-drag-vertical-line'.

\(fn START-EVENT)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; fit-frame-autoloads.el ends here
