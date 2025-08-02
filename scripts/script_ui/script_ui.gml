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