;;; rooms.el --- Room data  -*- lexical-binding: t -*-

;;; Commentary:
;; 

(require 'spiel)

;;Dining Room
;;; Code:

(spiel-create-entity
 'room
 :names '("Dining Room")
 :description
 "Greg sits stiffly beside his girlfriend at a dinner table.
His potential in-laws sit at the ends of the table.
A doorway to the north leads to a hallway."
 :actions (lambda (pattern)
            (pcase pattern
              ('("north") 'lever-hall))))

;; Lever Hall
(spiel-create-entity
 'room
 :names '("Lever Hall")
 :description "A narrow room."
 :context '((room . t))
 :actions (lambda (pattern)
            (pcase pattern
              ('("south") 'dining-room))))

(spiel-create-entity 'item
                     :id 'lever-hall-wall
                     :location '(in . lever-hall)
                     :description "Along the back wall there are two levers."
                     :details "The wall has a green lever and a red lever."
                     :context '((immobile . t))
                     :names '("wall")
                     :adjectives '("back"))

(spiel-create-entity
 'item
 :id 'green-lever
 :location '(in . lever-hall)
 :names '("lever" "levers")
 :adjectives  '("green" "polished" "shiny")
 :details "The green lever has been recently polished."
 :context '((immobile . t))
 :actions (lambda (pattern)
            (pcase pattern
              ((or "pull" "use")
               (if (spiel-context-get 'green-lever 'pulled)
                   "The lever is already locked in a downard position."
                 (setf (spiel-context-get 'green-lever 'pulled) t)
                 "Greg pulls the lever. Gears whir below the floor.")))))

(spiel-create-entity
 'item
 :id 'red-lever
 :location '(in . lever-hall)
 :names '("lever" "levers")
 :adjectives  '("red" "rusty")
 :details
 "The red lever is incredibly rusty. It looks like it's hanging on by a thread."
 :actions
 (lambda (pattern)
   (pcase pattern
     ((or "pull" "use")
      (cond ((not (spiel-context-get 'green-lever 'pulled))
             (setf (spiel-object<-description (spiel-ensure-entity 'red-lever)) nil
                   (spiel-object<-description (spiel-ensure-entity 'lever-hall-wall))
                   "Along the back wall there is a green lever.")
             (setf (spiel-object<-details (spiel-ensure-entity 'red-lever))
                   "A broken, rusty lever. Seems dangerous.")
             (spiel-object-put 'in 'greg 'red-lever)
             "The red lever breaks off in Greg's hand.")
            (t "The red lever grinds downward."))))))

(spiel-create-entity
 'room
 :names '("Kitchen")
 :description "A nice kitchen.")

(spiel-create-entity
 'room
 :names  '("Study")
 :description "Cherry oak bookshelves filled with thousands of books line the walls.")

;;; rooms.el ends here
