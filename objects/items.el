;;; items.el --- item data  -*- lexical-binding: t -*-

;;; Commentary:
;;

(require 'spiel)

;;; Code:

(spiel-create-entity
 'item
 :capacity 1
 :description "a small wooden box"
 :names '("small box" "box")
 :adjectives '("small" "wooden")
 :location '(in  . pat))

(spiel-create-entity
 'item
 :capacity 0 :description "An unused candle"
 :names '("candle")
 :location '(in . small-box))

(spiel-create-entity
 'item
 :names '("Glasses" "Bifocals")
 :capacity 0 :description "A pair of trusty bifocals."
 :location '(in . greg)
 :actions (lambda (pattern)
            (pcase pattern
              ((and `("on" ,player) (guard (equal player spiel-player)))

               (let ((look (cl-find "look" spiel-verbs :key (lambda (v) (spiel-entity-name v)) :test #'equal)))
                 (setf (spiel-verb<-actions look)
                       (lambda (_) "Greg sees a giant thumb print."))
                 "Greg's vision improves marginally, but he also sees a giant vaseline thumb print.")))))


;;; items.el ends here
