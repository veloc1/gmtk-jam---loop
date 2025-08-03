enum BUILDING {
    MILL,
    CHURCH,
    FARM,
    QUARRY,
    NECROPOL,
    VILLAGE,
    PORTAL,
    RUIN,
}

function get_building_description(building) {
    var buildings = []
    buildings[BUILDING.MILL] = {
        object: obj_building_mill,
        name: "Mill",
        resources: [new ResCount(RESOURCE.WIND, 2), new ResCount(RESOURCE.EARTH, 1)],
        requirements: [new ResCount(RESOURCE.EARTH, 1), new ResCount(RESOURCE.WATER, 1)],
        enemies: [ENEMY.SCARECROW],
        is_endless: false,
        lifetime: 2,
    }
    buildings[BUILDING.FARM] = {
        object: obj_building_farm,
        name: "Farm",
        resources: [new ResCount(RESOURCE.FIRE, 1), new ResCount(RESOURCE.WATER, 1)],
        requirements: [new ResCount(RESOURCE.EARTH, 1), new ResCount(RESOURCE.WIND, 1)],
        enemies: [],
        is_endless: false,
        lifetime: 2,
    }
    buildings[BUILDING.QUARRY] = {
        object: obj_building_quarry,
        name: "Quarry",
        resources: [new ResCount(RESOURCE.EARTH, 2), new ResCount(RESOURCE.FIRE, 3)],
        requirements: [new ResCount(RESOURCE.EARTH, 2), new ResCount(RESOURCE.FIRE, 1)],
        enemies: [ENEMY.GOLEM],
        is_endless: false,
        lifetime: 3,
    }
    buildings[BUILDING.NECROPOL] = {
        object: obj_building_necropol,
        name: "Necropol",
        resources: [new ResCount(RESOURCE.SOUL, 5)],
        requirements: [new ResCount(RESOURCE.EARTH, 2), new ResCount(RESOURCE.WATER, 5)],
        enemies: [ENEMY.GHOST],
        is_endless: false,
        lifetime: 2,
    }
    buildings[BUILDING.VILLAGE] = {
        object: obj_building_village,
        name: "Village",
        resources: [new ResCount(RESOURCE.RANDOM_ENERGY, 5)],
        requirements: [new ResCount(RESOURCE.EARTH, 5), new ResCount(RESOURCE.WATER, 5), new ResCount(RESOURCE.FIRE, 2), new ResCount(RESOURCE.WIND, 2)],
        enemies: [ENEMY.CROW, ENEMY.WOLF],
        is_endless: false,
        lifetime: 2,
    }
    
    
    buildings[BUILDING.CHURCH] = {
        object: obj_building_church,
        name: "Church",
        resources: [new ResCount(RESOURCE.WIND, 2), new ResCount(RESOURCE.EARTH, 2), new ResCount(RESOURCE.FIRE, 2), new ResCount(RESOURCE.WATER, 2)],
        requirements: [],
        enemies: [],
        is_endless: true,
        lifetime: 0,
    }
    buildings[BUILDING.PORTAL] = {
        object: obj_building_portal,
        name: "Portal",
        resources: [],
        requirements: [],
        enemies: [],
        is_endless: true,
        lifetime: 0,
    }
     
    return buildings[building]
}

function get_portal_requirements() {
    var reqs =  [
        [
            new ResCount(RESOURCE.EARTH, 5),
            new ResCount(RESOURCE.FIRE, 3),
            new ResCount(RESOURCE.WIND, 3),
            new ResCount(RESOURCE.WATER, 3),
            new ResCount(RESOURCE.SOUL, 5),
        ],
        [
            new ResCount(RESOURCE.EARTH, 30),
            new ResCount(RESOURCE.FIRE, 10),
            new ResCount(RESOURCE.WIND, 10),
            new ResCount(RESOURCE.WATER, 10),
            new ResCount(RESOURCE.SOUL, 30),
        ],
        []
    ]
    
    if (obj_run_state.portal_status == "broken") {
        return reqs[0]
    } else if (obj_run_state.portal_status == "in progress") {
        return reqs[1]
    } else {
        return reqs[2]
    }
}