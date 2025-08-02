enum ENEMY {
    SCARECROW,
}

function get_enemy_description(enemy) {
    return [
        {
            type: ENEMY.SCARECROW,
            hp: 3,
            damage: 1,
            souls: 1,
            rewards: [
                RESOURCE.SOUL,
                RESOURCE.SOUL,
                RESOURCE.SOUL,
            ]
        }
    ][enemy]
}
