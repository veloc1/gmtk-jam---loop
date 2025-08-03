if (status == "idle") {
    
} else if (status == "fade-in") {
    alpha += fade_speed
    if (alpha >= 1) {
        status = "idle"
        if (on_end != undefined) {
            on_end()
            on_end = undefined
        }
        
    }
} else if (status == "fade-out") {
    alpha -= fade_speed
    if (alpha <= 0) {
        status = "idle"
        if (on_end != undefined) {
            on_end()
            on_end = undefined
        }
        
    }
}