;; -*- lexical-binding: t; -*-
(require 'spiel)

(spiel-create-entity
 'room
 :names '("Test Room")
 :description "A test room.")

(spiel-create-entity
 'actor
 :names '("Greg")
 :description "A test guy."
 :location '(in . test-room))

(defun greg-load-test--intro ()
  "Test loading."
  (spiel-print (spiel-room-description) "\n")
  (spiel-insert-prompt spiel-pending-question))

(setq-local greg--post-init-hook (list #'greg-load-test--intro))
