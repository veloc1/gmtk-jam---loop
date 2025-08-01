/// @description Init
game_time = 0
game_steps = 0
game_step_inc = 0

game_time_no_gs = 0 // no_gs = no game speed
game_steps_no_gs = 0
game_step_inc_no_gs = 0

normal_game_speed = 1.0

game_speed = normal_game_speed 

is_paused = false

/// @field {Array<Struct.TimedAlarm>} alarms
alarms = []
alarms_ignore_gamespeed = []

small_time_stop = function () {
  game_speed = 0.05
  alarm_set(0, 2)
}

medium_time_stop = function () {
  game_speed = 0.1
  alarm_set(0, game_get_speed(gamespeed_fps) * 0.2)
}

large_time_stop = function () {
  game_speed = 0.1
  alarm_set(0, game_get_speed(gamespeed_fps) * 0.5)
}


/// @param {Real} _time in seconds
/// @param {Function} _callback
/// @self obj_time_manager
/// @retrurn {Struct.TimedAlarm}
schedule_alarm = function(_time, _callback, _repeat=1) {
  var _alarm = new TimedAlarm(_time * game_get_speed(gamespeed_fps), _callback, _repeat)
  array_push(alarms, _alarm)
  return _alarm
}
schedule_alarm_ignoring_game_speed = function(_time, _callback, _repeat=1) {
  var _alarm = new TimedAlarm(_time * game_get_speed(gamespeed_fps), _callback, _repeat)
  array_push(alarms_ignore_gamespeed, _alarm)
  return _alarm
}


/// @param {Struct.TimedAlarm} _alarm
discard_alarm = function(_alarm) {
    if (_alarm == undefined) {
        return
    }
    _alarm.to_delete = true
}