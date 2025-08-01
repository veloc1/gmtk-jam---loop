/// @description Shake

var cam_x = camera_get_view_x(view_camera[0])
var cam_y = camera_get_view_y(view_camera[0])

// hack for this game
cam_x = 0
cam_y = 0
if (on && obj_settings_state.is_screen_shake_enabled && !obj_time_manager.is_paused) {
  var _shake_x = 0
  var _shake_y = 0
  if (shake_angle != -1) {
    _shake_x += cos(degtorad(shake_angle)) * random_range(0, delta)
    _shake_y -= sin(degtorad(shake_angle)) * random_range(0, delta)
    _shake_x += random_range(-delta / 2, delta / 2)
    _shake_y += random_range(-delta / 2, delta / 2)
  } else {
    _shake_x = random_range(-delta, delta)
    _shake_y = random_range(-delta, delta)
  }
  camera_set_view_pos(view_camera[0], cam_x + _shake_x, cam_y + _shake_y); 
} else {
  camera_set_view_pos(view_camera[0], cam_x, cam_y);
  
}
