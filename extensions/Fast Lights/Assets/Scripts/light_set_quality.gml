///light_set_quality(quality)
/*
Sets the light quality after the lights have been initialized.
quality: The quality of the lighting surfaces, from 0 to 1.
*/

global._light_quality = argument0
surface_resize(global._light_map, view_wview * global._light_quality, view_hview * global._light_quality)
surface_resize(global._light_surface, global._light_size * global._light_quality, global._light_size * global._light_quality)
