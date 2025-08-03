function play_sound(sound) {
    audio_play_sound(sound, 0, false)
}
function play_sound_if_not_played (sound) {
    if (!audio_is_playing(sound)) {
        audio_play_sound(sound, 0, false)
    }
}
function play_random_sound (_sounds) {
    var sound = _sounds[floor(random(array_length(_sounds)))]
    audio_play_sound(sound, 0, false, 1, 0, 1)
}
function play_random_sound_random_pitch (_sounds) {
    var sound = _sounds[floor(random(array_length(_sounds)))]
    audio_play_sound(sound, 0, false, 1, 0, random_range(0.85, 1.15))
}
function  play_sound_random_pitch(sound) {
    audio_play_sound(sound, 0, false, 1, 0, random_range(0.85, 1.15))
}

