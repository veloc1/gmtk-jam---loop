season = 0
seasons = ["Spring", "Summer", "Autumn", "Winter"]
year = 0

on_loop_completed = function() {
    season += 1
    if (season >= 4) {
        season = 0
        year += 1
    }
}