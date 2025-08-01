enum GROUND {
    NORMAL,
    CORRUPTED,
}



enum ENEMY {
    SCARECROW,
}

function Segment() constructor {
    ground = GROUND.NORMAL
    ground_resources = []
    building = undefined
    enemy = undefined
}