;; -*- lexical-binding: t; -*-
(require 'spiel)

(spiel-create-entity
 'room
 :names '("Gym")
 :description "An area to test in.")

(spiel-create-entity
 'item
 :names '("desk")
 :description "An oak desk is in the middle of the room."
 :details "The desk looks ancient."
 :adjectives '("oak")
 :actions
 nil
 ;; (lambda (pattern)
 ;;   (message "PATTERN: %S" pattern)
 ;;   (pcase pattern ("look" "It has a drawer on its face.")))
 :context '((immobile . t))
 :capacity '((on . 4))
 :location '(in . gym))

(spiel-create-entity
 'item
 :names '("apple")
 :description "A green apple."
 :adjectives '("green")
 :location '(on . desk)
 :size 2)

(spiel-create-entity
 'item
 :names '("banana")
 :description "A yellow banana."
 :adjectives '("yellow")
 :location '(on . desk)
 :size 2)

(spiel-create-entity
 'item
 :names '("drawer")
 :description "An unlocked drawer."
 :adjectives '("oak")
 :context '((immobile . t)
            (closed . t))
 :location '(in . desk)
 :capacity '((in . 3)))

(spiel-create-entity
 'item
 :names '("key")
 :description "A key."
 :adjectives '("copper")
 :description "A small copper key is here."
 :details
 "The head of the key is shaped like a skull.
Its blade and ridges make for a rusty spine."
 :location '(in . drawer))

(spiel-create-entity
 'actor
 :names '("Greg")
 :description "A test guy."
 :capacity '((in . 10) (on . 5))
 :location '(in . gym))

(defun greg-load-test--intro ()
  "Test loading."
  (spiel-print (spiel-room-description) "\n")
  (spiel-insert-prompt spiel-pending-question))

(setq-local greg--post-init-hook (list #'greg-load-test--intro))
