wheel_angle += wheel_speed
if (wheel_angle % 90 < 45) {
    wheel_speed = lerp(wheel_speed, 0.39, 0.03)
} else {
    wheel_speed = lerp(wheel_speed, 0.14, 0.03)
}