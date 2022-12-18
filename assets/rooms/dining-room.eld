( :title "The Dining Room"
  :id dining-room
  :description
  "Greg enters a dining room.
A large table in the center of the room is set for what appears to be a formal dinner.
To the north, a door leads to the switchboard room."
  :items
  (("door"
    ("look" "The door has a sign which reads: \"unlocked\".")
    ("use" (spiel--parse-command "go north" 'noprint)))
   ("table"
    ("look"
     (spiel--set-room-item "candelabra"
       ("look" "The candelabra normally holds 3 candles. The center candle is missing.")
       ("take" "The candelabra is bolted to the table. Two of its candles are firmly set.")
       ("use" (lambda (tokens)
                (cond
                 ((member "candle" tokens)
                  (if (spiel--has-p 'candle)
                      (progn
                        (spiel--use 'candle)
                      "Greg sets the candle in the center of the candelabra.
The entire room begins to shake!"
                    "Greg does not have a candle."))
                 (t (spiel--parse-command "take candelabra" 'noprint))))))
     "The table is ornately set. The centerpiece is a fancy candelabra, missing a candle."))
   ("north"
    ("go"
     (spiel--print "Greg passes through the northern door...\n")
     (spiel--go 'switchboard))
    ("look" "The door to the switchboard room is slightly ajar."))
   ("south")))
