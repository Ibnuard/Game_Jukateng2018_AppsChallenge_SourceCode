///light_destroy()
/*
Must be called when a light is destroyed.
*/

var index = ds_list_find_index(global._lights, id)
ds_list_delete(global._lights, index)
