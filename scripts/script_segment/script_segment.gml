enum GROUND {
    NORMAL,
    CORRUPTED,
}


function Segment() constructor {
    ground = GROUND.NORMAL
    ground_resources = []
    building = undefined
    building_lifetime = 0
    has_ruins = false
    necropol_exclusive = false
    enemy = undefined
    event = undefined
}