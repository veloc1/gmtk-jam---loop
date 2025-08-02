segments = []
current_segment = 0
segments_count = 0

create_segment_objects = function(display_x) { 
    var ind = current_segment + 1
    if (ind >= array_length(segments)) {
        ind = 0
    }
    var next_segment = segments[ind]
    
    if (next_segment.ground == GROUND.NORMAL) {
        var ground_inst = instance_create_layer(display_x, 128 + 5, "Ground", obj_ground)
        var _x = display_x + 16
        for (var i = 0; i < array_length(next_segment.ground_resources); i++) {
            var ri = instance_create_layer(_x, 158, "Ground1", obj_resource_in_ground)
            ri.resource = next_segment.ground_resources[i]
            _x += 16 + 6
            array_push(ground_inst.resources_inst, ri)
        }
    } else if (next_segment.ground == GROUND.CORRUPTED) {
        instance_create_layer(display_x, 128 + 5, "Ground", obj_ground_corrupted)
    }
    
    if (next_segment.building == BUILDING.MILL) {
        instance_create_layer(display_x + 90, 128 + 5, "Instances0", obj_building_mill)
    }
    
    
    if (next_segment.enemy == ENEMY.SCARECROW) {
        instance_create_layer(display_x + 160, 128 + 5, "Instances0", obj_scarecrow)
    }
}
started_moving_to_next_segment = function() {
    obj_actions_controller.clear_actions()
}

moved_to_next_segment = function() {
    current_segment += 1
    if (current_segment >= array_length(segments)) {
        current_segment = 0
        obj_run_state.on_loop_completed()
    }
    
    var segment = segments[current_segment]
    
    if (segment.building == BUILDING.MILL) {
        var desc = get_building_description(segment.building)
        var _x = 90
        for (var i = 0; i < array_length(desc.resources); i++) {
            add_resource_to_player(_x, 90, desc.resources[i])
            _x += 16
        }
    }
    
    obj_actions_controller.populate_actions(segments[current_segment])
}

generate_segments = function() {
    //for(var i = 0; i < 12; i ++) {
        var segment = new Segment()
        segment.ground = GROUND.NORMAL
        segment.ground_resources = [RESOURCE.EARTH, RESOURCE.WIND]
        array_push(segments, segment)
    // }
    
    segment = new Segment()
    segment.ground = GROUND.CORRUPTED
    segment.ground_resources = [RESOURCE.EARTH, RESOURCE.FIRE]
    array_push(segments, segment)
    
    segment = new Segment()
    segment.ground = GROUND.NORMAL
    segment.ground_resources = [RESOURCE.EARTH, RESOURCE.WATER]
    segment.enemy = ENEMY.SCARECROW
    array_push(segments, segment)
    
    segments_count = 3
}

generate_segments()

current_segment = segments_count - 1
create_segment_objects(0)
// current_segment = segments_count - 1
obj_time_manager.schedule_alarm(0.1, function() {
    obj_actions_controller.populate_actions(segments[0])
})

