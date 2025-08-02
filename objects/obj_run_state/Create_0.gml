season = 0
seasons = ["Spring", "Summer", "Autumn", "Winter"]
year = 0

resources = {}
resources[RESOURCE.EARTH] = 99
resources[RESOURCE.FIRE] = 99
resources[RESOURCE.WATER] = 99
resources[RESOURCE.WIND] = 99
resources[RESOURCE.WOOD] = 0
resources[RESOURCE.SOUL] = 99

portal_status = "broken" // "in progress" "complete"

on_loop_completed = function() {
    season += 1
    if (season >= 4) {
        season = 0
        year += 1
    }
}