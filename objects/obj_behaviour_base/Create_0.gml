/// @description 

bo = new BehaviourObject(self)

add_behaviour = function(_behaviour) {
    bo.add(_behaviour)
}

/// @param {String} _name behaviour name
change_behaviour = function(_name) {
    bo.change(_name)
}