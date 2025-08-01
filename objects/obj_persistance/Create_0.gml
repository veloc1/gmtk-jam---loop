/// @description 

group = "default"
load_buffer = noone
load_task_id = -1
save_task_id = -1

save_cb = function() {}
load_cb = function(state) {}

// html hack
html_data = {}
is_browser = function() {
    return os_browser != browser_not_a_browser
}

save = function(key, data, cb) {
    if (is_browser()) {
        save_html(key, data, cb)
        return
    }
    save_cb = cb
    var state = json_stringify(data)
    
    var buffer = buffer_create(string_byte_length(state) + 1, buffer_fixed, 1)
    buffer_write(buffer, buffer_string, state)
    save_task_id =  buffer_save_async(buffer, key, 0, buffer_get_size(buffer))
    buffer_delete(buffer)
}

load = function(key, cb) {
    if (is_browser()) {
        load_html(key, cb)
        return
    }
    if (file_exists(string("{0}/{1}", group, key))) {
        if (load_buffer != noone) {
            show_debug_message("loading already started") 
            return
        }
        
        load_cb = cb
        load_buffer = buffer_create(1024, buffer_grow, 1)
        load_task_id = buffer_load_async(load_buffer, key, 0, -1)
    }
}
has = function(key) {
    return file_exists(string("{0}/{1}", group, key))
}

save_html = function(key, data, cb) {
    html_data[$ key] = data
    cb()
}
load_html = function(key,  cb) {
    if (struct_exists(html_data, key)) {
        cb(html_data[$ key])
    }
}
