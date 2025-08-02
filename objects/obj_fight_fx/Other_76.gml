if (layer_instance_get_instance(event_data[?"element_id"]) == id and event_data[? "event_type"] == "sprite event") {
    if (event_data[? "message"] == "screenshake") {
        obj_screen_shaker.medium_shake()
        on_hit()
        //if (enemy != undefined) {
            //enemy.destroy()
        //}
    }
} 