enum RESOURCE {
    EARTH,
    FIRE,
    WATER,
    WIND,
    WOOD,
    SOUL,
}

function get_resource_sprite(resource) { 
    return [
        spr_earth,
        spr_fire,
        spr_water,
        spr_wind,
    ][resource]
}