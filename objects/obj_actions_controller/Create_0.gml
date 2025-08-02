actions = []

populate_actions = function(segment) {
    actions = []
    
    if (segment.ground == GROUND.NORMAL) {
        if (segment.building == undefined and segment.enemy == undefined) {
            array_push(actions, new Action("Collect mana", collect_mana))
            array_push(actions, new Action("Build mill", build_mill))
        }
    }
    
    if (segment.enemy != undefined) {
        array_push(actions, new Action("Fight", fight))
        array_push(actions, new Action("Repel", repel))
        array_push(actions, new Action("Endure", take_hit))
    }
}

clear_actions = function () {
    actions = []
}

set_fight_actions = function() {
    actions = []
    array_push(actions, new Action("Fight", fight))
    // array_push(actions, new Action("Repel", repel))
    array_push(actions, new Action("Endure", take_hit))
}

collect_mana = function() {
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    
    segment.ground = GROUND.CORRUPTED
    obj_move_controller.pause_move_timer()
    
    instance_create_layer(obj_player.bbox_right + 36, obj_player.bbox_bottom + 24, "Effects", obj_mana_collect_fx)
    
    obj_time_manager.schedule_alarm(0.26, function() {
        obj_screen_shaker.medium_shake(270)
    })
    
    obj_time_manager.schedule_alarm(1.2, function() {
        var ground_instance = instance_nearest(obj_player.bbox_right, obj_player.bbox_bottom, obj_ground)
        if (ground_instance != undefined) {
            ground_instance.corrupt()
            
            for(var i = 0; i < array_length(ground_instance.resources_inst); i++) {
                var r = ground_instance.resources_inst[i]
                
                add_resource_to_player(r.x, r.y, r.resource, i * 16)
            }
        }
    })
    
    obj_time_manager.schedule_alarm(1.5, function() {
        obj_move_controller.resume_move_timer()
    })
    
    clear_actions()
}

build_mill = function() {
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    
    segment.building = BUILDING.MILL
    obj_move_controller.pause_move_timer()
    
    obj_screen_shaker.small_shake(90)
    
    instance_create_layer(obj_player.bbox_right + 60, obj_player.bbox_bottom, "Ground0", obj_building_place)
    
    obj_time_manager.schedule_alarm(0.8, function() {
        obj_move_controller.resume_move_timer()
    })
    
    clear_actions()
}

fight = function() {
    var reqs = [{
        resource: RESOURCE.FIRE,
        count: 1
    }]
    
    if (has_resources(reqs)) {
        clear_actions()
        
        take_resources(reqs)
        
        obj_move_controller.pause_move_timer()
        
        obj_time_manager.schedule_alarm(0.9, function() {
            var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
            if (enemy_instance != undefined) {
                var fx = instance_create_layer(enemy_instance.x, enemy_instance.y, "Instances1", obj_fight_fx_1)    
                fx.enemy = enemy_instance
            }
        })
        
        obj_time_manager.schedule_alarm(1.4, function() {
            var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
            if (enemy_instance != undefined) {
                var enemy_type = enemy_instance.type
                var ex = enemy_instance.x
                var ey = enemy_instance.bbox_top
                var is_dead = enemy_instance.damage(1)
                if (is_dead) {
                    var desc = get_enemy_description(enemy_type)
                    var _x = 0
                    for (var i = 0; i < array_length(desc.rewards); i++) {
                        var r = desc.rewards[i]
                        add_resource_to_player(ex + _x, ey - 10, r, i * 16)
                        _x += 18
                    }
                    
                    obj_time_manager.schedule_alarm(2.3, function() {
                        obj_move_controller.resume_move_timer()
                    })
                    
                    clear_actions()            
                } else {
                    obj_time_manager.schedule_alarm(1.6, function() {
                        var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
                        if (enemy_instance != undefined) {
                            enemy_instance.attack_anim()
                        }
                    })
                    
                    obj_time_manager.schedule_alarm(2.8, function() {
                        set_fight_actions()
                    })
                    
                }
            }
        })
        
    } else {
        show_insufficient_resources(reqs)
    }
}

repel = function() {
    show_insufficient_resource_in_ui(RESOURCE.WIND)
}

take_hit = function() {
    obj_move_controller.pause_move_timer()
    
    instance_create_layer(obj_player.x, obj_player.y, "Effects", obj_slash_fx)
    
    obj_screen_shaker.medium_shake(0)
    
    obj_player.damage()
    
    /*obj_time_manager.schedule_alarm(2.3, function() {
        obj_move_controller.resume_move_timer()
    })
    
    clear_actions()*/
}

has_resources = function(resources) {
    var has_res = true
    for (var i = 0; i < array_length(resources); i++) { 
        var r = resources[i]
        if (obj_run_state.resources[r.resource] < r.count) {
            has_res = false
        }
    }
    return has_res
}

show_insufficient_resources = function(reqs) {
    for (var i = 0; i < array_length(reqs); i++) { 
        var r = reqs[i]
        if (obj_run_state.resources[r.resource] < r.count) {
            show_insufficient_resource_in_ui(r.resource)
        }
    }
}

take_resources = function(resources) {
    var _x = obj_player.x + obj_player.sprite_width / 2
    var _y = obj_player.bbox_top
    
    for (var i = 0; i < array_length(resources); i++) { 
        var r = resources[i]
        obj_run_state.resources[r.resource] -= r.count
        decrement_resource_in_ui(r.resource)
        take_resource_from_player(_x, _y, r.resource)
        _x += 20
    }
}