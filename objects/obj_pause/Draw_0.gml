/// @description Draw Pause Menu
	var c, cx, cy, sw, sh;
	c = view_camera[view_current];
	cx = camera_get_view_x(c);
	cy = camera_get_view_y(c);
	sw = global.window_width;
	sh = global.window_height;
	
	//Draw Menu Surface
	if(!surface_exists(pause_menu)) pause_menu = surface_create(global.window_width, global.window_height);
	
	surface_set_target(pause_menu);
	draw_clear_alpha(c_black, 0);
	
	//Draw Pause Menu Options.
	draw_sprite(spr_pause_menu, pause_select, sw/2, sh/2);
	
	surface_reset_target();
	
	//Draw the Menu
	draw_surface(pause_menu, cx, cy);