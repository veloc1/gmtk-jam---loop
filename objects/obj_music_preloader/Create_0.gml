/// @description 

loaded_groups = 0
if (!audio_group_is_loaded(ag_sfx)) {
    audio_group_load(ag_sfx) 
} else {
    loaded_groups += 1
}
if (!audio_group_is_loaded(ag_music)) {
    audio_group_load(ag_music) 
    loaded_groups += 1
}

if (loaded_groups == 2) {
    room_goto_next()    
}
