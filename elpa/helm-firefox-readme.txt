You will have to set firefox to import bookmarks in his html file bookmarks.html.
(only for firefox versions >=3)
To achieve that, open about:config in firefox and double click on this line to enable value
to true:
user_pref("browser.bookmarks.autoExportHTML", false);
You should have now:
user_pref("browser.bookmarks.autoExportHTML", true);
NOTE: This is also working in the same way for mozilla aka seamonkey.


(defgroup helm-firefox nil
  "Helm libraries and applications for Firefox navigator."
  :group 'helm)

(defcustom helm-firefox-default-directory "~/.mozilla/firefox/"
  "The root directory containing firefox config.
On Mac OS X, probably set to \"~/Library/Application Support/Firefox/\"."
  :group 'helm-firefox
  :type 'string)

(defcustom helm-firefox-show-structure nil
  "Show the directory structure of bookmark when non-nil."
  :group 'helm-firefox
  :type 'boolean)

(defvar helm-firefox-bookmark-url-regexp "\\(https\\|http\\|ftp\\|about\\|file\\)://[^ \"]*")
(defvar helm-firefox-bookmarks-regexp ">\\([^><]+.\\)</[aA]>")
(defvar helm-firefox-bookmarks-subdirectory-regex "<H[1-6][^>]*>\\([^<]*\\)</H.>")
(defvar helm-firefox-separator " » ")

(defun helm-get-firefox-user-init-dir ()
  "Guess the default Firefox user directory name."
  (let* ((moz-dir helm-firefox-default-directory)
         (moz-user-dir
          (with-current-buffer (find-file-noselect
                                (expand-file-name "profiles.ini" moz-dir))
            (goto-char (point-min))
            (prog1
                (when (search-forward "Path=" nil t)
                  (buffer-substring-no-properties (point) (point-at-eol)))
              (kill-buffer)))))
    (file-name-as-directory (concat moz-dir moz-user-dir))))

(defun helm-firefox-bookmarks-to-alist (file url-regexp bmk-regexp)
  "Parse html bookmark FILE and return an alist with (title . url) as elements."
  (let (bookmarks-alist url title stack)
    (with-temp-buffer
      (insert-file-contents file)
      (goto-char (point-min))
      (while (re-search-forward "href=\\|^ *<DT><A HREF=\\|<DT><H\\|</DL>" nil t)
        (forward-line 0)
        (cond (;; Matches on bookmark folders (<H3>...</H3>).
               (string-equal (match-string 0) "<DT><H")
               ;; Extract bookmark folders name
               (if (re-search-forward
                    helm-firefox-bookmarks-subdirectory-regex
                    (point-at-eol) t)
                   (push (match-string 1) stack)))
              (;; Matches end of bookmark folder.
               (string-equal (match-string 0) "</DL>")
               (pop stack))
              (t
               (when (re-search-forward url-regexp nil t)
                 (setq url (match-string 0)))
               (when (re-search-forward bmk-regexp nil t)
                 (setq title (funcall helm-html-decode-entities-function (match-string 1))))
               (push
                (cons
                 ;; "Dir >> Dir >> Title"
                 (if helm-firefox-show-structure
                     (mapconcat 'identity
                                (reverse (cons title stack))
                                helm-firefox-separator)
                     title)
                 url)
                bookmarks-alist)))
        (forward-line)))
    (nreverse bookmarks-alist)))

(defun helm-guess-firefox-bookmark-file ()
  "Return the path of the Firefox bookmarks file."
  (expand-file-name "bookmarks.html" (helm-get-firefox-user-init-dir)))

(defvar helm-firefox-bookmarks-alist nil)
(defvar helm-source-firefox-bookmarks
  (helm-build-sync-source "Firefox Bookmarks"
    :init (lambda ()
            (let ((parser (if helm-firefox-show-structure
                              #'helm-firefox-bookmarks-to-alist
                              #'helm-html-bookmarks-to-alist)))
              (setq helm-firefox-bookmarks-alist
                    (funcall parser
                             (helm-guess-firefox-bookmark-file)
                             helm-firefox-bookmark-url-regexp
                             helm-firefox-bookmarks-regexp))))
    :candidates (lambda ()
                  (mapcar #'car helm-firefox-bookmarks-alist))
    :filtered-candidate-transformer
     '(helm-adaptive-sort
       helm-firefox-highlight-bookmarks)
    :action (helm-make-actions
             "Browse Url"
             (lambda (candidate)
               (helm-browse-url
                (helm-firefox-bookmarks-get-value candidate)))
             "Copy Url"
             (lambda (candidate)
               (let ((url (helm-firefox-bookmarks-get-value
                           candidate)))
                 (kill-new url)
                 (message "`%s' copied to kill-ring" url))))))

(defun helm-firefox-bookmarks-get-value (elm)
  (assoc-default elm helm-firefox-bookmarks-alist))

(defun helm-firefox-highlight-bookmarks-1 (bookmarks)
  (cl-loop for i in bookmarks
        collect (propertize
                 i 'face '((:foreground "YellowGreen"))
                 'help-echo (helm-firefox-bookmarks-get-value i))))

(defun helm-firefox-highlight-bookmarks-2 (bookmarks)
  (cl-loop for i in bookmarks
           for elements = (split-string i helm-firefox-separator)
           for path = (butlast elements)
           for prefix = (if path
                            (concat
                             (mapconcat 'identity path helm-firefox-separator)
                             helm-firefox-separator)
                          "")
           for title = (car (last elements))
           collect (concat
                    (propertize
                     prefix 'face '((:foreground "DarkGray"))
                     'help-echo (helm-firefox-bookmarks-get-value i))
                    (propertize
                     title 'face '((:foreground "YellowGreen"))
                     'help-echo (helm-firefox-bookmarks-get-value i)))))

(defun helm-firefox-highlight-bookmarks (bookmarks _source)
  (if helm-firefox-show-structure
      (helm-firefox-highlight-bookmarks-2 bookmarks)
      (helm-firefox-highlight-bookmarks-1 bookmarks)))

###autoload
(defun helm-firefox-bookmarks ()
  "Preconfigured `helm' for firefox bookmark.
You will have to enable html bookmarks in firefox:
open \"about:config\" in firefox and double click on this line to enable value
to true:

user_pref(\"browser.bookmarks.autoExportHTML\", false);

You should have now:

user_pref(\"browser.bookmarks.autoExportHTML\", true);

After closing firefox, you will be able to browse your bookmarks."
  (interactive)
  (helm :sources `(helm-source-firefox-bookmarks
                   ,(helm-build-dummy-source "DuckDuckgo"
                     :action (lambda (candidate)
                               (helm-browse-url
                                (format helm-surfraw-duckduckgo-url
                                        (url-hexify-string candidate))))))
        :buffer "*Helm Firefox*"))


(provide 'helm-firefox)

Local Variables:
byte-compile-warnings: (not cl-functions obsolete)
coding: utf-8
indent-tabs-mode: nil
End:

helm-firefox.el ends here
