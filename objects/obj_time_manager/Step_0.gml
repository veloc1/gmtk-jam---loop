/// @description Increment time

game_time += game_get_speed(gamespeed_microseconds) / 1000 / 1000 * game_speed


game_step_inc += game_speed


var _inc_steps = 0
while (game_step_inc > 1) {
  game_steps += 1
  game_step_inc -= 1
  _inc_steps += 1
}

update_alarms(alarms, _inc_steps)

// no gs section

game_time_no_gs += game_get_speed(gamespeed_microseconds) / 1000 / 1000
game_step_inc_no_gs += 1
game_steps_no_gs += 1
update_alarms(alarms_ignore_gamespeed, 1)

// if (instance_exists(obj_room_state) && !obj_room_state.is_level_completed) {
  // obj_game_state.current_run_time += game_get_speed(gamespeed_microseconds) / 1000 / 1000 * game_speed
// }