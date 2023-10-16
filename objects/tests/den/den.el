;; -*- lexical-binding: t; -*-
(require 'greg)

(spiel-create-entity
 'actor
 :id 'greg
 :names '("You")
 :details "You look focused on the game before you."
 :capacity '((in . 5) (on . 5))
 :location '(in . den))

(spiel-create-entity
 'room
 :names '("Den")
 :description
 "You are in the family den.
Dark oak paneled walls flow from the ceiling to a rich burgundy carpet.")

(spiel-create-entity
 'item
 :names '("couch" "sofa")
 :adjectives '("three-seater" "burgundy" "plaid")
 :description "A comfortable-looking three-seater couch sits against the wall."
 :details "It's a burgundy couch, with a slight plaid pattern. The cushions are plush and inviting."
 :context '((immobile . t))
 :capacity '((on . 3))
 :location '(in . den)
 :order 1)

(spiel-create-entity
 'item
 :id 'left-cushion
 :names '("cushion")
 :details "It looks like it's never been sat on."
 :adjectives '("left" "plush")
 :location '(on . couch))

(spiel-create-entity
 'item
 :id 'middle-cushion
 :names '("cushion")
 :details "It's worn and saggy."
 :adjectives '("middle" "plush")
 :location '(on . couch))

(spiel-create-entity
 'item
 :id 'right-cushion
 :names '("cushion")
 :adjectives '("right" "plush")
 :details "Spare what appears to be a light powdery stain, it looks like it's in good shape."
 :location '(on . couch))

(spiel-create-entity
 'item
 :names '("TV" "television")
 :adjectives '("widescreen" "fancy" "mounted")
 :description "A widescreen TV is mounted on the wall opposite the couch."
 :details "This is an awfully fancy TV.
You could never afford something like this on your male nurse's salary."
 :context '((immobile . t))
 :location '(in . den)
 :order 2)

(spiel-create-entity
 'item
 :names '("shelf")
 :description "An open shelf beneath the TV displays a row of DVDs."
 :context '((immobile . t))
 :capacity '((on . 3))
 :location '(in . den)
 :order 3)

(spiel-create-entity
 'item
 :names '("player")
 :adjectives '("DVD")
 :description "A DVD player rests on a shelf beneath the TV."
 :details "It's a DVD player. A button on the top appears to open the tray."
 :context '((immobile . t))
 :capacity '((in . 1))
 :location '(on . shelf))

(spiel-create-entity
 'item
 :names '("stand")
 :adjectives '("plastic")
 :description "There is a plastic stand next to the TV holding goggles of some sort."
 :context '((immobile . t))
 :capacity '((on . 1))
 :location '(in . den)
 :order 4)

(spiel-create-entity
 'item
 :names '("goggles" "glasses")
 :adjectives '("3D")
 :description "A pair of state-of-the-art looking 3D goggles sit on a plastic stand next to the TV."
 :details "These seem to be some high-tech 3D glasses taht go with the TV.
Your prospective father-in-law must be well connected to have bleeding edge technology like this."
 :location '(on . stand)
 :context '((wearable . t)))

(spiel-create-entity
 'item
 :names '("fireplace")
 :description "Against the far wall is an unlit fireplace, flanked by a large tiger-skin rug."
 :context '((immobile . t))
 :capacity '((in . 1))
 :location '(in . den)
 :order 5)

(spiel-create-entity
 'item
 :names '("rug")
 :adjectives '("tiger-skin")
 :details "A full-length tiger-skin rug. At one end, the head appears to growl at you menacingly. A striped tail curls around one leg of the sofa."
 :context '((immobile . t))
 :capacity '((on . 1))
 :location '(in . den))

(defun greg-den-intro ()
  "Den intro."
  (spiel-print (spiel-room-description) "\n")
  (spiel-insert-prompt spiel-pending-question))

(setq-local greg--post-init-hook #'greg-den-intro)
