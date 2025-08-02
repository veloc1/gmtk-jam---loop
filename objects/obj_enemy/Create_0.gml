event_inherited()

attack = 0
hp = 0
souls = 0

type = undefined

hp_display = undefined

start_x = x
x_offset = 0

blend_white = false
repel_coords = []
repel_start_time = 0
repel_time = 0

add_behaviour(new Behaviour("idle", {
    
}))
add_behaviour(new Behaviour("prepare_attack", {
    on_start: function() {
        start_x = x
    },
    on_step: function() {
        x_offset += 0.2
        if (x_offset > 1.8) {
            change_behaviour("lunge")
        }
        x = start_x + x_offset
    }
}))
add_behaviour(new Behaviour("lunge", {
    on_start: function() {
        
    },
    on_step: function() {
        x_offset -= 0.5
        if (x_offset < -3) {
            change_behaviour("back-to-idle")
        }
        x = start_x + x_offset
    },
    on_end: function() {
        instance_create_layer(obj_player.x, obj_player.y, "Effects", obj_slash_fx)
        obj_screen_shaker.small_shake(0)
        obj_player.damage()
    }
}))
add_behaviour(new Behaviour("back-to-idle", {
    on_step: function() {
        x_offset += 0.1
        if (x_offset >= 0) {
            x_offset = 0
            change_behaviour("idle")
        }
        x = start_x + x_offset
    }
}))
add_behaviour(new Behaviour("destroy", {
    on_start: function() {
        instance_create_layer(x, y, "Effects", obj_enemy_destroy_fx)
        instance_destroy(hp_display)
        instance_destroy(self)
    }
}))
add_behaviour(new Behaviour("repel", {
    on_start: function() {
        array_push(repel_coords, x)
        array_push(repel_coords, y)
        array_push(repel_coords, x + 30)
        array_push(repel_coords, y)
        array_push(repel_coords, x + 70)
        array_push(repel_coords, y - 60)
        array_push(repel_coords, x - 320)
        array_push(repel_coords, y - 80)
        repel_start_time = obj_time_manager.game_time
        
        instance_destroy(hp_display)
    },
    on_step: function() {
        var t = (obj_time_manager.game_time - repel_start_time) / 0.9
        if (t >= 1) {
            instance_destroy(self)
            return
        }
        var c = get_bezier_point(repel_coords[0], repel_coords[1],repel_coords[2], repel_coords[3],repel_coords[4], repel_coords[5],repel_coords[6], repel_coords[7], t)
        x = c.x
        y = c.y
        image_angle += 1.4
    }
}))


init = function(_type) {
    type = _type
    var desc = get_enemy_description(type)
    attack = desc.damage
    hp = desc.hp
    souls = desc.souls
    
    hp_display = instance_create_layer(x, bbox_top - 12, "Instances1", obj_enemy_health_display)
    hp_display.enemy = self
}

attack_anim = function() {
    change_behaviour("prepare_attack")
}

damage = function(dmg) {
    hp -= dmg
    
    if (hp <= 0) {
        destroy()
        return true
    }
    blink()
    return false
}

blink = function() {
    blend_white = true
    obj_time_manager.schedule_alarm(0.1, function() {
        blend_white = false
    })
}


destroy = function() {
    change_behaviour("destroy")
}

repel = function() {
    if (bo.current_behaviour.name == "repel") {
        return
    }
    change_behaviour("repel")
}
