enum RESOURCE {
    EARTH,
    FIRE,
    WATER,
    WIND,
    WOOD,
    SOUL,
}

function UIIncrementedResource(resource) constructor  {
    self.resource = resource
    self.x = 0
    self.y = 0
    self.lifetime = 0
    self.scale = 1
    self.to_delete = false
}
function UIInsufficientResource(resource) constructor  {
    self.resource = resource
    self.x = 0
    self.y = 0
    self.lifetime = 0
    self.scale = 1
    self.to_delete = false
}

function get_resource_sprite(resource) { 
    return [
        spr_earth,
        spr_fire,
        spr_water,
        spr_wind,
        spr_wood,
        spr_souls
    ][resource]
}

function add_resource_to_player(from_x, from_y, resource, delay = 0) {
    var a = instance_create_layer(from_x, from_y, "Instances1", obj_resource_collect_anim)
    a.resource = resource    
    a.delay = delay
}
function take_resource_from_player(from_x, from_y, resource) {
    var a = instance_create_layer(from_x, from_y, "Instances1", obj_resource_take_anim)
    a.resource = resource
}

function increment_resource_in_ui(resource) {
    obj_ui_sidebar_controller.increment_resource(resource)
}
function decrement_resource_in_ui(resource) {
    obj_ui_sidebar_controller.decrement_resource(resource)
}

function show_insufficient_resource_in_ui(resource) {
    obj_ui_sidebar_controller.insufficient_resource(resource)
}