if (event_data[? "event_type"] == "sprite event") {
    if (event_data[? "message"] == "screenshake") {
        obj_screen_shaker.medium_shake()
        //if (enemy != undefined) {
            //enemy.destroy()
        //}
    }
} 