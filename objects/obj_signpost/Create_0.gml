/// @description Values
	angle = 0;
	spin_speed = 0;
	triggered = false;
	ground = true;
	x_speed = 0;
	y_speed = 0;
	state = 0; //ENUM: 0 = Trigger by collision or flying over it. 1 = Falling signpost
	
	/// Thanks for a kind redditor u/AmnesiA_sc
	var targetFPS = 4; // Intended frames per second
	JetSprite = spr_signpost_background;
	JetImageSpeed = targetFPS / 48;
	JetImageNumber = sprite_get_number( JetSprite);
	JetImageIndex = 0;

