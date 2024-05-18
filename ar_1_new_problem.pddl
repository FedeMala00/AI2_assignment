(define (problem serve-coffe-new)

    (:domain ar_1_new)

    (:objects
        
        ; LOCATIONS
        shelf closet sink stove

        ; CONTAINERS
        coffe_beans_container grinder moka water_tap filter coffe_powder_container spoon mug

        ; EDIBLE
        coffe_beans water coffe_powder 

        ; GRIPPERS
        right left

    )

    (:init
        ; OBJECTS declaration
        (LOCATION table) (LOCATION shelf) (LOCATION closet) (LOCATION sink) (LOCATION stove)
        (CONTAINER coffe_beans_container) (CONTAINER grinder) (CONTAINER moka) (CONTAINER water_tap) (CONTAINER filter) 
        (CONTAINER spoon) (CONTAINER mug)
        (EDIBLE coffe_beans) (EDIBLE water) 
        (GRIPPER right) (GRIPPER left)


        (EDIBLE coffe_powder) (CONTAINER coffe_powder_container) (inside spoon coffe_powder_container)
        ; (inside spoon grinder)

        ; PREDICATES declaration
        (at_loc coffe_beans_container closet) (at_loc grinder shelf) (at_loc moka table) (at_loc water_tap sink) (at_loc filter table) (at_loc coffe_powder_container shelf) (at_loc mug closet)
        (closed closet) (opened shelf) (opened table) (opened sink) (opened filter) (opened spoon) (opened mug)
        (closed coffe_beans_container) (closed grinder) (closed moka) (closed water_tap) (closed coffe_powder_container)
        (free right) (free left)
        (in coffe_beans coffe_beans_container) (in water water_tap) (in coffe_powder coffe_powder_container) 
        

        (is_closet closet) (is_grinder grinder) (is_sink sink) (is_water water) (is_filter filter) (is_tap water_tap) (is_moka moka) 
        (is_powder coffe_powder) (is_spoon spoon) (is_stove stove) (is_mug mug)
    )   

    (:goal 
        
        (and
            
        ; (at_loc coffe_beans_container table)
        ; (at_loc grinder table)
        ; (in coffe_beans grinder)
        ; (is_powder coffe_beans)
        ; (at_loc moka sink)
        ; (opened water_tap)
        ; (in water moka)
        ; (in coffe_powder spoon)
        ; (filter_levelled moka water filter coffe_powder spoon) 
        ; (moka_finished moka)
        ; (moka_untapped moka)
        (coffee_served mug)

        )
    )


)