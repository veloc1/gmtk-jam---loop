/// @description Init alarms

alarms = []

/// @func track_alarm(alarm) Add alarm to tracking list to be deleted on instance destroy
/// @param {Struct.TimedAlarm} _alarm Alarm to add
track_alarm = function(_alarm) {
  array_push(alarms, _alarm) 
}