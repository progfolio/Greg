;;; greg.el --- A Text Adventure                     -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Nicholas Vollmer

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
(require 'spiel)
(require 'cl-lib)

(defvar greg--directory (or (ignore-errors (file-name-directory load-file-name))
                            default-directory))
(defvar greg--assets (expand-file-name "./assets" greg--directory))
(defvar greg--rooms-dir (expand-file-name "./rooms" greg--assets))

(defun greg ()
  "Play Greg."
  (interactive)
  (spiel-game<-create "Greg" greg--rooms-dir
                      :reset #'greg
                      :input-buffer "*greg input*"
                      :output-buffer "*greg output*")
  (setf (spiel-game<-room spiel--game) (alist-get 'switchboard (spiel-game<-rooms spiel--game)))
  (push "He's your average Greg. He milks things." (spiel-player<-status spiel--player))
  (delete-other-windows)
  (spiel--output-buffer)
  (spiel--input-buffer))

(provide 'greg)
;;; greg.el ends here
