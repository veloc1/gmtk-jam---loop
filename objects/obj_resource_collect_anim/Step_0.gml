if (!is_inited) {
    is_inited = true
    sprite_index = get_resource_sprite(resource)
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
    obj_player.resources[resource] += 1
}

var p = get_bezier_point(x1, y1, x2, y2, x3, y3, obj_player.x + obj_player.sprite_width / 2 + sprite_width, obj_player.y, t)
x = p.x
y = p.y