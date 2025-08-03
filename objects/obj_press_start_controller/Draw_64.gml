draw_set_font(font_lamano)
draw_set_color($baedf5)

draw_text(8, 8, "The Waystone Circle")

draw_set_font(font_cc)
draw_text(204, 174, "Press ")

var icon = InputIconGet(INPUT_VERB.ACCEPT)
if (is_string(icon)) {
    draw_text(204 + 7*6, 174, icon)
} else {
    draw_sprite(icon, 0, 204 + 7*6, 174)
}