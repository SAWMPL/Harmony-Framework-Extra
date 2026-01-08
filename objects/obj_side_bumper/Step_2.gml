	if(player_collide_object(C_MAIN) && !triggered && obj_bonus_level.bumpers_cooldown < 0)
    {
        triggered = true;
        play_sound(sfx_spring);
        obj_bonus_level.bumpers_cooldown = 15;
        
        var player = instance_nearest(x,y,obj_player);
        with(player)
        {
            animation_play(animator, ANIM.SPRING);
            state = player_state_spring;
            y_speed = -6;
            x_speed = 3*sign(other.image_xscale);
            ground_speed = 3*sign(other.image_xscale);
            ground = false;
        }
    }

	if(triggered)
    {
		x -= 2*sign(image_xscale);
	}
	
	if abs(x - xstart) > 16
    {
		instance_destroy();
	}
	