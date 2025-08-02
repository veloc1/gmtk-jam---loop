enum BUILDING {
    MILL,
    CHURCH,
    FARM,
    PORTAL
}

function get_building_description(building) {
    var buildings = []
    buildings[BUILDING.MILL] = {
        object: obj_building_mill,
        resources: [RESOURCE.WIND, RESOURCE.EARTH],
        requirements: [new Req(RESOURCE.EARTH, 1), new Req(RESOURCE.WATER, 1)],
        enemies: []
    }
    buildings[BUILDING.FARM] = {
        object: obj_building_farm,
        resources: [RESOURCE.FIRE, RESOURCE.WATER],
        requirements: [new Req(RESOURCE.EARTH, 1), new Req(RESOURCE.WIND, 1)],
        enemies: []
    }
    buildings[BUILDING.CHURCH] = {
        object: obj_building_church,
        resources: [RESOURCE.WIND, RESOURCE.EARTH, RESOURCE.FIRE, RESOURCE.WATER],
        requirements: [],
        enemies: []
    }
    buildings[BUILDING.PORTAL] = {
        object: obj_building_portal,
        resources: [],
        requirements: [],
        enemies: []
    }
    return buildings[building]
}

function get_portal_requirements() {
    var reqs =  [
        [
            new Req(RESOURCE.EARTH, 3),
            new Req(RESOURCE.FIRE, 3),
            new Req(RESOURCE.WIND, 3),
            new Req(RESOURCE.WATER, 3),
            new Req(RESOURCE.SOUL, 5),
        ],
        [
            new Req(RESOURCE.EARTH, 10),
            new Req(RESOURCE.FIRE, 10),
            new Req(RESOURCE.WIND, 10),
            new Req(RESOURCE.WATER, 10),
            new Req(RESOURCE.SOUL, 30),
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