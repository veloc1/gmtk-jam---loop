if (!is_inited) {
    is_inited = true
    sprite_index = get_resource_sprite(resource)
}

y -= y_speed
y_speed = lerp(y_speed, 0.2, 0.08)

var t = (obj_time_manager.game_time - start_time) / duration

if (t >= 1) {
    instance_destroy(self)
    instance_create_layer(x, y, "Effects", obj_resource_puff)
}