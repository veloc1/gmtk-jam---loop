/// @description Init state

settings_save = function (_music_volume, _sfx_volume, _is_screen_shake_enabled, _is_vibration_enabled) {
    obj_persistance.save(
        "settings", 
        {
            music: _music_volume,
            sfx: _sfx_volume,
            is_screen_shake_enabled: _is_screen_shake_enabled,
            is_vibration_enabled: _is_vibration_enabled
        }, 
        function() { }
    )
}


settings_restore = function() {
    
    if(!obj_persistance.has("settings")) {
        music_volume = 1
        sfx_volume = 1
        is_screen_shake_enabled = true
        is_vibration_enabled = true
        settings_save(music_volume, sfx_volume, is_screen_shake_enabled, is_vibration_enabled)
        
        audio_group_set_gain(ag_music, music_volume, 0)
        audio_group_set_gain(ag_sfx, sfx_volume, 0)
        
        return
    }
    
    obj_persistance.load("settings", function(_settings) {
        music_volume = _settings.music
        sfx_volume = _settings.sfx
        
        audio_group_set_gain(ag_music, music_volume, 0)
        audio_group_set_gain(ag_sfx, sfx_volume, 0)
        
        is_screen_shake_enabled = _settings.is_screen_shake_enabled 
        is_vibration_enabled = _settings.is_vibration_enabled
    })
}

music_volume = 1
sfx_volume = 1
is_screen_shake_enabled = true
is_vibration_enabled = true

audio_group_set_gain(ag_music, music_volume, 0)
audio_group_set_gain(ag_sfx, sfx_volume, 0)

settings_restore()

change_music_level = function(_value) {
  music_volume = _value
  audio_group_set_gain(ag_music, music_volume, 0)
  
  settings_save(music_volume, sfx_volume, is_screen_shake_enabled, is_vibration_enabled)
}

change_sfx_level = function(_value) {
  sfx_volume = _value
  audio_group_set_gain(ag_sfx, sfx_volume, 0)
  
  settings_save(music_volume, sfx_volume, is_screen_shake_enabled, is_vibration_enabled)
}

change_vibration_enabled = function(_value) {
  is_vibration_enabled = _value
  
  settings_save(music_volume, sfx_volume, is_screen_shake_enabled, is_vibration_enabled)
}
