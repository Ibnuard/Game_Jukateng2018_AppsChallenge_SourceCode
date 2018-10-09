///light_set_iterations(iterations)
/*
Set the number of times a second the lights and shadows should be drawn.
iterations: Number of times a second to draw lights and shaodws.
            Default is the room speed.
*/
if argument0 < 0
    global._light_max_time = 0
else
    global._light_max_time = 1000000/ argument0
