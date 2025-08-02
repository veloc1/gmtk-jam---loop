var oldFog = gpu_get_fog();
if (blend_white) {
    gpu_set_fog(true, c_white, 0, 0);    
}

draw_self()

if (blend_white) {
    gpu_set_fog(oldFog[0], oldFog[1], oldFog[2], oldFog[3]);
}