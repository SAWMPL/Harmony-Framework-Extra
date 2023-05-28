function player_handle_hurt(){

	//Basic knockout
	if(invincible_timer = 0 && state != ST_KNOCKOUT && knockout_type = K_HURT)
	{
		//Commit death
		if(global.rings = 0 && shield = S_NONE)
		{
			knockout_type = K_DIE;	
		}
		
		//Ring loss
		if(global.rings != 0 || shield != S_NONE)
		{
			x_speed = (-2 * facing) / (1 + underwater);
			y_speed = -4 / (1 + underwater);
			ground = false;
			invincible_timer = 120;
			state = ST_KNOCKOUT;
		}
		
		//Ring loss
		if(global.rings != 0 && shield = S_NONE)
		{
			create_ringloss(global.rings);	
			global.rings = 0;
		}
		
		//Shield loss
		if(shield != S_NONE)
		{
			shield = S_NONE;
		}
	}
	
	//Death events
	if(state != ST_KNOCKOUT && knockout_type = K_DIE)
	{
		state = ST_KNOCKOUT;
		y_speed = -7;
		x_speed = 0;
		ground = false;
		obj_camera.mode = 99;
	}
	if(invincible_timer != 0 && knockout_type != 0 && state != ST_KNOCKOUT) knockout_type = 0;
}