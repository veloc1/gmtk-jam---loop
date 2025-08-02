start_x = 256 + 32 + 10
start_y = 10

incremented_resources = []
insufficient_resources = []

ui_draw_action_button = function(_x, _y, text) {
    var width = 172
    draw_sprite_stretched(spr_button_outline, 0, _x, _y, width, 16)
    var text_width = string_width(text)
    var _tx = _x + width / 2 - text_width / 2
    draw_text(_tx, _y + 4, text)
}

ui_draw_resource_counter = function(_x, _y, resource, count) {
    draw_sprite_stretched(spr_resource_outline_with_counter, 0, _x, _y, 32, 20)
    
    var _x_offset = 0
    for (var i = 0; i < array_length(insufficient_resources);i++) {
        var ir = insufficient_resources[i]
        if (ir.resource != resource) {
            continue
        }
        
        ir.lifetime += 1
        if (ir.lifetime > 30) {
            _x_offset = lerp(_x_offset, 0, 0.1)
            if (abs(_x_offset) <= 0.02) {
                ir.to_delete = true
            }
        } else {
            _x_offset = lerp(_x_offset, ir.x, 0.1)
            ir.x = sin(obj_time_manager.game_steps) * 16
        }
    }
    draw_sprite(get_resource_sprite(resource), 0, _x + 10 + _x_offset, _y + 10)
    draw_set_halign(fa_right)
    draw_text(_x + 28, _y + 7, count)
    draw_set_halign(fa_left)
    
    for (var i = 0; i < array_length(incremented_resources);i++) {
        var ir = incremented_resources[i]
        if (ir.resource != resource) {
            continue
        }
        
        ir.y += 0.5
        ir.lifetime += 1
        
        // if (ir.lifetime > 60) {
            ir.scale -= 0.03
            if (ir.scale <= 0.015) {
                ir.to_delete = true
            }
        // }
        
        draw_sprite_ext(get_resource_sprite(resource), 0, _x + 10, _y - ir.y, ir.scale, ir.scale, 0, c_white, 1)
    }
}

increment_resource = function(resource) {
    array_push(incremented_resources, new UIIncrementedResource(resource))
}
decrement_resource = function(resource) {
    array_push(incremented_resources, new UIIncrementedResource(resource))
}
insufficient_resource = function(resource) {
    array_push(insufficient_resources, new UIInsufficientResource(resource))
}