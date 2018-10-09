///light_draw_sprite_dark()
/*
Draws the sprite in darkness.
Useful for objects that should be in shadow.
Use global._light_dark_color to do this manually.
*/

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, global._light_color, image_alpha)
