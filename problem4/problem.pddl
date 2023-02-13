(define (problem part4) (:domain emergency)
(:objects
 l1 l2 l3 - location
 p1 p2 p3 - person 
 r1 - robot
 c1 - carrier
 pl1 pl2 pl3 pl4 - place
 b1 b2 b3 b4 - box
 f - food
 m - medicine
 t - tool
)

(:init
    ; robot, boxes and supply are at the same location (depot)
    (ratl r1 depot)
    (batl b1 depot)
    (batl b2 depot)
    (batl b3 depot)
    (batl b4 depot)
    (satl f depot)
    (satl m depot)
    (satl t depot)

    ; robot has carrier, carrier has places
    (hascarrier r1 c1)
    (hasplace c1 pl1)
    (hasplace c1 pl2)
    (hasplace c1 pl3)
    (hasplace c1 pl4)

    ; places and box are empty
    (free pl1)
    (free pl2)
    (free pl3)
    (free pl4)

   
    (empty b1)
    (empty b2)
    (empty b3)
    (empty b4)

    ; location of people
    (patl p1 l2)
    (patl p2 l2)
    (patl p3 l3)

    (canact r1)


)

(:goal (and
    (have p1 f)
    (have p2 f)
    (have p2 t)
    (have p3 m)
))

)
