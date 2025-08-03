actions = []
can_skip = false
text = ""

populate_actions = function(segment) {
    actions = []
    
    can_skip = true
    can_add_actions = true
    
    // if (segment.ground == GROUND.NORMAL) {
        if (segment.building == undefined and segment.enemy == undefined and segment.event == undefined) {
            if (can_add_actions) {
                array_push(actions, get_action_description(ACTION.COLLECT_MANA))
                if (segment.necropol_exclusive) {
                    array_push(actions, get_action_description(ACTION.BUILD_NECROPOL)) 
                } else {
                    array_push(actions, get_action_description(ACTION.BUILD_MILL))
                    array_push(actions, get_action_description(ACTION.BUILD_QUARRY))
                    array_push(actions, get_action_description(ACTION.BUILD_VILLAGE)) 
                }
            }
            
            if (segment.necropol_exclusive) {
                text = text_on_empty_necropol_segment()
            } else {
                text = text_on_empty_segment()
            }
        }
    // }
    
    var has_event = false
    
    if (segment.event != undefined) {
        var event = get_event_description(segment.event)
        for (var i = 0; i < array_length(event.actions); i++) {
            array_push(actions, get_action_description(event.actions[i]))        
        }
        text = event.text
        
        can_skip = event.can_skip
        can_add_actions = !event.is_exclusive
        
        has_event = true
    } else if (segment.building != undefined) {
        if (segment.building == BUILDING.PORTAL) {
            if (obj_run_state.portal_status != "complete") {
                if (can_add_actions) {
                    array_push(actions, get_action_description(ACTION.BUILD_PORTAL))    
                }
            } 
            
            if (can_add_actions) {
                array_push(actions, get_action_description(ACTION.TELEPORT))    
            }
            
            if (!has_event) {
                text = text_on_portal()
                can_skip = false
            }
            
        } else  if (segment.building == BUILDING.CHURCH) {
            if (can_add_actions) {
                array_push(actions, get_action_description(ACTION.HEAL))    
            }
            
            if (!has_event) {
                text = text_on_church()
            }
        } else {
            if (!has_event) {
                var b = get_building_description(segment.building)
                var available_lifetime = b.lifetime - segment.building_lifetime
                
                text = text_on_building(string_upper(b.name), available_lifetime)
            }
        }
    } else if (segment.enemy != undefined) {
        if (can_add_actions) {
            array_push(actions, get_action_description(ACTION.FIGHT))
            array_push(actions, get_action_description(ACTION.REPEL))
            array_push(actions, get_action_description(ACTION.ENDURE))
        }
        
        if (!has_event) {
            text = text_on_enemy()
        }
        
        can_skip = false
    }
    
    obj_ui_sidebar_controller.refresh_actions_buttons()
}

clear_actions = function () {
    actions = []
    text = ""
    can_skip = false
    obj_ui_sidebar_controller.refresh_actions_buttons()
}

set_fight_actions = function() {
    actions = []
    array_push(actions, get_action_description(ACTION.FIGHT))
    array_push(actions, get_action_description(ACTION.REPEL))
    array_push(actions, get_action_description(ACTION.ENDURE))
    
    text = text_in_fight()
    
    can_skip = false
    obj_ui_sidebar_controller.refresh_actions_buttons()
}

