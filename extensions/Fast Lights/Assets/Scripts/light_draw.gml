///light_draw(x, y, additive, shadows, blur_amount)
/*
Draws the lights and shadows. It makes sense to only draw the surface at 0, 0 if you are not using view or view_xview, view_yview if you are.
x: The x location to draw the shadow map.
y: The y location to draw the shadow map.
additive: Whether to use additive blending or not.
shadows: Whether or not to draw shadows.
blur_amount: How blurry to make the shadows, numbers from 0 to 1 are good but you can go higher for more blurriness.
Blurry shadows generally makes a lower quality lightmap look nicer without the extra memory required for a full quality lightmap.
Important note: The object calling this function should have a lower depth than the casters.
*/

global._light_time += delta_time
if global._light_time >= global._light_max_time
{
    global._light_time = 0
    if !surface_exists(global._light_map) {
        global._light_map = surface_create(global._light_width * global._light_quality, global._light_height * global._light_quality)
    }
    surface_set_target(global._light_map)
    draw_clear(c_white)
    draw_set_blend_mode(bm_normal)
    draw_clear(global._light_color)
    surface_reset_target()
    
    // Draw lights.
    for (var i = 0; i < ds_list_size(global._lights); i++) {
        var _light = ds_list_find_value(global._lights, i)
        with _light {
            var _light_left, _light_top, _light_right, _light_bottom;
            if sprite_get_xoffset(_light_sprite) != sprite_get_width(_light_sprite) / 2 && sprite_get_yoffset(_light_sprite) != sprite_get_height(_light_sprite) / 2 {
                _light_left = x - global._light_size / 2
                _light_top = y - global._light_size / 2
                _light_right = _light_left + global._light_size
                _light_bottom = _light_top + global._light_size
            }
            else {
                _light_left = x - _light_max_dist / 2
                _light_top = y - _light_max_dist / 2
                _light_right = _light_left + _light_max_dist
                _light_bottom = _light_top + _light_max_dist
            }

            var _light_inside = rectangle_in_rectangle(_light_left, _light_top, _light_right, _light_bottom, 
                argument0, argument1, argument0 + global._light_width, argument1 + global._light_height) > 0
            if _light_inside {
                if !_light_shadows {
                    surface_set_target(global._light_map)
                    draw_set_blend_mode(bm_add)
                    draw_sprite_ext(_light_sprite, 0, (x - argument0) * global._light_quality, (y - argument1) * global._light_quality, _light_scale * global._light_quality, _light_scale * global._light_quality, _light_angle, _light_color, _light_alpha)
                    draw_set_blend_mode(bm_normal)
                    surface_reset_target()
                }
                else {
                    if !surface_exists(global._light_surface) {
                        global._light_surface = surface_create(global._light_size * global._light_quality, global._light_size * global._light_quality)
                    }
                    surface_set_target(global._light_surface)
                    draw_clear(c_black)
                    draw_sprite_ext(_light_sprite, 0, global._light_half_size * global._light_quality, global._light_half_size * global._light_quality, 
                        _light_scale * global._light_quality, _light_scale * global._light_quality, _light_angle, _light_color, _light_alpha)
                    if argument3 {
                        // Draw shadows.
                        for (var j = 0; j < ds_list_size(global._light_casters); j++) {
                            var _caster = ds_list_find_value(global._light_casters, j)
                            with _caster {
                                if rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, _light_left, _light_top, _light_right, _light_bottom) {
                                    draw_primitive_begin(pr_trianglestrip)
                                    var points_cast_x, points_cast_y, points_start_x, points_start_y;
                                    // Draw all the cast points.
                                    for(var k = 0; k < array_length_1d(_light_points_x); k++) {
                                        if image_angle != 0 {
                                            points_start_x[k] = x + lengthdir_x(_light_points_x[k] * image_xscale, image_angle) - lengthdir_y(_light_points_y[k] * image_yscale, image_angle)
                                            points_start_y[k] = y + lengthdir_y(_light_points_x[k] * image_xscale, image_angle) + lengthdir_x(_light_points_y[k] * image_yscale, image_angle)
                                        }
                                        else {
                                            points_start_x[k] = x + _light_points_x[k] * image_xscale
                                            points_start_y[k] = y + _light_points_y[k] * image_yscale
                                        }
                                        var dir = point_direction(other.x, other.y, points_start_x[k], points_start_y[k]);
                                        points_cast_x[k] = points_start_x[k] + lengthdir_x(other._light_max_dist, dir)
                                        points_cast_y[k] = points_start_y[k] + lengthdir_y(other._light_max_dist, dir)
                                        
                                        draw_vertex_colour((points_start_x[k] - (other.x - global._light_half_size)) * global._light_quality, (points_start_y[k] - (other.y - global._light_half_size)) * global._light_quality, c_black, 1)
                                        draw_vertex_colour((points_cast_x[k] - (other.x - global._light_half_size)) * global._light_quality, (points_cast_y[k] - (other.y - global._light_half_size)) * global._light_quality, c_black, 1)
                                    }                                    
                                    draw_vertex_colour((points_start_x[0] - (other.x - global._light_half_size)) * global._light_quality, (points_start_y[0] - (other.y - global._light_half_size)) * global._light_quality, c_black, 1)
                                    draw_vertex_colour((points_cast_x[0] - (other.x - global._light_half_size)) * global._light_quality, (points_cast_y[0] - (other.y - global._light_half_size)) * global._light_quality, c_black, 1)

                                    // Draw the outline of the shadow.
                                    // If you don't plan on your lights going "behind" the casters, commenting this loop out is a small optomiztation.
                                    for(var k = 0; k < array_length_1d(_light_points_x); k++) {                                       
                                        draw_vertex_colour((points_cast_x[k] - (other.x - global._light_half_size)) * global._light_quality, (points_cast_y[k] - (other.y - global._light_half_size)) * global._light_quality, c_black, 1)
                                        draw_vertex_colour((points_cast_x[0] - (other.x - global._light_half_size)) * global._light_quality, (points_cast_y[0] - (other.y - global._light_half_size)) * global._light_quality, c_black, 1)
                                    }                                      

                                    draw_primitive_end()
                                }
                            }
                        }
                    }
                    surface_reset_target()
    
                    surface_set_target(global._light_map)
                    draw_set_alpha(1)
                    draw_set_color(c_white)
                    draw_set_blend_mode(bm_add)
                    if surface_exists(global._light_surface)
                        draw_surface(global._light_surface, (x - global._light_half_size - argument0) * global._light_quality, (y - global._light_half_size - argument1) * global._light_quality)
                    draw_set_blend_mode(bm_normal)
                    surface_reset_target()
                }
            }
        }
    }
}

if !argument2
    draw_set_blend_mode_ext(bm_dest_color, bm_zero)
else
    draw_set_blend_mode_ext(bm_dest_color, bm_src_color)

if surface_exists(global._light_map)
{
    if argument4 <= 0
       draw_surface_ext(global._light_map, argument0, argument1, 1 / global._light_quality, 1 / global._light_quality, 0, c_white, 1)
    else
        draw_surface_blurred(global._light_map, argument0, argument1, 1 / global._light_quality, 1 / global._light_quality, argument4)
}
draw_set_blend_mode(bm_normal)
