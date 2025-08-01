/// @description 
if (async_load[? "id"] == load_task_id) {
    if (async_load[? "status"] == false) {
        // TODO Xeneder
        show_debug_message("cannot load")
        return
    }
    
    var state_json = buffer_read(load_buffer, buffer_text)
    var state = json_parse(state_json)
    buffer_delete(load_buffer)
    load_buffer = noone
    
    load_cb(state)
}

if (async_load[? "id"] == save_task_id) {
    if (async_load[? "status"] == false) {
        // TODO Xeneder
        show_debug_message("cannot save")
        return
    }
    
    save_cb()
}