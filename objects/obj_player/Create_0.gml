max_hp = 5
hp = max_hp - 2


damage = function() {
    hp -= 1
    if (hp == 0) {
        destroy()
    }
}

destroy = function() {
    instance_create_layer(x + sprite_width / 2, bbox_bottom, "Effects", obj_enemy_destroy_fx)
    visible = false
    
    obj_actions_controller.clear_actions()
    
    obj_time_manager.schedule_alarm(1.5, function() {
        instance_create_layer(0, 0, "UI", obj_ui_death_popup)
    })
}