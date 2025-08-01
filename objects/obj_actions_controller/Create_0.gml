actions = []

populate_actions = function(segment) {
    actions = []
    
    if (segment.ground == GROUND.NORMAL) {
        if (segment.building == undefined and segment.enemy == undefined) {
            array_push(actions, new Action("Collect mana", collect_mana))
            array_push(actions, new Action("Build mill", build_mill))
        }
    }
}

clear_actions = function () {
    actions = []
}

collect_mana = function() {
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    
    segment.ground = GROUND.CORRUPTED
    obj_move_controller.pause_move_timer()
    
    instance_create_layer(obj_player.bbox_right + 36, obj_player.bbox_bottom + 24, "Effects", obj_mana_collect_fx)
    
    obj_time_manager.schedule_alarm(0.26, function() {
        obj_screen_shaker.medium_shake()
    })
    
    obj_time_manager.schedule_alarm(1.2, function() {
        var ground_instance = instance_nearest(obj_player.bbox_right, obj_player.bbox_bottom, obj_ground)
        if (ground_instance != undefined) {
            ground_instance.corrupt()
            
            for(var i = 0; i < array_length(ground_instance.resources_inst); i++) {
                var r = ground_instance.resources_inst[i]
                var a = instance_create_layer(r.x, r.y, "Instances1", obj_resource_collect_anim)
                a.resource = r.resource
            }
        }
    })
    
    obj_time_manager.schedule_alarm(1.8, function() {
        obj_move_controller.resume_move_timer()
    })
    
    clear_actions()
}

build_mill = function() {
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    
    segment.building = BUILDING.MILL
    obj_move_controller.pause_move_timer()
    
    var ground_instance = instance_nearest(obj_player.bbox_right, obj_player.bbox_bottom, obj_ground)
    if (ground_instance != undefined) {
        //ground_instance.corrupt()
        //
        //for(var i = 0; i < array_length(ground_instance.resources_inst); i++) {
            //var r = ground_instance.resources_inst[i]
            //var a = instance_create_layer(r.x, r.y, "Instances1", obj_resource_collect_anim)
            //a.resource = r.resource
        //}
    }
    
    // obj_screen_shaker.medium_shake()
    
    // instance_create_layer(obj_player.bbox_right, obj_player.bbox_bottom, "Instances0", obj_building_mill)
    instance_create_layer(obj_player.bbox_right + 60, obj_player.bbox_bottom, "Ground0", obj_building_place)
    
    obj_time_manager.schedule_alarm(0.8, function() {
        obj_move_controller.resume_move_timer()
    })
    
    clear_actions()
}