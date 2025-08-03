
if (InputPressed(INPUT_VERB.ACCEPT)) {
    // bgm_play(bgm_main, false, false)
    obj_fader.fade_in(function() {
        room_goto_next()
    })
}