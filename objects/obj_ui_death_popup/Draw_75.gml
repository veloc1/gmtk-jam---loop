draw_set_font(font_cc)

draw_set_color($1c0e1f)
draw_set_alpha(0.3)
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false)

draw_set_alpha(1)
draw_set_color($baedf5)



draw_sprite_stretched(spr_ui_sidebar_panel, 0, left, top, width, height)

var text = "Game Over"
var tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 16, text)


text = "With this character's death,"
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48, text)
text = "the thread of prophecy is severed."
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48 + 12, text)
text = "Restore a saved game to restore the weave of fate,"
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48 + 12 * 2, text)
text = "or persist in the doomed world you have created."
tw = string_width(text)
draw_text(left + width / 2 - tw / 2, top + 48 + 12 * 3, text)

restart_button.draw()