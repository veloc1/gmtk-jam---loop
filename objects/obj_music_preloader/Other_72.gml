/// @description On music loaded
if (async_load[? "type"] == "audiogroup_load") {
    loaded_groups ++
}
if (loaded_groups == 2) {
    room_goto_next()    
}
