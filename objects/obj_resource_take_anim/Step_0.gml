if (!is_inited) {
    is_inited = true
    sprite_index = get_resource_sprite(resource)
}

if (delay > 0) {
    delay -= 1
    start_time = obj_time_manager.game_time
    return
}

x += x_speed
y -= y_speed
x_speed = lerp(x_speed, 0, 0.08)
y_speed = lerp(y_speed, 0.2, 0.08)

var t = (obj_time_manager.game_time - start_time) / duration

if (t >= 1) {
    instance_destroy(self)
    instance_create_layer(x, y, "Effects", obj_resource_puff)
}