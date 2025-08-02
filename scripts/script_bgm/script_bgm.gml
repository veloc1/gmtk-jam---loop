/// @param {Asset.GMSound} audio_id sound to play
function bgm_play(audio_id, fade_in_out = true, crossfade = false, loop = true) {
    if (variable_global_exists("bgm_id") && global.bgm_id == audio_id) {
        // sound already playing
        return
    }
    var crossfade_duration = 0
    if (crossfade) {
        crossfade_duration = 0.8
    }
    if (fade_in_out) {
        crossfade_duration = 0.8
    }
     
    if (variable_global_exists("bgm")) {
        audio_sound_gain(global.bgm, 0, crossfade_duration * 1000)
        
        global.old_bgm = global.bgm
        obj_time_manager.schedule_alarm(crossfade_duration, function() {
            audio_stop_sound(global.old_bgm)
        })
    }

    global.bgm_id = audio_id
    global.bgm_crossfade_duration = crossfade_duration
    global.bgm_loop = loop
    obj_time_manager.schedule_alarm(crossfade_duration, function() {
        if (global.bgm_id != undefined) {
            global.bgm = audio_play_sound(global.bgm_id, 0, global.bgm_loop)
            audio_sound_gain(global.bgm, 0, 0)
            audio_sound_gain(global.bgm, 1, global.bgm_crossfade_duration * 1000)
        } else {
            show_debug_message("WARNING: cannot load bgm_id, {0}:{1}", _GMFILE_, _GMLINE_)
        }
    })
}

function bgm_stop(crossfade = false) {
    if (variable_global_exists("bgm")) {
        if (crossfade) {
            var crossfade_duration = 0.8
            
            audio_sound_gain(global.bgm, 0, crossfade_duration * 1000)
            
            global.stopped_bgm = global.bgm
            obj_time_manager.schedule_alarm(crossfade_duration, function() {
                audio_stop_sound(global.stopped_bgm)
            })
        } else {
            audio_stop_sound(global.bgm)
        }
    }
    
    global.bgm_id = -1
    
}
