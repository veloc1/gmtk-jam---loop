function BehaviourObject(_gameobject) constructor {
    behaviours = []
    current_behaviour = noone
    previous_behaviour = noone
    go = _gameobject
    
    /// @param {Struct.Behaviour} behaviour behaviour to add
    add = function (behaviour) {
        behaviour.set_game_object(go)
        array_push(behaviours, behaviour)
        if (!current_behaviour) {
            current_behaviour = behaviour
            current_behaviour.on_start()
        }
    }
    
    update = function () {
        if (current_behaviour != noone) {
            current_behaviour.lifetime += obj_time_manager.game_speed
            
            var new_behaviour_name = current_behaviour.on_step()
            if (new_behaviour_name) {
                change(new_behaviour_name)
            }
        }
    }
    /// @param {String} _new_behaviour_name description
    change = function(_new_behaviour_name) {
        var new_behaviour = noone
        var found_behaviour = false
        if (_new_behaviour_name != undefined and _new_behaviour_name != noone) {
            for (var i = 0; i < array_length(behaviours); i++) {
                var behaviour = behaviours[i]
                if (behaviour.name == _new_behaviour_name) {
                    new_behaviour = behaviour
                    found_behaviour = true
                    break
                }
            }
            
            if (found_behaviour) {
                current_behaviour.on_end()
                previous_behaviour = current_behaviour
                
                new_behaviour.on_start()
                current_behaviour = new_behaviour
            } else {
                show_debug_message("Cannot find behaviour to change {0}", _new_behaviour_name)
            }
        }
    }
    
    current_behaviour_name = function() {
        if (!current_behaviour) {
            return ""
        }
        return current_behaviour.name
    }
    
    on_animation_end = function() {
        current_behaviour.on_animation_end()
    }
}

function _get_func_or_empty(_funcs, _name) {
    var _func = noone
    if (struct_exists(_funcs, _name)) {
        _func = _funcs[$ _name]
    } else {
        _func= function() {}
    }
    return _func
}

/// @param {string} _name
/// @param {Struct} _funcs struct with functions {on_start, on_step, on_end}
function Behaviour(_name, _funcs) constructor {
    lifetime = 0
    name = _name
    go = noone
    funcs = _funcs
    
    set_game_object = function(_go) {
        go = _go
        on_start = method(go, _get_func_or_empty(funcs, "on_start"))
        on_step = method(go, _get_func_or_empty(funcs, "on_step"))
        on_end = method(go, _get_func_or_empty(funcs, "on_end"))
        on_animation_end = method(go, _get_func_or_empty(funcs, "on_animation_end"))
    }
}



