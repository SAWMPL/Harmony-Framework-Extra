//Inputs
var input = (Input.DownPress - Input.UpPress);


if(menu_screen == 0 && !deleting_save)
{
	selected_save = clamp(selected_save+input, -1, saves_amount-1);
	if(input != 0) play_sound(sfx_beep);
	
	input = (Input.RightPress - Input.LeftPress);
	save_mode = (selected_save == -1 || save[abs(selected_save)].new_save == true) ? 0 : clamp(save_mode+input, 0, 1);
}
	
if(menu_screen == 1)
{	
	input = -(Input.LeftPress - Input.RightPress);
	selected_char = wrap(selected_char+input, 0, 2);
}

if(deleting_save)
{
	input = (Input.DownPress - Input.UpPress);
	deletion_confirm = wrap(deletion_confirm+input, 0, 1);
}


//Offsets easing
char_offset = lerp_angle(char_offset, selected_char*120, 0.1);

selected_save_offset[0] = lerp(selected_save_offset[0], selected_save*48, 0.15)
selected_save_offset[1] = lerp(selected_save_offset[1], selected_save*112, 0.15)

state_offset = lerp(state_offset, (menu_screen != 0) ? 1 : 0, 0.1);

deletion_off = lerp(deletion_off, !deleting_save, 0.1);



switch(menu_screen)
{
	case 0:
		if(Input.StartPress || Input.APress)
		{
			menu_state = 1;
			
			if(selected_save == -1 || save[abs(selected_save)].new_save = true) //Go to character select
			{
				menu_screen = 1
				play_sound(sfx_checkpoint);
			}
			else if(selected_save != -1 || save[abs(selected_save)].new_save = false)
			{
				if(save_mode == 0) // Play my game
				{
					if(save[selected_save].finished == false) //Go to last played level
					{
						apply_data();
					}
					else //Stage select
					{
						menu_screen = 2;
					}
				}
				else //Delete save
				{
					if(deletion_confirm == true)
					{
						wipe_data();
						deleting_save = false;
						deletion_confirm = false;
					}
					else
					{
						if(deleting_save == true)
						{
							deleting_save = false;
							deletion_confirm = false;
						}
						else
						{
							deleting_save = true;
						}
					}
					
				}
				play_sound(sfx_checkpoint);
			}
			
		}
	break;
	case 1: //Character Select
		if(Input.StartPress || Input.APress)
		{
			global.character = selected_char;
			fade_to_room(level_list[0][0], 5);
		}
		
		if(Input.BPress)
		{
			menu_screen = 0;
			menu_state = 0;
		}
	break;
	case 2: //Stage select
		if(Input.StartPress || Input.APress)
		{
			fade_to_room(level_list[0][0], 5);
		}
		if(Input.BPress)
		{
			menu_screen = 0;
			menu_state = 0;
		}
	break;
	
}