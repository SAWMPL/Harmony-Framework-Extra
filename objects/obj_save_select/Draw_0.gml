var wx = WINDOW_WIDTH;
var wy = WINDOW_HEIGHT;
var wcx = wx/2;
var wcy = wy/2;

draw_sprite(spr_save_bg_save, 0, wcx, wcy+4);

var color = [c_white, c_black];

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

if(menu_screen == 1)
{
	for (var j = 1; j >= 0; j--)
	{
		//Set depth sorting (this shit is so fucking bloated I'm kms...)
		var _depth = gpu_get_depth()
		if(!j)
		{
			alpha_dither(0.5);
			gpu_set_ztestenable(1)
			gpu_set_alphatestenable(1)
			gpu_set_zwriteenable(1)
		}
		//Characters
		for (var i = 0; i < 3; i++)
		{
			var _color = c_white
			
			//Set depth sorting (this shit is so fucking bloated I'm kms...)
			var _depth = gpu_get_depth()
			if(!j)
			{
				gpu_set_depth(_depth-40*dcos(-char_offset+120*i));
			}
			
			if(selected_char == i && (round(char_offset) >= (selected_char*120-10) && round(wrap(char_offset+5, 0,360)) <= (selected_char*120+10)))
				_color = color[j];
			else
				_color = merge_color(color[j], c_black, 0.5);
				
			
			var size = (0.7+0.3*dcos(-char_offset+120*i))*state_offset*(menu_state == 2 ? 0 : 1);
			var angle = -char_offset+120*i + 360*(1-state_offset)
			var _x = wcx + (40*state_offset)*dsin(angle) + 5*j*state_offset;
			var _y = wcy + (8*state_offset)*dcos(angle)-12 + 5*j*state_offset;
			
			draw_sprite_ext(character_sprite[i][0], character_sprite[i][1], _x, _y, size, size, 0, _color, 1);
		}

		//Reset depth sorting
		gpu_set_depth(_depth)
		gpu_set_ztestenable(0)
		gpu_set_zwriteenable(0)
		gpu_set_alphatestenable(0)

		draw_set_colour(color[j])
		//Names
		var names = ["SONIC", "TAILS ", "KNUCKLES"];
		draw_set_font(global.text_font);
		draw_set_halign(fa_center);
		draw_text(wcx+(wx*2*(1-state_offset)), wcy+24, names[selected_char]);
		shader_reset();
	}
}

if(menu_screen == 2)
{
    var levels_amount = 0;
    for (var i = 0; i < array_length(level_list); i++)
    {
    	levels_amount = array_length(level_list[i])-2;
    }
    
    for (var i = 0; i <= levels_amount; i++)
    {
        var px = wcx-(48*i);
        var py = wcy+(112*i);
        draw_sprite(spr_save_level_select, 0, px, py);
        draw_sprite(spr_save_zone_card, 0, px-22, py+10);
        
        draw_set_font(font_save_data); 
        draw_set_halign(fa_center);
        draw_text(px+86, py+6, "2");
    }
}



draw_set_colour(c_white);

//Saves
for (var j = -1; j < saves_amount; j++) 
{
	var px = wcx+48*j-selected_save_offset[0]-wx*2*state_offset;
	var py = wcy+112*j-selected_save_offset[1];
	
	for (var i = 1; i >= 0; i--)
	{
		var _color = c_white
		
		if(selected_save == j && (round(selected_save_offset[0]) >= selected_save*48-10 && round(selected_save_offset[0]) <= selected_save*48+10))
			_color = color[i]
		else
			_color = merge_color(color[i], c_black, 0.5);
			
		if(i) alpha_dither(0.5);
		draw_save(j, px+5*i, py+5*i, _color, i);
		shader_reset();
	}
}

draw_sprite(spr_save_confirm, 0, wcx-wx*(deletion_off), wcy);
draw_sprite(spr_save_confirm_dot, 0, wcx-wx*(deletion_off)-16, wcy+8*deletion_confirm);

draw_sprite(spr_save_select_title, menu_screen >= 1 ? 1 : 0, wx*(1-state_offset), 0);
draw_sprite(spr_save_play_del, menu_screen == 0 ? save_mode : 1+menu_screen, (wx-96*2)*state_offset + 96, wy-28);


var off = state_offset * ((menu_screen == 1) ? 1 : 0);

draw_sprite(spr_save_arrow_ver, 0, 32, wcy-wy*3*(off));
draw_sprite(spr_save_arrow_ver, 0, wx-32, wcy+wy*3*(off));

draw_sprite(spr_save_arrow_hor, 0, wx-128 +wx*3*(1-off), 32);
draw_sprite(spr_save_arrow_hor, 0, 128-wx*3*(1-off), wy-32);

