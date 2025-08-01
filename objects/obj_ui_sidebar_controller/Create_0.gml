start_x = 256 + 32 + 10
start_y = 10

ui_draw_button = function(_x, _y, text) {
    var width = 172
    draw_sprite_stretched(spr_button_outline, 0, _x, _y, width, 16)
    var text_width = string_width(text)
    var _tx = _x + width / 2 - text_width / 2
    draw_text(_tx, _y + 4, text)
}

ui_draw_resource_counter = function(_x, _y, resource, count) {
    draw_sprite_stretched(spr_resource_outline_with_counter, 0, _x, _y, 32, 16)
    draw_sprite(get_resource_sprite(resource), 0, _x, _y)
    draw_text(_x + 18, _y + 5, count)
}