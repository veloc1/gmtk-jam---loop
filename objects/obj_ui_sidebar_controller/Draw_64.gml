draw_set_font(font_cc)

draw_set_color($baedf5)

draw_sprite_stretched(spr_ui_sidebar_panel, 0, display_get_gui_width() - 126 * 1.5, 0, 126 * 1.5, 180 * 1.5)

var _y = start_y
draw_text(start_x, _y, string("Currently in {0} province (out of {1})", obj_segments_manager.current_segment + 1, obj_segments_manager.segments_count))

_y += 9
draw_text(start_x, _y, string("{0}, Year {1}", obj_run_state.seasons[obj_run_state.season], obj_run_state.year))

_y += 9
var width = 172

var next_move_timer = obj_move_controller.timer_next_move
var p = 0
if (next_move_timer != undefined) {
    p = next_move_timer.get_completion_percent()
}
draw_sprite_stretched(spr_turn_rect_fill, 0, start_x, _y, width * p, 8)
draw_sprite_stretched(spr_turn_rect_outline, 0, start_x, _y, width, 8)


#region buttons
for (var i = 0; i < array_length(obj_actions_controller.actions); i++) {
    var action = obj_actions_controller.actions[i]
    _y += 18
    ui_draw_button(start_x, _y, action.title)
}
#endregion


#region resources
_y = display_get_gui_height() - 24
var _x = start_x

ui_draw_resource_counter(_x,_y, RESOURCE.EARTH, string("{0}", obj_player.resources[RESOURCE.EARTH]))
_x += 34
ui_draw_resource_counter(_x,_y, RESOURCE.FIRE, string("{0}", obj_player.resources[RESOURCE.FIRE]))
_x += 34
ui_draw_resource_counter(_x,_y, RESOURCE.WIND, string("{0}", obj_player.resources[RESOURCE.WIND]))
_x += 34
ui_draw_resource_counter(_x,_y, RESOURCE.WATER, string("{0}", obj_player.resources[RESOURCE.WATER]))

#endregion

