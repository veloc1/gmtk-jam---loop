/// @description Toggle debug state

if (debug_state == 0) {
    debug_state = 1
    show_debug_overlay(true)
    /*create_views()*/
    
    
    /*for (var i = 0; i < instance_number(obj_camera_bounds); i++;) {
        var bound = instance_find(obj_camera_bounds, i);
        bound.visible = true
    }
    for (var i = 0; i < instance_number(obj_camera_displacer); i++;) {
        var bound = instance_find(obj_camera_displacer, i);
        bound.visible = true
    }
    for (var i = 0; i < instance_number(obj_camera_limiter); i++;) {
        var bound = instance_find(obj_camera_limiter, i);
        bound.visible = true
    }*/
    
} else {
    debug_state = 0
    show_debug_log(false)
    /*clear_views()*/
    
    /*for (var i = 0; i < instance_number(obj_camera_bounds); i++;) {
        var bound = instance_find(obj_camera_bounds, i);
        bound.visible = false
    }
    for (var i = 0; i < instance_number(obj_camera_displacer); i++;) {
        var bound = instance_find(obj_camera_displacer, i);
        bound.visible = false
    }
    for (var i = 0; i < instance_number(obj_camera_limiter); i++;) {
        var bound = instance_find(obj_camera_limiter, i);
        bound.visible = false
    }*/
}
