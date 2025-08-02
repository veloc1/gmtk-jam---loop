while (array_length(offsets) < enemy.hp) {
    array_push(offsets, 0)
}

width = enemy.hp * 11
    
for (var i = 0; i < enemy.hp; i++) {
    var _x = x + i * 10
    var _y = y + offsets[i]
    
    draw_sprite(spr_heart_small, 0, _x, _y)
    
    offsets[i] = sin((obj_time_manager.game_time + i * 3) * 1.5) * 1.1
}