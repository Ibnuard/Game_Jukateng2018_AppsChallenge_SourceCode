///light_create_caster_from_points(points_x, points_y)
/*
Creates a caster from two lists of points.
points_x: ds_list of relative x positions.
points_y: ds_list of relative y positions.
Notice: An instance can only have one caster attached to it.
*/

for (var i = 0; i < ds_list_size(argument0); i++) {
    _light_points_x[i] = ds_list_find_value(argument0, i)
    _light_points_y[i] = ds_list_find_value(argument1, i)
}
ds_list_destroy(argument0)
ds_list_destroy(argument1)

ds_list_add(global._light_casters, id)
