if (!is_inited) {
    is_inited = true
    sprite_index = get_resource_sprite(resource)
}

if (delay > 0) {
    delay -= 1
    start_time = obj_time_manager.game_time
    return
}

var t = (obj_time_manager.game_time - start_time)  / duration

var scale_after = 0.7
if (t > scale_after) {
    var tt = (1 - t) / (1 - scale_after)
    image_xscale = tt
    image_yscale = tt
}

if (t >= 1) {
    instance_destroy(self)
    if (resource == RESOURCE.HP) {
        obj_player.hp += 1
        if (obj_player.hp > obj_player.max_hp) {
            obj_player.hp = obj_player.max_hp
        }
        play_sound_random_pitch(snd_heal)
    } else {
        obj_run_state.resources[resource] += 1
        
        increment_resource_in_ui(resource)
        play_sound_random_pitch(snd_get_resources)
    }
}

var p = get_bezier_point(x1, y1, x2, y2, x3, y3, obj_player.x + obj_player.sprite_width / 2 + sprite_width, obj_player.y + 8, t)
x = p.x
y = p.y