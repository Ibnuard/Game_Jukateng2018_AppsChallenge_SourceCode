///light_destroy_caster()
/*
Destroys a caster
*/

var index = ds_list_find_index(global._light_casters, id)
ds_list_delete(global._light_casters, index)
