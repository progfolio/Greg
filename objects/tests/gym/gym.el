;; -*- lexical-binding: t; -*-
(require 'spiel)

(spiel-create-entity
 'room
 :names '("Gym")
 :description "An area to test in.")

(spiel-create-entity
 'item
 :id 'coin
 :names '("coin")
 :description "A coin is showing \
%(or (spiel-context-get it 'side)
     (setf (spiel-context-get it 'side) (if (eq (random 2) 1) 'heads 'tails)))."
 :location '(in . gym)
 :actions (lambda (pattern)
            (pcase pattern
              ("take" (when (eq (spiel-context-get spiel-self 'side) 'heads)
                        (spiel-print "\nYou feel luckier."))
               (setf (spiel-object<-description spiel-self) "A coin.")
               nil))))

(spiel-create-entity
 'item
 :id 'desk
 :names '("desk")
 :description "An oak desk is in the middle of the room."
 :details "The %(spiel-entity-name it) looks %(if (eq (random 2) 1) \"cool\" \"uncool\")."
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
 :description (lambda () (if (spiel-flagged-p spiel-self 'closed)
                             "A closed drawer."
                           "An open drawer."))
 :adjectives '("oak")
 :context '((immobile . t)
            (closed . t))
 :location '(in . desk)
 :capacity '((in . 3)))

(spiel-create-entity
 'item
 :names '("key")
 :description "A key."
 :adjectives '("gold")
 :description "A small gold key is here."
 :details
 "The head of the key is shaped like a skull.
Its blade and ridges make for a rusty spine."
 :location '(in . drawer))

(spiel-create-entity
 'actor
 :names '("Greg")
 :description "%(spiel-entity-name it) is a test guy."
 :capacity '((in . 10) (on . 5))
 :location '(in . gym))

(defun greg-load-test--intro ()
  "Test loading."
  (spiel-print "Welcome to the gym.\n")
  (spiel-print (propertize "press any key to begin...\n\n" 'face 'spiel-command-context))
  (spiel-wait-for-key
   (spiel-print (spiel-room-description) "\n")
   (spiel-print "hold on...\n")
   (spiel-wait-for-key
    (spiel-print "This is a nested wait.\n")
    (spiel-insert-prompt spiel-pending-question))))

(setq-local greg--post-init-hook (list #'greg-load-test--intro))
