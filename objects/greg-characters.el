;;; greg-characters.el --- character data            -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Nicholas Vollmer

;; Author: Nicholas Vollmer
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

;;

;;; Code:
(require 'greg)

;;@MAYBE set current buffer to greg-buffer so interactive reload works

(spiel-create-entity
 'actor
 :capacity 5
 :names '("Greg")
 :avatar `(image :type png
                  :file ,(expand-file-name "./assets/greg.png" greg--directory)
                  :scale 0.85 :ascent 100 :relief -2)
 :location '(in . dining-room)
 :description "A nice enough guy"
 :details "Greg looks terrified and overconfident at the same time. It's sickening."
 :actions (lambda (pattern)
            (pcase pattern ("take" "Greg shudders at the thought."))))

(defun greg--dinner-scene-1 ()
  "Dinner Scene 1."
  (setq spiel-pending-question nil)
  (spiel-object-give 'study 'dad)
  (spiel-object-give 'kitchen 'mom 'girlfriend)
  (spiel-say 'dad "\"Sure")
  (let ((spiel-type-delay 0.2))
    (dotimes (_ 3) (spiel-print "."))
    (spiel-print "\""))
  (spiel-print "\n\n" "The tension in the air is ")
  (let ((spiel-type-delay 0.08))
    (spiel-print (propertize "palpable" 'face '(:slant italic))))
  (spiel-print "." "\n")
  (spiel-say 'dad
            "\"Dina, my love, dinner was delicious! \
I'd love to help with the dishes, but I've got to get to my study. \
Greg, I'd like to speak with you there. \
Pat, escort him when he's ready.\"")
  (spiel-say 'pat "\"As you wish, sir.\"")
  (spiel-say 'mom "\"Well if your old man can't help, why don't you give me a hand, Pam?\"")
  (spiel-say 'girlfriend "\"Sure thing, Mom!\"")
  (spiel-print "\n\n")
  (spiel-add-time 120)
  (setf (spiel-object<-description (spiel-ensure-entity 'dining-room))
        "An empty dining room. A doorway to the north leads to a hallway."))

(defun greg--dad-do (pattern)
  "Dad's actions for PATTERN."
  (pcase pattern
    (`(,(and (pred spiel-question-p) question) ,response)
     (pcase (spiel-question<-id question)
       ('could-you-milk-me?
        (pcase (downcase (or (car response) ""))
          ((or "yes" "1")
           (greg--dinner-scene-1)
           (spiel-print (greg--context-string) "\n" (spiel-room-description) "\n"))
          ((or "no" "2")
           (setq spiel-pending-question nil)
           (spiel-say 'dad "GAME OVER! You lose.")
           (sit-for 1)
           (spiel-reset))
          (_ (if (zerop (cl-decf (spiel-context-get 'dad 'patience)))
                 (progn (spiel-say 'dad "You win. I'm out.")
                        (sit-for 1)
                        (spiel-reset))
               (spiel-say 'dad "\"It's a simple \"yes\" or \"no\" question, Greg.\"")))))))))

(spiel-create-entity
 'actor
 :id 'dad :capacity 0
 :names '("dad" "father")
 :adjectives '("girlfriend's")
 :context '((patience . 2))
 :avatar `(image :file ,(expand-file-name "./assets/dad.png" greg--directory)
                 :type png :scale 0.85 :ascent 100 :relief -2)

 :location '(in . dining-room)
 :actions #'greg--dad-do)

(spiel-create-entity
 'actor
 :id 'mom :capacity 0
 :names '("mom" "mother")
 :adjectives '("girlfriend's")
 :avatar `(image :file ,(expand-file-name "./assets/mom.png" greg--directory)
                 :type png :scale 0.85 :ascent 100 :relief -2)
 :location '(in  . dining-room)
 :details "Greg's girlfriend's mom looks hospitable, but there's a hint of doubt in her eyes.")

(spiel-create-entity
 'actor
 :id 'girlfriend :capacity 0
 :names '("girlfriend" "daughter" "greg's girlfriend")
 :avatar `(image :file ,(expand-file-name "./assets/girlfriend.png" greg--directory)
                 :type png :scale 0.85 :ascent 100 :relief -2)
 :location '(in 'dining-room)
 :details "Greg's girlfriend is as average as he is, which is very much so.")

(spiel-create-entity
 'actor
 :id 'pat :capacity 2 :names '("butler")
 :adjectives '("sweaty" "jaundiced" "yellow")
 :description "A butler stands in the corner."
 :details "He looks like he has jaundice and is very sweaty."
 :avatar `(image :file ,(expand-file-name "./assets/butler.png" greg--directory)
                 :type png :scale 0.85 :ascent 100 :relief -2)
 :location '(in . dining-room))

;;; greg-characters.el ends here
