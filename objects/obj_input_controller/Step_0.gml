if (InputPressed(INPUT_VERB.ACTION1)) {
    if (array_length(obj_actions_controller.actions) >= 1) {
        obj_actions_controller.actions[0].func()
    }
} else if (InputPressed(INPUT_VERB.ACTION2)) {
    if (array_length(obj_actions_controller.actions) >= 2) {
        obj_actions_controller.actions[1].func()
    }
} else if (InputPressed(INPUT_VERB.ACTION3)) {
    if (array_length(obj_actions_controller.actions) >= 3) {
        obj_actions_controller.actions[2].func()
    }
} else if (InputPressed(INPUT_VERB.ACTION4)) {
    if (array_length(obj_actions_controller.actions) >= 4) {
        obj_actions_controller.actions[3].func()
    }
}