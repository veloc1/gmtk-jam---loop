enum ACTION {
    COLLECT_MANA,
    BUILD_PORTAL,
    BUILD_MILL,
    TELEPORT,
    FIGHT,
    REPEL,
    ENDURE,
    HEAL,
    SKIP,
}

function Action(title, func, requirements, outcome) constructor {
    self.title = title
    self.func = func
    self.requirements = requirements
    self.outcome = outcome
}

function Req(resource, count) constructor {
    self.resource = resource
    self.count = count
}

function get_action_description(action) {
    var actions = []
    actions[ACTION.COLLECT_MANA] = new Action("Collect mana", action_collect_mana, [], [])
    actions[ACTION.BUILD_PORTAL] = new Action("! Build portal", action_build_portal, get_portal_requirements(), [])
    actions[ACTION.BUILD_MILL] = new Action("Build mill", action_build_mill, get_building_description(BUILDING.MILL).requirements, [new Req(RESOURCE.BUILDING, 1), new Req(RESOURCE.FIRE, 1)])
    actions[ACTION.TELEPORT] = new Action("Teleport", action_teleport, [new Req(RESOURCE.FIRE, 1)], [])
    actions[ACTION.FIGHT] = new Action("Fight", action_fight, [new Req(RESOURCE.FIRE, 1)], [])
    actions[ACTION.REPEL] = new Action("Repel", action_repel, [new Req(RESOURCE.WIND, 1)], [])
    actions[ACTION.ENDURE] = new Action("Endure", action_take_hit, [new Req(RESOURCE.HP, 1)], [])
    actions[ACTION.HEAL] = new Action("Heal", action_heal, [new Req(RESOURCE.SOUL, 1)], [new Req(RESOURCE.HP, 1)])
    actions[ACTION.SKIP] = new Action("Skip", action_skip, [], [])
    
    return actions[action]
}

function action_collect_mana() {
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    
    segment.ground = GROUND.CORRUPTED
    obj_move_controller.pause_move_timer()
    
    instance_create_layer(obj_player.bbox_right + 36, obj_player.bbox_bottom + 24, "Effects", obj_mana_collect_fx)
    
    obj_time_manager.schedule_alarm(0.26, function() {
        obj_screen_shaker.medium_shake(270)
    })
    
    obj_time_manager.schedule_alarm(1.2, function() {
        var ground_instance = instance_nearest(obj_player.bbox_right, obj_player.bbox_bottom, obj_ground)
        if (ground_instance != undefined) {
            ground_instance.corrupt()
            
            for(var i = 0; i < array_length(ground_instance.resources_inst); i++) {
                var r = ground_instance.resources_inst[i]
                
                add_resource_to_player(r.x, r.y, r.resource, i * 16)
            }
        }
    })
    
    obj_time_manager.schedule_alarm(1.5, function() {
        obj_move_controller.skip_idle()
    })
    
    obj_actions_controller.clear_actions()
}

function action_build(building, reqs) {
    if (_action_has_resources(reqs)) {
        obj_actions_controller.clear_actions()
        _action_take_resources(reqs)
        obj_move_controller.pause_move_timer()
        
        var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
        
        if (building == BUILDING.PORTAL) {
            if (obj_run_state.portal_status == "broken") {
                obj_run_state.portal_status = "in progress"
            } else if (obj_run_state.portal_status == "in progress") {
                obj_run_state.portal_status = "complete"
            } else {
                show_debug_message("wrong condition on portal building")
            }
        } else {
            segment.building = building
        }
        
        obj_move_controller.pause_move_timer()
        
        obj_screen_shaker.small_shake(90)
        
        instance_create_layer(obj_player.bbox_right + 60, obj_player.bbox_bottom, "Ground0", obj_building_place)
        
        obj_time_manager.schedule_alarm(1.5, function() {
            obj_move_controller.skip_idle()
        })
    } else {
        _action_show_insufficient_resources(reqs)
    }
}

function action_build_portal() {
    action_build(BUILDING.PORTAL, get_portal_requirements())
}

function action_build_mill() {
    action_build(BUILDING.MILL, get_building_description(BUILDING.MILL).requirements)
}

function action_teleport() {
}

