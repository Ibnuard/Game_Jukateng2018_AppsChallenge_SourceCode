///light_set_sprite(sprite)
/*
Sets the light to a new sprite.
If this sprite is larger than the sprite that the light was created with then it will be cut off.
If you need to change the size of a light you should destroy it and create a new one.
sprite: The sprite index to assign to this light.
*/

_light_sprite = argument0
_light_width = sprite_get_width(_light_sprite) * _light_scale
_light_height = sprite_get_height(_light_sprite) * _light_scale
_light_max_dist = max(_light_width, _light_height)
