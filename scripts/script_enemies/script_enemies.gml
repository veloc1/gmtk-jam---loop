enum ENEMY {
    CROW,
    WOLF,
    ZOMBIE,
    ZOMBIE_SKEL,
    ZOMBIE_ASH,
    ZOMBIE_ROCK,
    ZOMBIE_SWAMP,
    SCARECROW,
    GOLEM,
    GHOST,
}

function get_enemy_description(enemy) {
    return [
        {
            type: ENEMY.CROW,
            object: obj_crow,
            hp: 1,
            damage: 0,
            rewards: [
                new ResCount(RESOURCE.SOUL, 1),
            ]
        },
        {
            type: ENEMY.WOLF,
            object: obj_wolf,
            hp: 1,
            damage: 0,
            rewards: [
                new ResCount(RESOURCE.SOUL, 1),
            ]
        },
        {
            type: ENEMY.ZOMBIE,
            object: obj_zombie,
            hp: 2,
            damage: 1,
            rewards: [
                new ResCount(RESOURCE.SOUL, 2),
            ]
        },
        {
            type: ENEMY.ZOMBIE_SKEL,
            object: obj_zombie_skel,
            hp: 2,
            damage: 1,
            rewards: [
                new ResCount(RESOURCE.SOUL, 2),
                new ResCount(RESOURCE.WIND, 1),
            ]
        },
        {
            type: ENEMY.ZOMBIE_ASH,
            object: obj_zombie_ash,
            hp: 2,
            damage: 1,
            souls: 1,
            rewards: [
                new ResCount(RESOURCE.SOUL, 2),
                new ResCount(RESOURCE.FIRE, 1),
            ]
        },
        {
            type: ENEMY.ZOMBIE_ROCK,
            object: obj_zombie_rock,
            hp: 2,
            damage: 1,
            souls: 1,
            rewards: [
                new ResCount(RESOURCE.SOUL, 2),
                new ResCount(RESOURCE.EARTH, 1),
            ]
        },
        {
            type: ENEMY.ZOMBIE_SWAMP,
            object: obj_zombie_swamp,
            hp: 2,
            damage: 1,
            rewards: [
                new ResCount(RESOURCE.SOUL, 2),
                new ResCount(RESOURCE.WATER, 1),
            ]
        },
        {
            type: ENEMY.SCARECROW,
            object: obj_scarecrow,
            hp: 3,
            damage: 2,
            rewards: [
                new ResCount(RESOURCE.SOUL, 5),
                new ResCount(RESOURCE.WATER, 2),
            ]
        },
        {
            type: ENEMY.GOLEM,
            object: obj_golem,
            hp: 4,
            damage: 3,
            rewards: [
                new ResCount(RESOURCE.SOUL, 5),
                new ResCount(RESOURCE.EARTH, 2),
            ]
        },
        {
            type: ENEMY.GHOST,
            object: obj_ghost,
            hp: 3,
            damage: 2,
            rewards: [
                new ResCount(RESOURCE.SOUL, 10),
            ]
        },
    ][enemy]
}


function get_seasoned_zombie() {
    if (obj_run_state.season == 0) {
        return ENEMY.ZOMBIE_SWAMP
    } else if (obj_run_state.season == 1) {
        return ENEMY.ZOMBIE_ASH
    } else if (obj_run_state.season == 2) {
        return ENEMY.ZOMBIE_ROCK
    } else if (obj_run_state.season == 3) {
        return ENEMY.ZOMBIE_SKEL
    }
}