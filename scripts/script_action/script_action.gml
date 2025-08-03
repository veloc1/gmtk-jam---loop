enum ACTION {
    COLLECT_MANA,
    BUILD_PORTAL,
    BUILD_MILL,
    BUILD_FARM,
    BUILD_QUARRY,
    BUILD_NECROPOL,
    BUILD_VILLAGE,
    TELEPORT,
    FIGHT,
    REPEL,
    ENDURE,
    HEAL,
    SKIP,
    OK,
}

function Action(title, func, requirements, outcome) constructor {
    self.title = title
    self.func = func
    self.requirements = requirements
    self.outcome = outcome
}

function ResCount(resource, count) constructor {
    self.resource = resource
    self.count = count
}

function get_action_description(action) {
    var actions = []
    actions[ACTION.COLLECT_MANA] = new Action("Collect mana", action_collect_mana, [], [])
    actions[ACTION.BUILD_PORTAL] = new Action("! Build portal", action_build_portal, get_portal_requirements(), [])
    
    actions[ACTION.BUILD_MILL] = new Action(
        "Build mill", 
        action_build_mill, 
        get_building_description(BUILDING.MILL).requirements, 
        array_concat([new ResCount(RESOURCE.BUILDING, 1)], get_building_description(BUILDING.MILL).resources)
    )
    actions[ACTION.BUILD_FARM] = new Action(
        "Build farm", 
        action_build_farm, 
        get_building_description(BUILDING.FARM).requirements, 
        array_concat(get_building_description(BUILDING.FARM).resources, [new ResCount(RESOURCE.BUILDING, 1)])
    )
    actions[ACTION.BUILD_QUARRY] = new Action(
        "Build quarry", 
        action_build_quarry, 
        get_building_description(BUILDING.QUARRY).requirements, 
        array_concat(get_building_description(BUILDING.QUARRY).resources, [new ResCount(RESOURCE.BUILDING, 1)])
    )
    actions[ACTION.BUILD_NECROPOL] = new Action(
        "Build necropol", 
        action_build_necropol, 
        get_building_description(BUILDING.NECROPOL).requirements, 
        array_concat(get_building_description(BUILDING.NECROPOL).resources, [new ResCount(RESOURCE.BUILDING, 1)])
    )
    actions[ACTION.BUILD_VILLAGE] = new Action(
        "Build village", 
        action_build_village, 
        get_building_description(BUILDING.VILLAGE).requirements, 
        array_concat(get_building_description(BUILDING.VILLAGE).resources, [new ResCount(RESOURCE.BUILDING, 1)])
    )
    
    actions[ACTION.TELEPORT] = new Action("Teleport", action_teleport, [], [])
    actions[ACTION.FIGHT] = new Action("Fight", action_fight, [new ResCount(RESOURCE.FIRE, 1)], [])
    actions[ACTION.REPEL] = new Action("Repel", action_repel, [new ResCount(RESOURCE.WIND, 1)], [])
    actions[ACTION.ENDURE] = new Action("Endure", action_take_hit, [new ResCount(RESOURCE.HP, 1)], [])
    actions[ACTION.HEAL] = new Action("Heal", action_heal, [new ResCount(RESOURCE.SOUL, 1)], [new ResCount(RESOURCE.HP, 1)])
    actions[ACTION.SKIP] = new Action("Skip", action_skip, [], [])
    actions[ACTION.OK] = new Action("OK?", action_ok, [], [])
    
    return actions[action]
}

function action_collect_mana() {
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    
    // segment.ground = GROUND.CORRUPTED
    obj_move_controller.pause_move_timer()
    
    instance_create_layer(obj_player.bbox_right + 36, obj_player.bbox_bottom + 24, "Effects", obj_mana_collect_fx)
    
    obj_time_manager.schedule_alarm(0.26, function() {
        obj_screen_shaker.medium_shake(270)
        play_sound(snd_collect_mana)
    })
    
    obj_time_manager.schedule_alarm(1.2, function() {
        var ground_instance = instance_nearest(obj_player.bbox_right, obj_player.bbox_bottom, obj_ground)
        if (ground_instance != undefined) {
            // ground_instance.corrupt()
            
            for(var i = 0; i < array_length(ground_instance.resources_inst); i++) {
                var r = ground_instance.resources_inst[i]
                
                add_resource_to_player(r.x + 10, r.y + 10, r.resource, i * 16)
            }
        }
    })
    
    obj_time_manager.schedule_alarm(1.5, function() {
        obj_move_controller.skip_idle()
    })
    
    obj_actions_controller.clear_actions()
    
    play_sound(snd_click)
}

