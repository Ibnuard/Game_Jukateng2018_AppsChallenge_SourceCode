///light_create_caster_from_path(path, xorigin, yorigin, xoffset, yoffset)
/*
Creates a caster using a path, if -1 is passed the bounding box of the sprite will be used.
path: The path to use.
xorigin: The relative x point on the sprite where the first point on the path goes.
yorigin: The relative y point on the sprite where the first point on the path goes.
xoffset: The sprite's xoffset, allows you to use a different sprite offset.
yoffset: The sprite's yoffset.
Notice: An instance can only have one caster attached to it.
*/

var n, startx, starty, centerx, centery

n = path_get_number(argument0)
startx = path_get_point_x(argument0, 0)
starty = path_get_point_y(argument0, 0)
centerx = argument3
centery = argument4

if path_exists(argument0) {
    for (var i = 0; i < n; i++) {
        _light_points_x[i] = path_get_point_x(argument0, i) - startx - centerx + argument1
        _light_points_y[i] = path_get_point_y(argument0, i) - starty - centery + argument2
    }
}

ds_list_add(global._light_casters, id)
