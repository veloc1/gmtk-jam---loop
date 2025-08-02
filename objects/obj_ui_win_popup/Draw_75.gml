draw_set_font(font_cc)

draw_set_color($1c0e1f)
draw_set_alpha(0.3)
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false)

draw_set_alpha(1)
draw_set_color($baedf5)



draw_sprite_stretched(spr_ui_sidebar_panel, 0, left, top, width, height)

var text = "Cycle complete"
var tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 16, text)


text = "The portal flickers to light."
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48, text)
text = "Through its shimmering depths,"
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48 + 12, text)
text = "a new realm calls."
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48 + 12 * 2, text)
text = "Will you answer?"
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48 + 12 * 3, text)

restart_button.draw()