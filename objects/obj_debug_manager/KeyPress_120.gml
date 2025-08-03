/// @description next level
if (obj_time_manager.game_speed == 1) {
    obj_time_manager.game_speed = 2    
} else if (obj_time_manager.game_speed == 2) {
    obj_time_manager.game_speed = 3    
} else {
    obj_time_manager.game_speed = 1
}

/*if (room_exists(room_next(room))) {
	room_goto_next();
} else {
	room_goto(rm_level_1);
}*/