x += 3
if (x > 200) {
    instance_destroy(self)
}
image_alpha = lerp(image_alpha, target_alpha, 0.1)
if (image_alpha < 0.1) {
    instance_destroy(self)
}