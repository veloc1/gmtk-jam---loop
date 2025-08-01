enum BUILDING {
    MILL,
}

function get_building_description(building) {
    var buildings = []
    buildings[BUILDING.MILL] = {
        resources: [RESOURCE.WIND, RESOURCE.EARTH],
        enemies: []
    }
    return buildings[building]
}