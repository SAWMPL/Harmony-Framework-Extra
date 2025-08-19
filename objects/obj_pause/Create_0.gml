/// @description Create Pause Menu
    timer = 0;
	pause_select = 0;
	pause_menu = surface_create(global.window_width, global.window_height);
    room_togo = undefined;
    
	audio_pause_all();
	play_sound(sfx_skid);
	global.process_objects = false;