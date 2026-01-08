fade_in_room(5);
play_music(MUSIC.SAVE_SELECT);




font_save_text = font_add_sprite_ext(spr_save_font, "0123456789:", false, 2);
font_save_data = font_add_sprite_ext(spr_save_data_title_font, "123456789", false, 0);
font_save_zone = font_add_sprite_ext(spr_save_zone_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 1);

character_sprite = [[spr_sonic_victory,2],[spr_tails_victory, 1],[spr_knuckles_victory, 1]];

draw_save = function(save_slot, px, py, color, flag = false)
{
	draw_set_color(color);
	
	draw_sprite_ext(spr_save_border, 0, px, py, 1,1, 0, color, 1);
	
	if(save_slot == -1)
	{
		draw_sprite_ext(spr_save_data_title, 0, px-32, py-48, 1,1, 0, color, 1);
		draw_sprite_ext(spr_save_new, 0, px, py, 1,1, 0, color, 1);
		
		draw_set_font(font_save_text);
		draw_set_halign(fa_center);
		draw_text(px+4,py+40,"0:00:00");
	}
	else
	{
		if(save[save_slot].new_save == true)
		{
			draw_sprite_ext(spr_save_data_title, 1, px-32, py-48, 1,1, 0, color, 1);
			draw_set_font(font_save_data);
			draw_set_halign(fa_center);
			draw_text(px+28, py-48,save_slot+1);
			
			draw_sprite_ext(spr_save_new, 0, px, py, 1,1, 0, color, 1);
			
			draw_set_font(font_save_text);
			draw_set_halign(fa_center);
			draw_text(px+4,py+40, "0:00:00");
		}
		else
		{
			draw_sprite_ext(spr_save_data_title, 1, px-32, py-48, 1,1, 0, color, 1);
			draw_set_font(font_save_data);
			draw_set_halign(fa_center);
			draw_text(px+28, py-48,save_slot+1);
			
			draw_sprite_ext(spr_save_zone_card, save[save_slot].finished ? sprite_get_number(spr_save_zone_card)-1 : level_list[save[save_slot].level[0]][3], px+94, py+20, 1,1, 0, color, 1);
			draw_set_font(font_save_zone);
			draw_set_halign(fa_right);
			draw_text(px+98, py+26,save[save_slot].finished ? "CLEARED" : level_list[save[save_slot].level[0]][2]);
			
			draw_sprite_ext(character_sprite[save[save_slot].character][0], character_sprite[save[save_slot].character][1], px-76, py, 1,1, 0, color, 1);
			
			draw_sprite_ext(spr_save_life_icons, save[save_slot].character, px-50, py-16, 1,1, 0, color, 1);
			draw_sprite_ext(spr_save_coninue_icons, save[save_slot].character, px-50, py-1, 1,1, 0, color, 1);
			
			draw_set_font(font_save_text);
			draw_set_halign(fa_center);
			if(!flag)palette_swap(spr_save_font_palette, 1);
			draw_text(px-15, py-7,(save[save_slot].lifes > 9 ? "" : "0")+string(save[save_slot].lifes));
			draw_text(px-15, py+17,(save[save_slot].continues > 9 ? "" : "0")+string(save[save_slot].continues));
			if(!flag)shader_reset();
			
			
			//Time
			var minute, sec, milsec;
			milsec = floor(save[save_slot].total_time/10) mod 100;
			sec = floor(save[save_slot].total_time/1000) mod 60;
			minute = floor(save[save_slot].total_time/60000);
			
			draw_text(px+4,py+40, string(minute)+":"+(sec > 9 ? "" : "0") + string(sec)+":"+(milsec > 9 ? "" : "0") + string(milsec));
		}
	}
	draw_set_color(c_white);
}

selected_save = -1;
selected_save_offset = [-48,-112];
saves_amount = 5
save_mode = 0;
menu_state = 0;
menu_screen = 0;
state_offset = 0;
selected_char = 0;
char_offset = 0;
deleting_save = false;
deletion_confirm = false;
deletion_off = 1;


for (var i = 0; i < saves_amount; i++)
{
	save[i] = {
		new_save: true,
		character: CHAR_SONIC,
		lifes: 3,
		continues: 0,
		level: [0,0],
		total_time: 0,
		total_score: 0,
		finished: false
	}
}
save[0].new_save = false;
save[1].new_save = false;
save[2].new_save = false;
save[1].character = 1;
save[2].character = 2;
save[2].finished = true;

level_list = [[rm_arboreal_agate1, rm_arboreal_agate2, "ARBOREAL AGATE", 0]];

apply_data = function()
{
	global.character = save[selected_save].character;
	global.life = save[selected_save].lifes;
	global.score = save[selected_save].total_score;
	var lvl = save[selected_save].level;
	fade_to_room(level_list[lvl[0], lvl[1]], 5);
}

wipe_data = function()
{
	save[selected_save].new_save = true;
	save[selected_save].character = CHAR_SONIC;
	save[selected_save].level = 3;
	save[selected_save].continues = 0;
	save[selected_save].level = [0,0];
	save[selected_save].total_time = 0;
	save[selected_save].total_score = 0;
	save[selected_save].finished = false;
}