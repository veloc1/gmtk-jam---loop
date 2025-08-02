// Inherit the parent event
event_inherited();

var meteor = instance_create_layer(x, y - 86, "Effects", obj_fight_fx_4_2)
meteor.parent = self
meteor.on_hit = on_hit