function action_fight() {
    var reqs = get_action_description(ACTION.FIGHT).requirements
    
    if (_action_has_resources(reqs)) {
        obj_actions_controller.clear_actions()
        _action_take_resources(reqs)
        obj_move_controller.pause_move_timer()
        
        obj_time_manager.schedule_alarm(0.9, function() {
            var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
            if (enemy_instance != undefined) {
                var fx = instance_create_layer(enemy_instance.x, enemy_instance.y, "Instances1", obj_fight_fx_1)    
                fx.enemy = enemy_instance
            }
        })
        
        obj_time_manager.schedule_alarm(1.4, function() {
            var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
            if (enemy_instance != undefined) {
                var enemy_type = enemy_instance.type
                var ex = enemy_instance.x
                var ey = enemy_instance.bbox_top
                var is_dead = enemy_instance.damage(1)
                if (is_dead) {
                    var desc = get_enemy_description(enemy_type)
                    var _x = 0
                    for (var i = 0; i < array_length(desc.rewards); i++) {
                        var r = desc.rewards[i]
                        add_resource_to_player(ex + _x, ey - 10, r, i * 16)
                        _x += 18
                    }
                    
                    obj_time_manager.schedule_alarm(2.3, function() {
                        obj_move_controller.enable_idle_timer()
                        obj_move_controller.skip_idle()
                    })
                    
                    obj_actions_controller.clear_actions()            
                } else {
                    obj_time_manager.schedule_alarm(1.6, function() {
                        var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
                        if (enemy_instance != undefined) {
                            enemy_instance.attack_anim()
                        }
                    })
                    
                    obj_time_manager.schedule_alarm(2.8, function() {
                        obj_actions_controller.set_fight_actions()
                    })
                    
                }
            }
        })
        
    } else {
        _action_show_insufficient_resources(reqs)
    }
}

function action_repel() {
    show_insufficient_resource_in_ui(RESOURCE.WIND)
}

function action_take_hit() {
    var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
    if (enemy_instance != undefined) {
        enemy_instance.attack_anim()
    }
}


function action_heal() {
    var diff = obj_player.max_hp - obj_player.hp
    var souls = obj_run_state.resources[RESOURCE.SOUL]
    var r = min(souls, diff)
    var reqs = [new Req(RESOURCE.SOUL, r)]
    
    if (r <= 0) {
        _action_show_insufficient_resources(reqs, true)
        return
    }
    
    obj_actions_controller.clear_actions()
    _action_take_resources(reqs)
    obj_move_controller.pause_move_timer()
    
    obj_time_manager.schedule_alarm(0.5, function() {
        var diff = obj_player.max_hp - obj_player.hp
        var souls = obj_run_state.resources[RESOURCE.SOUL]
        var r = min(souls, diff)
        var outcome = [new Req(RESOURCE.HP, r)]
        
        var building = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_building)
        if (building != undefined) {
            var ex = building.x
            var ey = building.y - 16
            var _x = 0
                
            for (var i = 0; i < array_length(outcome); i++) {
                var res = outcome[i]
                for (var j = 0; j < res.count; j++) {
                    add_resource_to_player(ex + _x, ey, res.resource, (i + j) * 16)
                    _x += 18
                }
                
            }    
        }
    })
    
    obj_time_manager.schedule_alarm(1.5, function() {
        obj_move_controller.skip_idle()
    })
    
}

function action_skip() {
    obj_move_controller.skip_idle()
    
    obj_actions_controller.clear_actions()
}

function _action_has_resources(resources) {
    var has_res = true
    for (var i = 0; i < array_length(resources); i++) { 
        var r = resources[i]
        if (obj_run_state.resources[r.resource] < r.count) {
            has_res = false
        }
    }
    return has_res
}

function _action_show_insufficient_resources(reqs, force=false) {
    for (var i = 0; i < array_length(reqs); i++) { 
        var r = reqs[i]
        if (force or obj_run_state.resources[r.resource] < r.count) {
            show_insufficient_resource_in_ui(r.resource)
        }
    }
}

function _action_take_resources(resources) {
    var _x = obj_player.x + obj_player.sprite_width / 2
    var _y = obj_player.bbox_top
    
    var c = 0
    
    for (var i = 0; i < array_length(resources); i++) { 
        var r = resources[i]
        obj_run_state.resources[r.resource] -= r.count
        decrement_resource_in_ui(r.resource)
        for (var j = 0; j < r.count; j++) { 
            take_resource_from_player(_x, _y, r.resource, c * 16)
            c += 1
        }
        // _x += 20
    }
}