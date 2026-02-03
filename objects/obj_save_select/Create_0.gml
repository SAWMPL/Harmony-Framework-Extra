fade_in_room(5);
play_music(MUSIC.SAVE_SELECT);

font_save_text = font_add_sprite_ext(spr_save_font, "0123456789:", false, 2);
font_save_data = font_add_sprite_ext(spr_save_data_title_font, "123456789", false, 0);
font_save_zone = font_add_sprite_ext(spr_save_zone_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 1);

character_sprite = [[spr_sonic_victory,2],[spr_tails_victory, 1],[spr_knuckles_victory, 1]];



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

apply_savedata = function()
{
	global.character = save[selected_save].character;
	global.life = save[selected_save].lifes;
	global.continues = save[selected_save].continues;
	global.score = save[selected_save].total_score;
	var lvl = save[selected_save].level;
	fade_to_room(level_list[lvl[0], lvl[1]], 5);
};

save_savedata = function()
{
	save[selected_save].lifes      =  global.life;
	save[selected_save].continues  =  global.continues;
	save[selected_save].total_time =  global.stage_timer;
	save[selected_save].total_score = global.score;
	
	save[selected_save].level = global.score;
};

finish_savedata = function()
{
	save[selected_save].finished = true
};

empty_savedata = {
	new_save:    true,
	character:   CHAR_SONIC,
	lifes:       3,
	continues:   0,
	level:       [0,0],
	total_time:  0,
	total_score: 0,
	finished:    false
};