///draw_surface_blurred(surface, x, y, xscale, yscale, blur_amount)
/*
Draw a surface with a blur.
x: The x location to draw the surface.
y: The y location to draw the surface.
xscale: The x scale of the surface.
yscale: The y scale of the surface.
blur_amount: How blurry the surfacr should be, numbers from 0 to 1 work well 
             but even higher number can be used for increased blur.
*/

var blur = shader_get_uniform(shd_blur, "blur")
shader_set(shd_blur)
shader_set_uniform_f(blur, argument5)
draw_surface_ext(argument0, argument1, argument2, argument3, argument4, 0, c_white, 1)
shader_reset()
