;; -*- lexical-binding: t; -*-
(require 'greg)

(spiel-create-entity
 'actor
 :id 'greg
 :names '("You")
 :capacity '((in . 5) (on . 5))
 :location '(in . room))

(spiel-create-entity
 'room
 :names '("Room")
 :description
 "You are in a test room.")

(spiel-create-entity
 'item
 :id 'counter
 :names '("counter")
 :description "A fancy counter lines the back wall."
 :details "It's fancy."
 :adjectives '("fancy")
 :context '((immobile . t))
 :capacity '((on . 4))
 :location '(in . room))

(spiel-create-entity
 'item
 :names '("box")
 :adjectives '("black")
 :description "A black box is on the counter."
 :details "The box has a label on the bottom which reads: \"FROTH-3782xvj\".
There is a price tag sticker, but it's been scribbled over with a marker."
 :context '((closed . t))
 :capacity '((in . 5))
 :size 5
 :location '(in . room)
 :order 1)

(spiel-create-entity
 'item
 :names '("wand")
 :adjectives '("metallic" "froth")
 :details "A six inch stainless steel wand with several markings on it."
 :location '(in . box))

(spiel-create-entity
 'item
 :names '("unit")
 :adjectives '("plastic" "froth")
 :details "The main unit of the machine is an off-white, plastic box with rounded corners.
There are several ports on its face: one to the left, center, and right.
It has a hole on the top as well."
 :location '(in . box))

(spiel-create-entity
 'item
 :names '("hopper")
 :adjectives '("plastic" "bean" "clear")
 :details "A clear plastic bean hopper.
It has a bright red sticker with a skull and cross bones on it which reads:
\"Do NOT overfill!\""
 :location '(in . box))

(spiel-create-entity
 'item
 :names '("screen")
 :adjectives '("LCD")
 :details "A rectangular LCD screen framed in off-white plastic.
The word \"Frothbot\" is embossed in the top of the frame.
The bottom of the frame has a cutout in the shape of a bow-tie housing a small light."
 :location '(in . box))

(spiel-create-entity
 'item
 :names '("manual")
 :details "The manual looks to be about three hundred pages long.
There's a logo of a grey-faced robot with a red bow-tie on the cover.
Its giving a thumbs up while barfing what appears to be steamed milk."
 :location '(in . box))

(defun greg-frothbot-intro ()
  "Frothbot intro."
  (spiel-print (spiel-room-description) "\n")
  (spiel-insert-prompt spiel-pending-question))

(setq-local greg--post-init-hook #'greg-frothbot-intro)
