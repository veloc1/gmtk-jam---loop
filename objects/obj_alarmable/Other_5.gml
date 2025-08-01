/// @description Destroy alarms

for(var _i = 0; _i < array_length(alarms); _i++) {
    obj_time_manager.discard_alarm(alarms[_i])
    delete alarms[_i]
}
