/// @description Draw the signpost
	//Dont animate the shadows
	image_speed = 0;
	image_index = 0;
	
	//Draw main
	draw_sprite(sprite_index, image_index, floor(x), floor(y))
	
	//Draw front
	draw_sprite_ext(spr_signpost_background_black, 0, floor(x), floor(y) - 31, 1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_signpost_char, global.character, floor(x), floor(y) - 31, 1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_signpost_static, min((global.object_timer / 4) mod 30, 7), floor(x), floor(y) - 31, 1, 1, 0, c_white, 1);