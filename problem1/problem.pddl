(define (problem part1) (:domain emergency)
(:objects
 l1 l2 l3 - location
 p1 p2 p3 - person 
 r1 - robot
 b1 b2 b3 b4 - box
 f - food
 m - medicine
 t - tool

)

(:init
    ; robot, boxes and supply are at the same location (depot)
    (ratl r1 depot)
    (batl b1 depot)
    (satl f depot)
    (satl m depot)
    (satl t depot)

    ; robot and box are empty
    (unloaded r1)
    (empty b1)

    ; location of people
    (patl p1 l2)
    (patl p2 l2)
    (patl p3 l3)

)

(:goal (and
    (have p1 f)
    (have p2 f)
    (have p2 t)
    (have p3 m)
))

)
