(define (domain ar_1_new)

(:requirements :strips :negative-preconditions :existential-preconditions :disjunctive-preconditions :equality)

(:constants
    
    table - LOCATION

)

(:predicates
    (LOCATION ?l) (CONTAINER ?c) (EDIBLE ?e) (GRIPPER ?g)
    (at_loc ?c ?l) (free ?g)  (closed ?l) (opened ?l)
    (holding ?g ?c) (in ?e ?c) (on ?c) (inside ?c1 ?c2)
    (moka_full ?c1 ?e1 ?c2 ?e2) (filter_levelled ?c1 ?e1 ?c2 ?e2 ?c3) (moka_ready ?c) (moka_finished ?c)
    (moka_untapped ?C) (coffee_served ?c) (containing ?e)
    
    (is_closet ?l) (is_grinder ?c) (is_powder ?e) (is_sink ?l) (is_water ?e) (is_filter ?c)
    (is_tap ?c) (is_moka ?c) (is_spoon ?c) (is_stove ?l) (is_mug ?c) (is_fridge ?l)
)


(:action pick_up
    :parameters (?g ?c ?l)
    :precondition (and (GRIPPER ?g) (CONTAINER ?c) (LOCATION ?l) (free ?g) (at_loc ?c ?l) (or (not (closed ?l)) (opened ?l)) (or (not (= ?c moka)) (opened ?c)))
    :effect (and (not (free ?g)) (not (at_loc ?c ?l)) (holding ?g ?c))
)

(:action open_furniture
    :parameters (?g ?l)
    :precondition (and (GRIPPER ?g) (LOCATION ?l) (or (is_closet ?l) (is_fridge ?l)) (free ?g) (closed ?l))
    :effect (and (not (closed ?l)) (opened ?l))
)

(:action put_down
    :parameters (?g ?c ?l)
    :precondition (and (GRIPPER ?g) (CONTAINER ?c) (LOCATION ?l) (holding ?g ?c))
    :effect (and (free ?g) (at_loc ?c ?l) (not (holding ?g ?c)))
)

(:action unscrew
    :parameters (?c)
    :precondition (and (CONTAINER ?c) (closed ?c) (at_loc ?c table))
    :effect (and (not (closed ?c)) (opened ?c) (at_loc ?c table))
)
 
(:action pour
    :parameters (?e ?c1 ?c2 ?g)
    :precondition (and (EDIBLE ?e) (CONTAINER ?c1) (CONTAINER ?c2) (GRIPPER ?g) (at_loc ?c2 table) (at_loc ?c1 table) (in ?e ?c1) (opened ?c1) (opened ?c2) (not (is_water ?e)))
    :effect (and (in ?e ?c2) (not (in ?e ?c1)))
)

(:action switch_on_grinder
    :parameters (?c ?e)
    :precondition (and (CONTAINER ?c) (EDIBLE ?e) (is_grinder ?c) (at_loc ?c table) (in ?e ?c) (not (is_water ?e)))
    :effect (and (on ?c))
)

(:action switch_off_grinder
    :parameters (?c ?e)
    :precondition (and (CONTAINER ?c) (EDIBLE ?e) (is_grinder ?c) (at_loc ?c table) (in ?e ?c) (on ?c))
    :effect (and (not (on ?c)) (is_powder ?e))
)

(:action open_tap
    :parameters (?c ?l)
    :precondition (and (CONTAINER ?c) (closed ?c) (at_loc ?c ?l) (is_sink ?l) (is_tap ?c))
    :effect (and (opened ?c) (not (closed ?c)))
)

(:action fill_moka
    :parameters (?c1 ?c2 ?e ?l)
    :precondition (and (CONTAINER ?c1) (EDIBLE ?e) (LOCATION ?l) (in ?e ?c1) (at_loc ?c2 ?l) (is_water ?e) (opened ?c1) (opened ?c2) (is_sink ?l) (is_moka ?c2))
    :effect (and (not (in ?e ?c1)) (in ?e ?c2))
)

(:action insert_filter
    :parameters (?c1 ?c2 ?e)
    :precondition (and (CONTAINER ?c1) (CONTAINER ?c2) (at_loc ?c1 table) (at_loc ?c2 table) (is_water ?e) (in ?e ?c1) (is_filter ?c2))
    :effect (and (inside ?c1 ?c2))
)

(:action take_full_spoon
    :parameters (?c1 ?c2 ?e)
    :precondition (and (CONTAINER ?c1) (CONTAINER ?c2) (EDIBLE ?e) (at_loc ?c2 table) (is_powder ?e) (inside ?c1 ?c2) (opened ?c1) (opened ?c2) (is_spoon ?c1))
    :effect (and (in ?e ?c1)) 
)

(:action fill_filter
    :parameters (?c1 ?e1 ?c2 ?e2 ?c3)
    :precondition (and (CONTAINER ?c1) (CONTAINER ?c2) (CONTAINER ?c3) (EDIBLE ?e1) (EDIBLE ?e2) (at_loc ?c1 table) (at_loc ?c2 table) (is_water ?e1) (in ?e1 ?c1) (is_filter ?c2) (is_powder ?e2) (inside ?c1 ?c2) (is_filter ?c2) (is_spoon ?c3) (in ?e2 ?c3) (opened ?c1) (opened ?c2))
    :effect (and (moka_full ?c1 ?e1 ?c2 ?e2))
)

(:action level_coffee
    :parameters (?c1 ?e1 ?c2 ?e2 ?c3)
    :precondition (and (CONTAINER ?c1) (CONTAINER ?c2) (CONTAINER ?c3) (EDIBLE ?e1) (EDIBLE ?e2) (at_loc ?c1 table) (at_loc ?c2 table) (is_water ?e1) (in ?e1 ?c1) (is_filter ?c2) (is_powder ?e2) (inside ?c1 ?c2) (is_filter ?c2) (is_spoon ?c3) (in ?e2 ?c3) (opened ?c1) (opened ?c2) (moka_full ?c1 ?e1 ?c2 ?e2))
    :effect (and (filter_levelled ?c1 ?e1 ?c2 ?e2 ?c3) (moka_ready ?c1))
)

(:action screw
    :parameters (?c)
    :precondition (and (CONTAINER ?c) (opened ?c) (moka_ready ?c) (at_loc ?c table))
    :effect (and (closed ?c))
)

(:action turn_on_stove
    :parameters (?c ?l)
    :precondition (and (CONTAINER ?c) (is_moka ?c) (moka_ready ?c) (closed ?c) (at_loc ?c ?l) (is_stove ?l))
    :effect (and (moka_finished ?c))
)

(:action untap_moka
    :parameters (?c)
    :precondition (and (CONTAINER ?c) (is_moka ?c) (moka_finished ?c) (at_loc ?c table))
    :effect (and (moka_untapped ?c))
)

(:action serve_coffee
    :parameters (?c1 ?c2)
    :precondition (and (CONTAINER ?c1) (CONTAINER ?c2) (is_moka ?c1) (moka_untapped ?c1) (at_loc ?c1 table) (at_loc ?c2 table) (is_mug ?c2))
    :effect (and (coffee_served ?c2))
)

(:action add_ingridient
    :parameters (?c1 ?c2 ?e)
    :precondition (and (CONTAINER ?c1) (CONTAINER ?c2) (EDIBLE ?e) (at_loc ?c1 table) (at_loc ?c2 table) (is_mug ?c1) (coffee_served ?c1) (opened ?c2) (in ?e ?c2))
    :effect (and (containing ?e))
)


)