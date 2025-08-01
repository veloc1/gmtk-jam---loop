/// @description Draw counters
draw_set_color(#ffffff)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

var _i = 0
if (display_state == 0) {
  draw_text(2, 2 + 24 * _i++, "F2 - show more info")
} else if (display_state == 1) {
  draw_text(2, 2 + 12 * _i++, string("F3/F4 time manipulation, F5 restart, F6 go to upgrades"))
  draw_text(2, 2 + 12 * _i++, string("FPS: {0}", game_get_speed(gamespeed_fps)))
  draw_text(2, 2 + 12 * _i++, string("Objects count: {0}", instance_count))
 // draw_text(0, 12 + 12 * _i++, string("Particle systems: {0}", array_length(obj_particles_manager.part_systems)))
}

/*if (room == RoomLevel1 && display_state == 0) {
  draw_set_color(#E87654)
  draw_text(0, 12 + 24 * _i++, "Dev Notes: First level designed to farm coins\nand give player ability to test new \nupgrades. Estimated complete time - <30 sec")
  draw_set_color(#ffffff)
}*/