function action_build(building, reqs) {
    if (_action_has_resources(reqs)) {
        obj_actions_controller.clear_actions()
        _action_take_resources(reqs)
        obj_move_controller.pause_move_timer()
        
        play_sound(snd_click)
        
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
            segment.has_ruins = false
        }
        
        obj_move_controller.pause_move_timer()
        
        obj_screen_shaker.small_shake(90)
        
        instance_create_layer(obj_player.bbox_right + 60, obj_player.bbox_bottom, "Ground0", obj_building_place)
        var ruins = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_ruins)
        if (instance_exists(ruins)) {
            ruins.move_down()
        }
        
        play_sound(snd_build)
        
        obj_time_manager.schedule_alarm(1.5, function() {
            obj_move_controller.skip_idle()
        })
    } else {
        _action_show_insufficient_resources(reqs)
        play_sound(snd_no_res)
    }
}

function action_build_portal() {
    var reqs = get_portal_requirements()
    
    if (_action_has_resources(reqs)) {
        obj_actions_controller.clear_actions()
        _action_take_resources(reqs)
        obj_move_controller.pause_move_timer()
        
        play_sound(snd_click)
        
        var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
        
        if (obj_run_state.portal_status == "broken") {
            obj_run_state.portal_status = "in progress"
        } else if (obj_run_state.portal_status == "in progress") {
            obj_run_state.portal_status = "complete"
        } else {
            show_debug_message("wrong condition on portal building")
        }
        
        obj_screen_shaker.small_shake(90)
        
        instance_create_layer(obj_player.bbox_right + 60, obj_player.bbox_bottom, "Ground0", obj_building_place)
        var ruins = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_ruins)
        if (instance_exists(ruins)) {
            ruins.move_down()
        }
        
        play_sound(snd_build)
        
        obj_time_manager.schedule_alarm(1.5, function() {
            action_teleport()
        })
    } else {
        _action_show_insufficient_resources(reqs)
        play_sound(snd_no_res)
    }
}

function action_build_mill() {
    action_build(BUILDING.MILL, get_building_description(BUILDING.MILL).requirements)
}
function action_build_farm() {
    action_build(BUILDING.FARM, get_building_description(BUILDING.FARM).requirements)
}
function action_build_quarry() {
    action_build(BUILDING.QUARRY, get_building_description(BUILDING.QUARRY).requirements)
}
function action_build_necropol() {
    action_build(BUILDING.NECROPOL, get_building_description(BUILDING.NECROPOL).requirements)
}
function action_build_village() {
    action_build(BUILDING.VILLAGE, get_building_description(BUILDING.VILLAGE).requirements)
}

function action_teleport() {
    obj_actions_controller.clear_actions()
    play_sound(snd_click)
    
    obj_fader.color = $1F0E1C
    
    obj_fader.fade_in(function() {
        obj_move_controller.move_immediate(function() {
            obj_fader.fade_out()
            obj_move_controller.resume_move_timer()
        })
    })
}

function action_fight() {
    var reqs = get_action_description(ACTION.FIGHT).requirements
    
    if (_action_has_resources(reqs)) {
        obj_actions_controller.clear_actions()
        _action_take_resources(reqs)
        obj_move_controller.pause_move_timer()
        
        play_sound(snd_click)
        
        obj_time_manager.schedule_alarm(0.9, function() {
            var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
            if (enemy_instance != undefined) {
                var fxs = [
                    obj_fight_fx_1,
                    obj_fight_fx_2,
                    //obj_fight_fx_3,
                    obj_fight_fx_4, 
                ]
                var fi = irandom(array_length(fxs) - 1)
                var fx = instance_create_layer(enemy_instance.x, enemy_instance.y, "Instances1", fxs[fi])    
                fx.enemy = enemy_instance
                fx.on_hit = _action_hit_enemy
            }
        })
    } else {
        _action_show_insufficient_resources(reqs)
        play_sound(snd_no_res)
    }
}

