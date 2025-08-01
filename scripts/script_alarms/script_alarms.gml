// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function TimedAlarm(time, callback) create an alarm that binded to game speed
/// @param {Real} _time  steps until alarm fired
/// @param {Function} _callback function that will fire at the end
/// @param {Real} _repeat count of reapeating. Set to -1 to infinite. By default - fire once (repeat = 1)
function TimedAlarm(_time, _callback, _repeat=1) constructor {
    time = _time;
    remaining = _time;
    callback = _callback;
    repeat_count = _repeat;
    
    is_paused = false;
    
    is_endless = false;
    if (_repeat == -1) {
        is_endless = true
    }
    to_delete = false;
    
    fire = function() {
        if (to_delete) {
            return;
        }
        
        callback();
        
        if (is_endless) {
            remaining = time;
        } else {
           repeat_count--;
           if (repeat_count <= 0) {
               to_delete = true;
           } else {
               remaining = time;
           }
        }
    }
    
    get_completion_percent = function() {
        return 1 - remaining / time
    }
    
    pause = function() {
        is_paused = true
    }
    
    resume = function() {
        is_paused = false
    }
}

/// @param {Array<Struct.TimedAlarm>} _alarms list of alarms
function update_alarms(_alarms, _steps) {
    for(var _i = 0; _i < array_length(_alarms); _i++) {
        var _alarm = _alarms[_i]
       
        if (!_alarm.is_paused) {
            _alarm.remaining -= _steps
           
            if (_alarm.remaining <= 0) {
                _alarm.fire()
            }
        }
   }
   
   
   for(var _i = array_length(_alarms) - 1; _i >= 0; _i--) {
        var _alarm = _alarms[_i]
        if (_alarm.to_delete) {
            array_delete(_alarms, _i, 1)
        }
   }
}
