angle = (angle+rot_speed) mod 360;

if(attacking == (angle >= 90 && angle <= 270))
{
	if(on_screen())play_sound(sfx_flail_swing);
	attacking = !attacking;
}

if(attacking && obj_player.state != player_state_knockout && !obj_player.debug) 
{
	var _x = x + (((chain_length-1)*chain_width)*dsin(angle))
	if(check_region(-24, -24, 24, 24, _x, y-26))
	{
		player_hurt(_x);
		play_sound(sfx_spike);
	}
}
