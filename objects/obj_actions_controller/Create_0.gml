actions = []
can_skip = false
text = ""

populate_actions = function(segment) {
    actions = []
    
    can_skip = true
    
    if (segment.ground == GROUND.NORMAL) {
        if (segment.building == undefined and segment.enemy == undefined) {
            array_push(actions, get_action_description(ACTION.COLLECT_MANA))
            array_push(actions, get_action_description(ACTION.BUILD_MILL))
            array_push(actions, get_action_description(ACTION.BUILD_FARM))
            
            text = text_on_empty_segment()
        }
    }
    
    if (segment.building == BUILDING.PORTAL) {
        if (obj_run_state.portal_status == "complete") {
            array_push(actions, get_action_description(ACTION.TELEPORT))    
        } else {
            array_push(actions, get_action_description(ACTION.BUILD_PORTAL))    
            
            text = text_on_portal()
        }
    }
    
    if (segment.building == BUILDING.CHURCH) {
        array_push(actions, get_action_description(ACTION.HEAL))    
        
        text = text_on_church()
    }
    
    if (segment.enemy != undefined) {
        array_push(actions, get_action_description(ACTION.FIGHT))
        array_push(actions, get_action_description(ACTION.REPEL))
        array_push(actions, get_action_description(ACTION.ENDURE))
        
        text = text_on_enemy()
        
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
    // array_push(actions, get_action_description(ACTION.REPEL))
    array_push(actions, get_action_description(ACTION.ENDURE))
    
    text = text_in_fight()
    
    can_skip = false
    obj_ui_sidebar_controller.refresh_actions_buttons()
}

