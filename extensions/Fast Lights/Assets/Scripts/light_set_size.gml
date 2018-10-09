///light_set_size(size)
/*
Sets the maximum size of all lights and resizes the lighting surface after it has already been initalized.
size: Size of the square surface in pixels.
*/

global._light_size = argument0
global._light_half_size = global._light_size / 2
surface_resize(global._light_surface, global._light_size * global._light_quality, global._light_size * global._light_quality)
