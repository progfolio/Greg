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

;;; items.el ends here
