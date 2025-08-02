event_inherited();

move_speed = 0
move_duration = 3
max_speed = 1
segment_size = 64 * 3
distance_moved = 0
t_start = 0
t_end = 0
idle_wait_time = 10

is_timer_disabled = false

timer_next_move = undefined

create_next_segment = function() {
    obj_segments_manager.create_segment_objects(segment_size)
}

move_instance_layer = function(layer_name, delta) {
    var l_id = layer_get_id(layer_name)
    var g_elem = layer_get_all_elements(l_id)
    for(var i = 0; i < array_length(g_elem); i++) {
        var elem = g_elem[i]
        if (layer_get_element_type(elem) == layerelementtype_instance) {
            var inst = layer_instance_get_instance(elem);
            inst.x -= delta
            if (inst.bbox_right < -96) {
                instance_destroy(inst)
            }
        }
    }
}

move_layers = function(delta) {
    move_instance_layer("Groundm1", delta)
    move_instance_layer("Ground0", delta)
    move_instance_layer("Ground", delta)
    move_instance_layer("Ground1", delta)
    move_instance_layer("Instances0", delta)
    move_instance_layer("Instances1", delta)
    
    layer_x("Background", layer_get_x("Background") - delta * 0.02)
    layer_x("Backgrounds_1", layer_get_x("Backgrounds_1") - delta * 0.22)
    layer_x("Backgrounds_2", layer_get_x("Backgrounds_2") - delta * 0.52)
}

pause_move_timer = function() {
    if (timer_next_move != undefined) {
        timer_next_move.pause()
    }
}
resume_move_timer = function() {
    if (timer_next_move != undefined) {
        timer_next_move.resume()
    }
}

enable_idle_timer = function() {
    is_timer_disabled = false
}
disable_idle_timer = function() {
    is_timer_disabled = true
}
skip_idle = function() {
    obj_time_manager.discard_alarm(timer_next_move)
    timer_next_move = undefined
    change_behaviour("move-to-next")
}

add_behaviour(new Behaviour("idle", {
    on_start: function() { 
        obj_time_manager.discard_alarm(timer_next_move)
        timer_next_move = undefined
        
        if (!is_timer_disabled) {
            timer_next_move = obj_time_manager.schedule_alarm(idle_wait_time, function() {
                change_behaviour("move-to-next")
            })
        }
    },
    on_step: function() {
    },
    on_end: function() {
    },
}))

add_behaviour(new Behaviour("move-to-next", {
    on_start: function() {
        distance_moved = 0
        t_start = obj_time_manager.game_time
        
        create_next_segment()
        obj_segments_manager.started_moving_to_next_segment()
    },
    on_step: function() {
        var t = obj_time_manager.game_time - t_start
        if (t >= move_duration) {
            // microadjust for last milliseconds
            var delta = segment_size - distance_moved
            move_layers(delta)
            
            change_behaviour("idle")
            return
        }
        
        var new_distance_moved = easing(t, move_duration, 0, segment_size, "ease_in_out_quad")
        
        var delta = new_distance_moved - distance_moved
        distance_moved = new_distance_moved
        
        move_layers(delta)
        
    },
    on_end: function() {
        obj_segments_manager.moved_to_next_segment()
    },
}))

change_behaviour("idle")
