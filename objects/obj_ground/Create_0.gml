resources_inst = []

corrupt = function() {
    var c = instance_create_layer(x + 32, y, "Ground1", obj_ground_crack)
    c.image_xscale = sign(random_range(-1, 1))
    c.image_alpha = 0
    
    c = instance_create_layer(x + 78, y, "Ground1", obj_ground_crack)
    c.image_xscale = sign(random_range(-1, 1))
    c.image_alpha = 0
    
    c = instance_create_layer(x + 148, y, "Ground1", obj_ground_crack)
    c.image_xscale = sign(random_range(-1, 1))
    c.image_alpha = 0
}