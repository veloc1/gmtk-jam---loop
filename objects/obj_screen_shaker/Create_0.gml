/// @description Init

event_inherited()

on = false
delta = 3 // px
duration = 3 // frames
shake_angle = -1


micro_shake = function (_shake_angle = -1) {
  on = true
  duration = 0.05
  delta = 1
  shake_angle = _shake_angle
  track_alarm(obj_time_manager.schedule_alarm(duration, function() { on = false }))
}

small_shake = function (_shake_angle = -1) {
  on = true
  duration = 0.1
  delta = 3
  shake_angle = _shake_angle
  track_alarm(obj_time_manager.schedule_alarm(duration, function() { on = false }))
}

medium_shake = function (_shake_angle = -1) {
  on = true
  duration = 0.2
  delta = 3 
  shake_angle = _shake_angle
  track_alarm(obj_time_manager.schedule_alarm(duration, function() { on = false }))
}

boss_shake = function (_shake_angle = -1) {
  on = true
  duration = 0.5
  delta = 3
  shake_angle = _shake_angle
  track_alarm(obj_time_manager.schedule_alarm(duration, function() { on = false }))
}