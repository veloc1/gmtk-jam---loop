y += 2.2
if (y >= 132) {
    obj_screen_shaker.medium_shake()
    
    parent.on_hit()
    
    instance_create_layer(x, y, "Effects", obj_fight_fx_4_3)
    instance_destroy(self)
    
}