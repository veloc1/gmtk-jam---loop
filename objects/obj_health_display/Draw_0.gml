while (array_length(offsets) < obj_player.max_hp) {
    array_push(offsets, 0)
}
for (var i = 0; i < obj_player.max_hp; i++) {
    var _x = x + i * 18
    var _y = y + offsets[i]
    
    if (obj_player.hp > i) {
        draw_sprite(spr_heart, 0, _x, _y)
    } else {
        draw_sprite(spr_heart_empty, 0, _x, y)    
    }
    
    offsets[i] = sin((obj_time_manager.game_time + i * 6) * 2) * 2
}