function UIButton(_x, _y, text) constructor {
    self.x = _x
    self.y = _y
    self.text = text
    self.width = 128
    self.height = 18
    self.shortcut = undefined
    self.callback = function() {}
    
    game_to_gui_ratio = 1.5
    
    step = function() {
        if (shortcut != undefined) {
            if (InputPressed(shortcut)) {
                callback()
            }
        }
        if (device_mouse_check_button_pressed(0, mb_left)) {
            if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + width, y + height)) {
                callback()
            }
        }
    }
    
    draw = function() {
        draw_sprite_stretched(spr_button_outline, 0, x, y, width, height)
        var text_width = string_width(text)
        var _tx = x + width / 2 - text_width / 2
        draw_text(_tx, y + 6, text)
        
        if (shortcut) {
            var icon = InputIconGet(shortcut)
            if (is_string(icon)) {
                draw_text(_tx + text_width + 2, y + 6, icon)
            } else {
                draw_sprite(icon, 0, _tx + text_width + 2, y + 5)    
            }
            
        }
    }
}

function UIActionButton(_x, _y, text) constructor {
    self.x = _x
    self.y = _y
    self.text = text
    self.width = 128
    self.height = 36
    self.shortcut = undefined
    self.action = undefined
    
    self.has_second_line = false
    
    game_to_gui_ratio = 1.5
    
    step = function() {
        if (shortcut != undefined) {
            if (InputPressed(shortcut)) {
                action.func()
            }
        }
        if (device_mouse_check_button_pressed(0, mb_left)) {
            if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + width, y + height)) {
                action.func()
            }
        }
        if (action != undefined) {
            has_second_line = false
            height = 18
            if (array_length(action.requirements) > 0 or array_length(action.outcome) > 0) {
                has_second_line = true
                height = 36
            }
        }
    }
    
    draw = function() {
        draw_sprite_stretched(spr_button_outline, 0, x, y, width, height)
        var text_width = string_width(text)
        var _tx = x + width / 2 - text_width / 2
        draw_text(_tx, y + 6, text)
        
        if (shortcut) {
            var icon = InputIconGet(shortcut)
            if (is_string(icon)) {
                draw_text(_tx + text_width + 2, y + 6, icon)
            } else {
                draw_sprite(icon, 0, _tx + text_width + 2, y + 5)    
            }
        }
        
        for (var i = 0; i < array_length(action.requirements); i++) {
            var r = action.requirements[i]
            var s = 16 + 8 + 2 // icon + text + padding
            draw_sprite(get_resource_sprite(r.resource), 0, x + 10 + i * s, y + height - 12)
            draw_text(x + 20 + i * s, y + height - 16, r.count)
        }
        
        for (var i = 0; i < array_length(action.outcome); i++) {
            var r = action.outcome[i]
            var s = 16 + 8 + 2 // icon + text + padding
            draw_sprite(get_resource_sprite(r.resource), 0, x + width - 26 - i * s, y + height - 12)
            draw_text(x + width - 16 - i * s, y + height - 16, r.count)
        }
    }
}