function action_repel() {
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    var enemy = get_enemy_description(segment.enemy)
    var reqs = get_action_description(ACTION.REPEL).requirements
    reqs = [new ResCount(RESOURCE.WIND, enemy.hp)]
    if (_action_has_resources(reqs)) {
        obj_actions_controller.clear_actions()
        _action_take_resources(reqs)
        obj_move_controller.pause_move_timer()
        
        play_sound(snd_click)
        
        obj_time_manager.schedule_alarm(0.9, function() {
            var tornado = instance_create_layer(obj_player.x, obj_player.bbox_bottom, "Effects", obj_tornado)    
            play_sound(snd_repel)
        })
        obj_time_manager.schedule_alarm(1.8, function() {
            obj_move_controller.enable_idle_timer()
            obj_move_controller.skip_idle()
        })
    } else {
        _action_show_insufficient_resources(reqs)
        play_sound(snd_no_res)
    }
}

function action_take_hit() {
    obj_actions_controller.clear_actions()
    obj_move_controller.pause_move_timer()
    
    play_sound(snd_click)
    
    var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
    var enemy = get_enemy_description(segment.enemy)
    
    var time = 0.1
    for (var i = 0; i < enemy.hp; i++) {
        obj_time_manager.schedule_alarm(time, function() {
            var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
            if (enemy_instance != undefined) {
                enemy_instance.attack_anim()
            }    
        })
        time += 0.8
    }
    time += 1.6
    obj_time_manager.schedule_alarm(time, function() {
        obj_move_controller.enable_idle_timer()
        obj_move_controller.skip_idle()
    })
}


function action_heal() {
    var diff = obj_player.max_hp - obj_player.hp
    var souls = obj_run_state.resources[RESOURCE.SOUL]
    var r = min(souls, diff)
    var reqs = [new ResCount(RESOURCE.SOUL, r)]
    
    if (r <= 0) {
        _action_show_insufficient_resources(reqs, true)
        
        play_sound(snd_no_res)
        return
    }
    
    obj_actions_controller.clear_actions()
    
    obj_move_controller.pause_move_timer()
    
    play_sound(snd_click)
    
    obj_time_manager.schedule_alarm(0.5, function() {
        var diff = obj_player.max_hp - obj_player.hp
        var souls = obj_run_state.resources[RESOURCE.SOUL]
        var r = min(souls, diff)
        var reqs = [new ResCount(RESOURCE.SOUL, r)]
        _action_take_resources(reqs)
        
        var outcome = [new ResCount(RESOURCE.HP, r)]
        
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
    
    play_sound(snd_click)
}
function action_ok() {
    obj_move_controller.enable_idle_timer()
    obj_move_controller.skip_idle()
    
    obj_actions_controller.clear_actions()
    
    play_sound(snd_click)
}


function _action_hit_enemy() {
    var enemy_instance = instance_nearest(obj_player.bbox_right + 90, obj_player.bbox_bottom, obj_enemy)
    if (instance_exists(enemy_instance)) {
        var enemy_type = enemy_instance.type
        var ex = enemy_instance.x
        var ey = enemy_instance.bbox_top
        var is_dead = enemy_instance.damage(1)
        if (is_dead) {
            var desc = get_enemy_description(enemy_type)
            var _x = 0
            var c = 0;
            for (var i = 0; i < array_length(desc.rewards); i++) {
                var r = desc.rewards[i]
                var res = r.resource
                
                for (var j = 0; j < r.count; j++) { 
                    add_resource_to_player(ex + _x, ey - 10, res, c * 8)
                    _x += 16
                    c+=1;
                }
            }
            
            var segment = obj_segments_manager.segments[obj_segments_manager.current_segment]
            segment.enemy = undefined
            
            obj_time_manager.schedule_alarm(2.3, function() {
                obj_move_controller.enable_idle_timer()
                obj_move_controller.skip_idle()
            })
            
            obj_actions_controller.clear_actions()            
        } else {
            obj_time_manager.schedule_alarm(0.8, function() {
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