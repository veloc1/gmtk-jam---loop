resource = RESOURCE.EARTH
is_inited = false

var y_diff = obj_player.y - y
x1 = x
y1 = y
x2 = x
y2 = y + y_diff * 0.5
x3 = x
y3 = y + y_diff * 1.9

start_time = obj_time_manager.game_time
duration = 0.9
delay = 0