actions = []

populate_actions = function(segment) {
    actions = []
    
    if (segment.ground == GROUND.NORMAL) {
        if (segment.building == undefined and segment.enemy == undefined) {
            array_push(actions, get_action_description(ACTION.COLLECT_MANA))
            array_push(actions, get_action_description(ACTION.BUILD_MILL))
        }
    }
    
    if (segment.enemy != undefined) {
        array_push(actions, get_action_description(ACTION.FIGHT))
        array_push(actions, get_action_description(ACTION.REPEL))
        array_push(actions, get_action_description(ACTION.ENDURE))
    }
    
    obj_ui_sidebar_controller.refresh_actions_buttons()
}

clear_actions = function () {
    actions = []
    obj_ui_sidebar_controller.refresh_actions_buttons()
}

set_fight_actions = function() {
    actions = []
    array_push(actions, get_action_description(ACTION.FIGHT))
    // array_push(actions, get_action_description(ACTION.REPEL))
    array_push(actions, get_action_description(ACTION.ENDURE))
    
    obj_ui_sidebar_controller.refresh_actions_buttons()
}

