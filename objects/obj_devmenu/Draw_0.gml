/// @description Draw dev menu
	
	//Get the screen position
	var c = view_camera[view_current];
	var cx = camera_get_view_x(c);
	var cy = camera_get_view_y(c);
	
	//Create surface if it doesn't exist
	if(!surface_exists(surface))
	{
		surface = surface_create(WINDOW_WIDTH, WINDOW_HEIGHT);
	}
	
	//Set the target surface
	surface_set_target(surface)
	
	//Screen center values
	var center_x = WINDOW_WIDTH / 2;
	var center_y = WINDOW_HEIGHT / 2;
	
	//Change the font
	draw_set_font(global.font_debug);
	
	//Clear the surface
	draw_clear_alpha(c_black, 0);
	
	//Draw rectangle for the background
	draw_set_color(bg_color);
	draw_rectangle(center_x - 128, center_y - 32 - 52, center_x + 128, center_y - 32 - 52 + 47, false);
	draw_rectangle(center_x - 128, center_y - 32, center_x + 128, center_y + 39, false);
	draw_set_color(text_color);
	
	//Change text alingment to the center
	draw_set_halign(fa_center);
	
	//Draw the game header
	draw_text(center_x, center_y - 32 - 52 + 4, "HARMONY FRAMEWORK v0.9 Dev");
	draw_text(center_x, center_y - 32 - 52 + 12, "DEV MENU"); 
	draw_set_color(unselected_text_color);
	draw_text(center_x, center_y - 32 - 52 + 28, window_get_caption() + " (" + GM_version + ")");
	draw_text(center_x, center_y - 32 - 52 + 36, os_get_string() + " - Runtime: " + GM_runtime_version /*+ " | Build Time: " + date_time_string(GM_build_date)*/);
	draw_set_color(text_color);
	
	//Draw dev menu's text
	switch(state)
	{
		//Draw normal menu selections
		case dev_menu_state.normal:
			for (var i = 0; i < array_length(menu_list); ++i) 
			{
				draw_set_color(menu_select == i ? text_color : unselected_text_color);
				draw_text(center_x, center_y - 32 + 8 + (12 * i), menu_list[i]);
			}
		break;
		
		//Draw the character select
		case dev_menu_state.character_select:
			draw_set_halign(fa_center);
			for (var i = character_select_offset; i < min(character_id, 7) + character_select_offset; ++i) 
			{
				draw_set_color(character_select == i ? text_color : unselected_text_color);
				draw_text(center_x, center_y - 32 + 4 + (8 * (i - character_select_offset)), char_name[i]);
			}
		break;
		
		//Draw category select
		case dev_menu_state.category_select:
			draw_set_halign(fa_left);
			for (var i = category_offset; i < min(category_id, 7) + category_offset; ++i) 
			{
				draw_set_color(category_select == i ? text_color : unselected_text_color);
				draw_text(center_x - 128 + 64, center_y - 32 + 4 + (8 * (i - category_offset)), category_name[i]); 
			}
		break;
		
		//Stage stage select
		case dev_menu_state.stage_select:
			draw_set_halign(fa_left);
			for (var i = scene_offset; i < min(array_length(scene_name[category_select + 1]), 8) + scene_offset; ++i) 
			{
				draw_set_color(scene_select == i ? text_color : unselected_text_color);
				draw_text(center_x - 128 + 64, center_y - 32 + 4 + (8 * (i - scene_offset)), scene_name[category_select + 1][i]);
			}
		break;
		
		//Draw options
		case dev_menu_state.options:
			for (var i = option_offset; i < min(option_id, 8) + option_offset; ++i) 
			{
				//Draw the name of the option
				draw_set_color(option_select == i ? text_color : unselected_text_color);
				draw_set_halign(fa_left);
				draw_text(center_x - 128 + 32, center_y - 32 + 4 + (8 * (i - option_offset)), option_name[i]);
				
				//Draw the number of the option
				draw_set_color(highlight_color);
				draw_set_halign(fa_right);
				var number = variable_instance_get(global, option_variable[i]);
				var flag = number == 1 ? "Y" : "N";
				draw_text(center_x + 128 - 32, center_y - 32 + 4 + (8 * (i - option_offset)), option_flag[i] ? flag : string(number));
				draw_set_color(text_color);
			}
		break;
	}
	
	//Reset the color and text alingment
	draw_set_color(c_white);
	draw_set_halign(fa_left)

	//Reset the surface target
	surface_reset_target()
	
	//Draw the dev menu
	draw_surface(surface, cx, cy);	