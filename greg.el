;;; greg.el --- A Text Adventure                     -*- lexical-binding: t; -*-

;; Copyright (C) 2022-2026  Nicholas Vollmer

;; Author: Nicholas Vollmer, Daniel Tims
;; URL: https://github.com/progfolio/greg
;; Created: December 17, 2022
;; Package-Requires: ((emacs "27.1") (spiel "0.0.0"))
;; Version: 0.0.0
;; Keywords: games

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; "I have nipples, Greg. Could you milk me?" ~ Jack Byrnes

;;; Code:
(require 'cl-lib)
(require 'spiel)
(require 'spiel-time)

(defvar greg--directory (file-name-directory (or load-file-name buffer-file-name)))
(defvar greg--object-directory (expand-file-name "./objects/" greg--directory))
(defvar greg--test-directory (expand-file-name "./tests/" greg--object-directory))
(defvar greg-buffer "*greg*")

(defun greg--context-string ()
  "Return context string for event."
  (propertize (format "%s %s" (format-time-string "%a %I:%M %p" spiel-time) (spiel-entity-name (spiel-object-room)))
              'face 'spiel-command-context))

(defun greg--header-line ()
  "Set the header-line."
  (with-current-buffer (get-buffer-create spiel-buffer)
    (concat (format-time-string "%Y-%m-%d %a %I:%M%p" spiel-time)
            (when-let ((room (spiel-object-room)))
              (concat  " "
                       (propertize (spiel-entity-name room)'face 'spiel-current-room))))))

(defun greg--intro ()
  "Game intro."
  (spiel-create-entity 'question :id 'could-you-milk-me?
                       :asker 'dad
                       :text "\"I have nipples, Greg. Could you milk me?\"")
  (spiel-ask 'could-you-milk-me?)
  (spiel-insert-prompt spiel-pending-question))

(defvar greg--post-init-hook (list #'greg--intro))

;;;###autoload
(defun greg--init ()
  "Initialize game state."
  (with-current-buffer (get-buffer-create greg-buffer)
    (let ((inhibit-read-only t)) (erase-buffer))
    (setq spiel-entities nil)
    (spiel-mode)
    (setq-local
     spiel-verbs (copy-tree (default-value 'spiel-verbs))
     spiel-buffer greg-buffer
     spiel-time (date-to-time "2000-09-01T17:00:00-05:00"))
    (cl-loop for f in (directory-files greg--object-directory t "\\.el\\'")
             when (file-exists-p f) do (load f nil 'no-message))
    (setq-local spiel-player (spiel-ensure-entity 'greg)
                header-line-format '(:eval (greg--header-line)))
    (spiel-display)
    (add-hook 'spiel-initialize-hook #'greg--init nil 'local)
    (add-hook 'spiel-go-hook #'greg--print-location-context nil 'local)
    (run-hooks 'greg--post-init-hook)))

;;;###autoload
(defun greg ()
  "Launch Greg."
  (interactive)
  (let ((buffer (get-buffer greg-buffer)))
    (if (buffer-live-p buffer)
        (with-current-buffer buffer
          (spiel-display))
      (greg--init))))

;;;###autoload
(defun greg-load (dir)
  "Reinitialize game with objects in DIR."
  (interactive (list (let ((default-directory greg--test-directory))
                       (read-directory-name "load object dir: " nil nil t))))
  (setq greg--object-directory dir)
  (greg--init))

(defun greg--print-location-context ()
  "Print context string for current location."
  (save-excursion (forward-line -1) (let ((inhibit-read-only t)) (erase-buffer)))
  (spiel-print "\n" (greg--context-string)))


(provide 'greg)
;;; greg.el ends here
