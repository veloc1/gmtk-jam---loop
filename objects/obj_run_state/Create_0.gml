season = 3
seasons = ["Spring", "Summer", "Autumn", "Winter"]
year = -1

resources = {}
resources[RESOURCE.EARTH] = 2
resources[RESOURCE.FIRE] = 2
resources[RESOURCE.WATER] = 2
resources[RESOURCE.WIND] = 2


resources[RESOURCE.WOOD] = 1
resources[RESOURCE.SOUL] = 1

portal_status = "broken" // "in progress" "complete"

on_loop_completed = function() {
    season += 1
    if (season >= 4) {
        season = 0
        year += 1
    }
}