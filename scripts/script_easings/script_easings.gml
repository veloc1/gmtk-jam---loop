function easing(t, tmax, from, to, fn_type = "bounce_out") {
    var total_diff = abs(to - from)
    
    var passed = t / tmax
    passed = clamp(passed, 0, 1)
    
    var v = 0
    if (fn_type == "pow") {
        v = pow(passed)
    } else if (fn_type == "ease_in_out_quad") {
        v = easeInOutQuad(passed, 4)
    } else if (fn_type == "ease_out_quart") {
        v = easeOut(passed, 4)
    } else if (fn_type == "bounce_out") {
        v = easeOutBounce1(passed)
    }

    return from + v * total_diff * sign(to - from)
}

function pow(x) {
    return x*x
}


function easeInOutQuad(x) {
    return x < 0.5 ? 2 * x * x : 1 - power(-2 * x + 2, 2) / 2;
}

function easeOut(x, power_count) {
    return 1 - power(1 - x, power_count)
}

function easeOutBounce1(x) {
    if (x < 1/2.75) {
        return 7.5625 * x * x ;
    } else if (x < 2/2.75) {
        x -= 1.5/2.75;
        return (7.5625 * x * x + 0.75);
    } else if (x < 2.5/2.75) {
        x -= 2.25/2.75;
        return (7.5625 * x * x + 0.9375);
    } else {
        x -= 2.625/2.75;
        return (7.5625 * x * x + 0.984375);
    }
}