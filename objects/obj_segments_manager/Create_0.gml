segments = []
current_segment = 0
segments_count = 0

create_segment_objects = function(display_x) { 
    var ind = current_segment + 1
    if (ind >= array_length(segments)) {
        ind = 0
    }
    var next_segment = segments[ind]
    
    _create_ground(next_segment, display_x)
    _create_building(next_segment, display_x)
    _create_enemies(next_segment, display_x)
}

#region instances

_create_ground = function(next_segment, display_x) {
    if (next_segment.ground == GROUND.NORMAL) {
        var ground_inst = instance_create_layer(display_x, 128 + 5, "Ground", obj_ground)
        if (next_segment.building == undefined) {
            var _x = display_x + 16
            for (var i = 0; i < array_length(next_segment.ground_resources); i++) {
                var ri = instance_create_layer(_x, 158, "Ground1", obj_resource_in_ground)
                ri.resource = next_segment.ground_resources[i]
                _x += 16 + 6
                array_push(ground_inst.resources_inst, ri)
            }
        }
    } else if (next_segment.ground == GROUND.CORRUPTED) {
        instance_create_layer(display_x, 128 + 5, "Ground", obj_ground_corrupted)
    }
}
_create_building = function(next_segment, display_x) {
    if (next_segment.building != undefined) {
        instance_create_layer(display_x + 90, 128 + 5, "Groundm1", get_building_description(next_segment.building).object)
    }
    if (next_segment.has_ruins) {
        instance_create_layer(display_x + 90, 128 + 5, "Groundm1", obj_ruins)
    }
}
_create_enemies = function(next_segment, display_x) {
    if (next_segment.enemy != undefined) {
        instance_create_layer(display_x + 160, 128 + 5, "Groundm1", get_enemy_description(next_segment.enemy).object)
    }
}
#endregion

started_moving_to_next_segment = function() {
    obj_actions_controller.clear_actions()
}

moved_to_next_segment = function(skip_resource_gathering = false) {
    current_segment += 1
    if (current_segment >= array_length(segments)) {
        current_segment = 0
        obj_run_state.on_loop_completed()
        if (obj_run_state.season == 0 and obj_run_state.year == 0) {
            // skip ranomize on tutorial.
        } else {
            randomize_segments()
        }
    }
    
    var segment = segments[current_segment]
    
    if (segment.building != undefined) {
        if (segment.building == BUILDING.PORTAL) {
            
             /*if (segment.building == BUILDING.PORTAL and obj_run_state.portal_status == "complete") {
                obj_actions_controller.clear_actions()
                obj_move_controller.disable_idle_timer()
                
                instance_create_layer(0, 0, "UI", obj_ui_win_popup)
            }*/
            
        } else {
            var desc = get_building_description(segment.building)
            if (!skip_resource_gathering) {
                var _x = 90
                var c = 0
                
                for (var i = 0; i < array_length(desc.resources); i++) {
                    var r = desc.resources[i]
                    var res = r.resource
                    if (res == RESOURCE.RANDOM_ENERGY) {
                        var rand = random(1)
                        if (rand < 0.25) {
                            res = RESOURCE.EARTH
                        } else if (rand < 0.50) {
                            res = RESOURCE.FIRE
                        } else if (rand < 0.75) {
                            res = RESOURCE.WATER
                        } else  {
                            res = RESOURCE.WIND
                        }
                    }
                    for (var j = 0; j < r.count; j++) { 
                        add_resource_to_player(_x, 90, res, c * 8)
                        _x += 16
                        c+=1;
                    }
                }
            }
        }
    }
    
    obj_actions_controller.populate_actions(segments[current_segment])
    
    if (!obj_actions_controller.can_skip) {
        obj_move_controller.disable_idle_timer()
    }
    /*if (segment.enemy != undefined) {
        obj_move_controller.disable_idle_timer()
    }*/
    
   
}

generate_segments = function() {
    var segment = new Segment()
    segment.ground = GROUND.NORMAL
    segment.ground_resources = []
    segment.building = BUILDING.CHURCH
    segment.event = EVENT.TUTORIAL_CHURCH
    array_push(segments, segment)
    
    segment = new Segment()
    segment.ground = GROUND.NORMAL
    segment.ground_resources = [RESOURCE.EARTH, RESOURCE.FIRE, RESOURCE.WIND]
    segment.event = EVENT.TUTORIAL_MANA_GATHER
    array_push(segments, segment)
    
    segment = new Segment()
    segment.ground = GROUND.NORMAL
    segment.ground_resources = random_ground_resources()
    segment.event = EVENT.TUTORIAL_BUILD
    array_push(segments, segment)
    
    segment = new Segment()
    segment.ground = GROUND.NORMAL
    segment.ground_resources = random_ground_resources()
    segment.event = EVENT.TUTORIAL_FIGHT
    segment.enemy = ENEMY.CROW
    array_push(segments, segment)
    
    segment = new Segment()
    segment.ground = GROUND.NORMAL
    segment.ground_resources = random_ground_resources()
    segment.necropol_exclusive = true
    array_push(segments, segment)
    
    for(var i = 0; i < 5; i ++) {
        segment = new Segment()
        segment.ground = GROUND.NORMAL
        segment.ground_resources = random_ground_resources()
        array_push(segments, segment)
    }
    
    segment = new Segment()
    segment.ground = GROUND.NORMAL
    segment.ground_resources = []
    segment.building = BUILDING.PORTAL
    
    array_push(segments, segment)
    
    segments_count = array_length(segments)
}

randomize_segments = function() {
    for (var i = 0; i < array_length(segments); i++) {
        var segment = segments[i]
        segment.event = undefined
        
        if (segment.building != undefined) {
            var bdesc = get_building_description(segment.building)
            if (!bdesc.is_endless) {
                segment.building_lifetime += 1
                if (segment.building_lifetime >= bdesc.lifetime) {
                    segment.building = undefined
                    segment.has_ruins = true
                    if (array_length(bdesc.enemies) > 0) {
                        segment.enemy = bdesc.enemies[irandom(array_length(bdesc.enemies) - 1)]
                    }
                }
            }
        } else if (segment.event != undefined)  {
            
        } else if (segment.enemy != undefined) {
            // upgrade repeled
            if (segment.enemy == ENEMY.ZOMBIE) {
                if (random(1) < 0.50) {
                    segment.enemy = get_seasoned_zombie()
                }
            }
        } else {
            //spawn zombie
            if (random(1) < 0.25) {
                segment.enemy = ENEMY.ZOMBIE
                if (random(1) < 0.50) {
                    segment.enemy = get_seasoned_zombie()
                }
            }
        }
    }
}

random_ground_resources = function() {
    var res = []
    
    array_push(res, RESOURCE.EARTH)
    if (random(1) < 0.75) {
        array_push(res, random_res())
    }
    if (random(1) < 0.35) {
        // array_push(res, random_res())
        res[0] = random_res()
    }
    
    return res
}
random_res = function( ) {
    var r = irandom(2)
    if (r == 0) {
        return RESOURCE.FIRE
    } else if (r == 1) {
        return RESOURCE.WATER
    } else if (r == 2) {
        return RESOURCE.WIND
    } else if (r == 3) {
        return RESOURCE.EARTH
    }
}

generate_segments()

current_segment = segments_count - 1
create_segment_objects(0)

// current_segment = segments_count - 1
obj_time_manager.schedule_alarm(0.1, function() {
//    obj_actions_controller.populate_actions(segments[0])
    moved_to_next_segment(true)
    if(!obj_actions_controller.can_skip) {
        obj_move_controller.pause_move_timer()
    }
})

