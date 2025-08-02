width = 240
height = 160

left = display_get_gui_width() / 2 - width / 2
top = display_get_gui_height() / 2 - height / 2

restart_button = new UIButton(left + width / 2 - 128 / 2, top + height - 36, "Restart")
restart_button.width = 128

restart_button.shortcut = INPUT_VERB.ACCEPT

restart_button.callback = function() {
    room_restart()
}