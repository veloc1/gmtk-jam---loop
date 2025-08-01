/// @description 
event_inherited();

dir = 0
target_dir = 0
vel = 0
acc = 0.8
max_vel = 10

forced_vel = 0
forced_dir = 0

friction_factor = 0.1
forced_vel_friction_factor = 0.1

face_direction = 1

ignore_game_speed_limit = false

ignore_depth = false

check_collision = function(_dx, _dy) {
    if (place_meeting(x + _dx, y + _dy, get_collission_objects())) {
        return true
    }
    return false
}

get_collission_objects = function() {
    return [obj_wall, /*obj_enemy, obj_player*/]
}

apply_friction = function() {
    vel = lerp(vel, 0, friction_factor)
    forced_vel = lerp(forced_vel, 0, forced_vel_friction_factor)
}

process_movement = function() {
    apply_friction()
    
    vel = clamp(vel, -max_vel, max_vel)
    
    var gs = obj_time_manager.game_speed
    if (ignore_game_speed_limit) {
        gs = 1
    }
    
    var vel_x = cos(degtorad(dir)) * vel * gs
    var vel_y = -sin(degtorad(dir)) * vel * gs
    var forced_vel_x = cos(degtorad(forced_dir)) * forced_vel * gs
    var forced_vel_y = -sin(degtorad(forced_dir)) * forced_vel * gs
    
    vel_x = vel_x + forced_vel_x
    vel_y = vel_y + forced_vel_y
    
    var skip_collisons = false
    var is_colliding_with_wall = false
    var collide_direction = ""
    if (check_collision(0, 0)) {
        skip_collisons = true
    }
    
    if (skip_collisons) {
        x += vel_x
        y += vel_y
    } else {
        if (check_collision(vel_x, 0)) {
            var actual_move = 0
            var small_movement = 0.5 * sign(vel_x)
            while (!check_collision(small_movement, 0)) {
                x += small_movement
                actual_move += small_movement
                if (abs(actual_move) > abs(vel_x)) {
                    break
                }
            }
            vel_x = 0
            
            is_colliding_with_wall = true
            if (vel_x > 0) {
                collide_direction = "right"
            } else {
                collide_direction = "left"
            }
        } else {
            x += vel_x
        }    
        
        if (check_collision(0, vel_y)) {
            var actual_move = 0
            var small_movement = 0.5 * sign(vel_y)
            while (!check_collision(0, small_movement)) {
                y += small_movement
                actual_move += small_movement
                if (abs(actual_move) > abs(vel_y)) {
                    break
                }
            }
            vel_y = 0
            
            is_colliding_with_wall = true
            if (vel_y > 0) {
                collide_direction = "bottom"
            } else {
                collide_direction = "top"
            }
        } else {
            y += vel_y
        }    
    }
    
    var new_fd = sign(vel_x)
    if (abs(vel_x) < 0.01) {
        new_fd = 0
    }
    if (new_fd != 0) {
        face_direction = new_fd
    }
    
    if (is_colliding_with_wall) {
        var wall_collision_coords = {x: x,y: y}
        if (collide_direction == "right") {
            wall_collision_coords.x = bbox_right
        } else if (collide_direction == "left") {
            wall_collision_coords.x = bbox_left
        }
        if (collide_direction == "top") {
            wall_collision_coords.y = bbox_top
        } else if (collide_direction == "bottom") {
            wall_collision_coords.y = bbox_bottom
        }
        event_collide_with_wall(wall_collision_coords)
    }
    // var dt = angle_difference(target_dir, dir)
    // dir += dt * 0.1
    // show_debug_message(dir)
    
    if (!ignore_depth) {
        depth = -bbox_bottom
    }
}

move = function(direction, modifier = 1) {
    // target_dir = direction
    dir = direction
    vel += acc * modifier
}

reset_movement = function() {
    vel = 0
}


/// Forced move is not limited by overall velocity limit
forced_move = function(direction, modifier = 1) {
    forced_dir = direction
    //forced_vel += acc * modifier
    forced_vel += modifier
}

event_collide_with_wall = function(wall_collision_coords) {}