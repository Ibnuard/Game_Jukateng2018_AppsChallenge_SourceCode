///light_set_size(size)
/*
This will scale the light sprite.
Notice that this will not change the size of the surface the light is drawn on, only the sprite itself.
size: Scale of the light sprite.
*/

_light_scale = argument0
_light_max_dist = max(sprite_get_width(_light_sprite),
                      sprite_get_height(_light_sprite)) * _light_scale
