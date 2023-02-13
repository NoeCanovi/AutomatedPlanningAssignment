(define (domain emergency)

(:requirements :strips :typing :durative-actions)

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

(canact ?r - robot)             ; robot is free and can do actions
)

; actions

; move robot btw locations
(:durative-action move
    :parameters (?r - robot ?from ?to - location)
    :duration (= ?duration 2)
    :condition (and
        (at start (ratl ?r ?from))
        (at start (canact ?r))
    )
    :effect (and
        (at end (ratl ?r ?to))
        (at start (not (ratl ?r ?from)))
        (at start (not (canact ?r)))
        (at end (canact ?r))
    )
)


; robot loads a box if robot and box are in the same location
(:durative-action load
    :parameters (?r - robot ?b - box ?l - location ?c - carrier ?pl - place)
    :duration (= ?duration 1)
    :condition (and
        (over all (ratl ?r ?l))
        (over all (hascarrier ?r ?c))
        (over all (hasplace ?c ?pl))
        (over all (free ?pl))
        (at start (batl ?b ?l))
        (at start (canact ?r))
    )
    :effect (and
        (at start (not (batl ?b ?l)))
        (at end (not (free ?pl)))
        (at end (hasbox ?pl ?b))
        (at start (not (canact ?r)))
        (at end (canact ?r))
    )
)

; robot unloads a box at some location
(:durative-action unload
    :parameters (?r - robot ?b - box ?l - location ?c - carrier ?pl - place)
    :duration (= ?duration 1)
    :condition (and
        (over all (ratl ?r ?l))
        (over all (hascarrier ?r ?c))
        (over all (hasplace ?c ?pl))
        (at start (hasbox ?pl ?b))
        (at start (canact ?r))
    )
    :effect (and
        (at start (not (hasbox ?pl ?b)))
        (at start (free ?pl))
        (at end (batl ?b ?l))
        (at start (not (canact ?r)))
        (at end (canact ?r))
    )
)

; fill a box with a content, if the box is empty and the supply, the box and the agent are at the same location;
(:durative-action fill
    :parameters (?r - robot ?l - location ?b - box ?s - supply)
    :duration (= ?duration 2)
    :condition (and
        (over all (ratl ?r ?l))
        (over all (batl ?b ?l))
        (over all (satl ?s ?l))
        (at start (empty ?b))
        (at start (canact ?r))
    )
    :effect (and
        (at end (contain ?b ?s))
        (at end (not (empty ?b)))
        (at start (not (canact ?r)))
        (at end (canact ?r))
    )
)


; empty a box by leaving the content to the current location, and causing the people at the same location to have the content
(:durative-action give
    :parameters (?r - robot ?l - location ?b - box ?s - supply ?p - person)
    :duration (= ?duration 4)
    :condition (and
        (over all (ratl ?r ?l))
        (over all (batl ?b ?l))
        (over all (patl ?p ?l))
        (at start (contain ?b ?s))
        (at start (canact ?r))
    )
    :effect (and
        (at end (have ?p ?s))
        (at start (not (contain ?b ?s)))
        (at start (empty ?b))
        (at start (not (canact ?r)))
        (at end (canact ?r))
    )
)


)