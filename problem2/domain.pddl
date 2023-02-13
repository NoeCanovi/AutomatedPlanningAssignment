(define (domain emergency)

(:requirements :strips :typing)

(:types
location                    ; where person, robot, box and content can be
person                      ; person in need of help, is at a specific location
robot                       ; carries boxes to person, can move btw locations
carrier                     ; contains more boxes, it is part of the robot
place                       ; each carrier contain
box                         ; containts emergency supplies
food medicine tool - supply ; supplies to be brought to people
)

(:constants 
depot - location)

(:predicates
(patl ?p - person ?l - location)        ; person ?p is at location ?l
(ratl ?r - robot ?l - location)         ; robot ?r is at location ?l
(batl ?b - box ?l - location)           ; box ?b is at location ?l
(satl ?s - supply ?l - location)        ; supply ?s is at location ?l

(hascarrier ?r - robot ?c - carrier)                ; robot ?r has carrier ?c
(hasplace ?c - carrier ?pl - place)                 ; carrier ?c has space ?pl
(hasbox ?pl - place ?b - box)              ; place ?pl has a box ?b
(free ?pl - place)                         ; place ?pl is free


(contain ?b - box ?s - supply)          ; box ?b contains supply ?s
(empty ?b - box)                        ; box ?b is empty

(have ?p - person ?s - supply)          ; person ?p has supply ?s
)

; actions

; move robot btw locations
(:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (ratl ?r ?from))
    :effect (and (ratl ?r ?to) (not (ratl ?r ?from)))
)

; robot loads a box if robot and box are in the same location
(:action load
    :parameters (?r - robot ?b - box ?l - location ?c - carrier ?pl - place)
    :precondition (and (ratl ?r ?l) (batl ?b ?l) (hascarrier ?r ?c) (hasplace ?c ?pl) (free ?pl))
    :effect (and (hasbox ?pl ?b) (not (free ?pl)) (not (batl ?b ?l)))
)

; robot unloads a box at some location
(:action unload
    :parameters (?r - robot ?b - box ?l - location ?c - carrier ?pl - place)
    :precondition (and (ratl ?r ?l) (hascarrier ?r ?c) (hasplace ?c ?pl) (hasbox ?pl ?b))
    :effect (and (batl ?b ?l) (free ?pl) (not (hasbox ?pl ?b)))
)

; fill a box with a content, if the box is empty and the supply, the box and the agent are at the same location;
(:action fill
    :parameters (?r - robot ?l - location ?b - box ?s - supply)
    :precondition (and (empty ?b) (ratl ?r ?l) (batl ?b ?l) (satl ?s ?l))
    :effect (and (contain ?b ?s) (not (empty ?b)))
)

; empty a box by leaving the content to the current location, and causing the people at the same location to have the content
(:action give
    :parameters (?r - robot ?l - location ?b - box ?s - supply ?p - person)
    :precondition (and (ratl ?r ?l) (batl ?b ?l) (contain ?b ?s) (patl ?p ?l))
    :effect (and (have ?p ?s) (empty ?b) (not (contain ?b ?s)))
)


)