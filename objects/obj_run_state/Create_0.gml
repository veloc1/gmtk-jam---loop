season = 0
seasons = ["Spring", "Summer", "Autumn", "Winter"]
year = 0

resources = {}
resources[RESOURCE.EARTH] = 0
resources[RESOURCE.FIRE] = 10
resources[RESOURCE.WATER] = 12
resources[RESOURCE.WIND] = 13
resources[RESOURCE.WOOD] = 0
resources[RESOURCE.SOUL] = 0

on_loop_completed = function() {
    season += 1
    if (season >= 4) {
        season = 0
        year += 1
    }
}