///light_create(light_sprite, light_scale, light_color, light_alpha, light_angle, shadows)
/*
Creates a light and the local variables for it.
sprite: Gradient sprite to use.
scale: Scale of the sprite.
color: The light color.
alpha: Brightness of the light, from 0 to 1.
shadows: If this light should draw shadows.
Notice: An instance can only have one light attached to it.
*/

_light_sprite = argument0
_light_scale = argument1
_light_color = argument2
_light_alpha = argument3
_light_angle = argument4
_light_shadows = argument5

_light_max_dist = max(sprite_get_width(_light_sprite),
                      sprite_get_height(_light_sprite)) * _light_scale

ds_list_add(global._lights, id)
