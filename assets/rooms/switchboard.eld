( :title "Switchboard Room"
  :id switchboard
  :vars ((door . locked)
         (cable . unseen)
         (candle . t))
  :description
  (lambda ()
    (string-join
     `("Greg stands in a test room."
       "On the wall before him is an old switchboard with different colored plugs."
       "In the corner of the room is a cardboard box labeled \"Yellow\"."
       ,@(when (spiel--room-var 'candle) '("A candle sits on the floor."))
       ,(format "Behind him, on the south wall, is a %sdoor."
                (if (eq (spiel--room-var 'door) 'locked) "locked " "")))
     "\n"))
  :items
  (("candle"
    ("look" "The candle looks as if it has never been lit.")
    ("take"
     (setf (spiel--room-var 'candle) nil)
     (spiel--set-room-item "candle")
     (spiel--get 'candle "an unlit candle")))
   ("switchboard"
    ("look"
     "The switchboard has a row of outputs and, below that, a row of inputs.
Each input is labeled with a different color.")
    ("use"
     (lambda (tokens)
       (cond
        ((and (member "candle" tokens) (spiel--has-p 'candle))
         "Greg holds the candle up to the switchboard. Nothing happens.")
        ((and (member "cable" tokens) (spiel--has-p 'cable))
         (setf (spiel--room-var 'door) 'unlocked)
         (spiel--use 'cable)
         "Greg plugs one end of the yellow cable into the input labeled \"yellow\" and the other into the matching output.
Behind him, the door's lock clicks.")
        ((not tokens) "Greg paws at the switchboard dumbly. Nothing happens.")
        (t "Greg scratches his head, unsure what to do."))))
    ("take" "It's mounted to the wall. Greg gives it his all but only farts."))
   ("door"
    ("take"
     (if (eq (spiel-player<-status spiel--player) 'shat)
         "Greg considers violence on the door again, but the warmth in his undies disuades him."
       (setf (spiel-player<-status spiel--player) 'shat)
       (setf (alist-get 'shat spiel--statuses) "Greg is frowning. He's shat himself.")
       "Greg squeezes his fingers around the frame of the door. He pulls with all his might. He shits himself. The door does not."))
    ("look"
     (format "A door with a sign which reads: %S" (if (eq (spiel--room-var 'door) 'locked) "locked" "unlocked")))
    ("use" (if (eq (spiel--room-var 'door) 'locked)
               "The door is locked. Won't budge."
             (spiel--print "The door creaks open...\n")
             (spiel--go 'dining-room))))
   ("box"
    ("take" "Greg can't fit the box in his backpack.")
    ("look"
     (if (spiel--has-p 'cable)
         "The box is empty."
       (spiel--set-room-item "cable"
         ("look"
          "It's a yellow switchboard patch cable. Slightly frayed, but it may still work.")
         ("take" (spiel--get 'cable "a yellow switchboard cable")))
       "The box contains a yellow switchboard cable.")))
   ("north"
    ("go" "Greg stands before the switchboard.")
    ("look" "The switchboard looms before Greg."))
   ("south"
    ("go" (if (eq (spiel--room-var 'door) 'locked)
              "The door is locked. Can't go farther south."
            (spiel--parse-command "use door" 'noprint))))))
