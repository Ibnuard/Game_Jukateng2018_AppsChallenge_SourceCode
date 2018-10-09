///light_init(width, height, light_size, ambient_color, quality, iterations)
/*
Sets up lighting variables.
width: Width of the shadow map.
height: Height of the shadow map.
light_size: The size of the lightmaps, should be set to the largest light.
color: The shadow color, this also controls the darkness of the shadows.
quality: The lightmap quality, 0 to 1.
iterations: How many times a second to draw the lightmap. The default is the room speed
            but you might want to reduce this for increased performance. If it is too
            small, however, you will notice considerable stuttering.
*/

global._light_width = argument0
global._light_height = argument1
global._light_size = argument2
global._light_half_size = global._light_size / 2
global._light_color = argument3
global._light_quality = argument4
if argument5 < 0
    global._light_max_time = 0
else
    global._light_max_time = 1000000/ argument5
global._light_time = 0
global._light_surface = surface_create(global._light_size * global._light_quality, global._light_size * global._light_quality)
global._light_map = surface_create(global._light_width * global._light_quality, global._light_height * global._light_quality)
global._lights = ds_list_create()
global._light_casters = ds_list_create()
