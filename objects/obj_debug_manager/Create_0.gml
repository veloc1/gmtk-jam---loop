/// @description Init

display_state = 2
debug_state = 0

/*stats_view = undefined
weapons_view = undefined
weapons_list_str = ""
weapon_to_add = -1

create_stats_view = function() {
    stats_view = dbg_view("Stats", true, 1366-512, 128, 512, 128)
    dbg_slider(ref_create(obj_player.stats, "reload_time_modifier"), 0.1, 1, "reload_time_modifier", 0.1);
    dbg_slider_int(ref_create(obj_player.stats, "pickup_distance"), 0, 1000, "pickup_distance");
}

create_weapons_view = function() {
    weapons_view = dbg_view("Weapons", true, 1366-512, 128 + 128, 512, 256)
    
    dbg_text(ref_create(self, "weapons_list_str"));
    dbg_text_separator("Controls");
    var _ref = ref_create(self, "weapon_to_add");
    
    //enum WEAPON {
    //GUN,
    //FIREBALL,
    //LANCE,
    //BOMB,
    //THUNDER,
    //CLOVER,
    //HEART,
    //}
    var weapons = [
        "gun",
        "fireball",
        "lance",
        "bomb",
        "thunder",
        "clover",
        "heart",
    ]
    var _ws = ""
    for (var i = 0; i < array_length(weapons); i++) {
        _ws += $"{weapons[i]}:{i},"
    }
    dbg_drop_down(_ref, _ws);
    dbg_button("Add selected weapon", add_weapon);
    dbg_button("Clear all", clear_weapons);
}
add_weapon = function() {
    obj_player.pickup_weapon(weapon_to_add)
}
clear_weapons = function() {
    obj_player.weapons = []
}

refresh_weapons_list = function() {
    if (!instance_exists(obj_player)) {
        return
    }
    weapons_list_str = ""
    for(var i = 0; i < array_length(obj_player.weapons); i++) {
        var w = obj_player.weapons[i]
        weapons_list_str +=  instanceof(w) + "\n"
    }
}

create_views = function() {
    create_stats_view()
    create_weapons_view()
}
clear_views = function() {
    if (dbg_view_exists(stats_view)) {
        dbg_view_delete(stats_view)
    }
    if (dbg_view_exists(weapons_view)) {
        dbg_view_delete(weapons_view)
    }
}*/