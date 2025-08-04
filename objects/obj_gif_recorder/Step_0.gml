if (keyboard_check(vk_control) and keyboard_check_pressed(ord("O"))) {
    if (state == "none") {
        state = "start-record"
    } else if (state == "record") {
        state = "stop"
    } 
}