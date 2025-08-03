alpha = 0
fade_speed = 0.03
status = "idle"

on_end = undefined

color = $baedf5

fade_in = function(cb = undefined) {
    alpha = 0
    status = "fade-in"
    on_end = cb
}

fade_out = function(cb = undefined) {
    alpha = 1
    status = "fade-out"
    on_end = cb
}