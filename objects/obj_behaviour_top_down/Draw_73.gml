if (obj_debug_manager.debug_state == 1) {
    var gs = obj_time_manager.game_speed
    var vel_x = cos(degtorad(dir)) * vel * gs
    var vel_y = -sin(degtorad(dir)) * vel * gs
    var forced_vel_x = cos(degtorad(forced_dir)) * forced_vel * gs
    var forced_vel_y = -sin(degtorad(forced_dir)) * forced_vel * gs
    
    vel_x = vel_x + forced_vel_x
    vel_y = vel_y + forced_vel_y
    
    draw_set_alpha(1)
    draw_set_color(c_red)
    
    draw_line_width(x, y, x + vel_x, y + vel_y, 10)
}