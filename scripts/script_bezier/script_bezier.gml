

/// @function    draw_bezier(x1, y1, x2, y2, x3, y3)
/// @param x1 {Real} The X coordinate of the first control point.
/// @param y1 {Real} The Y coordinate of the first control point.
/// @param x2 {Real} The X coordinate of the second control point.
/// @param y2 {Real} The Y coordinate of the second control point.
/// @param x3 {Real} The X coordinate of the third control point.
/// @param y3 {Real} The Y coordinate of the third control point.
/// @param x4 {Real} The X coordinate of the third control point.
/// @param y4 {Real} The Y coordinate of the third control point.
function draw_bezier(x1, y1, x2, y2, x3, y3, x4, y4) {
    var _step = 0.05;
    draw_primitive_begin(pr_linestrip);
    draw_vertex(x1, y1);
    for (var i = 0; i <= 1; i += _step) {
        // get intermediate coordinates
        var ix = lerp(x1, x2, i);
        var iy = lerp(y1, y2, i);
        var jx = lerp(x2, x3, i);
        var jy = lerp(y2, y3, i);
        var kx = lerp(x3, x4, i);
        var ky = lerp(y3, y4, i);
        
        // get further intermediate coordinates
        var iix = lerp(ix, jx, i);
        var iiy = lerp(iy, jy, i);
        var jjx = lerp(jx, kx, i);
        var jjy = lerp(jy, ky, i);

        // get final curve point
        var bx = lerp(iix, jjx, i);
        var by = lerp(iiy, jjy, i);
        draw_vertex(bx, by);
    }
    draw_vertex(x4, y4);
    draw_primitive_end();
}

function get_bezier_point(x1, y1, x2, y2, x3, y3, x4, y4, i) {
    // get intermediate coordinates
    var ix = lerp(x1, x2, i);
    var iy = lerp(y1, y2, i);
    var jx = lerp(x2, x3, i);
    var jy = lerp(y2, y3, i);
    var kx = lerp(x3, x4, i);
    var ky = lerp(y3, y4, i);
    
    // get further intermediate coordinates
    var iix = lerp(ix, jx, i);
    var iiy = lerp(iy, jy, i);
    var jjx = lerp(jx, kx, i);
    var jjy = lerp(jy, ky, i);

    // get final curve point
    var bx = lerp(iix, jjx, i);
    var by = lerp(iiy, jjy, i);
    
    return {x: bx, y: by}
}