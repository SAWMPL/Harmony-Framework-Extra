var draw_flail = function(max_i, i)
{
	var scale = max(min(1-(0.5 - ((chain_width*i*dcos(angle)/(chain_width*max_i)))), 1.5), 0)/4;
	var color_ind = max(min(1-(0.5 - ((chain_width*i*dcos(angle+180)/(chain_width*max_i)))), 1), 0)/2;
	var color = merge_colour(c_white, c_black, color_ind);
	
	
	if(i < chain_length-2)
		draw_sprite_ext(spr_flail_chain, 0, x+chain_width*i*dsin(angle), y-26, 1+scale, 1+scale, 0, color, 1);
	else if(i == chain_length-1)
		draw_sprite_ext(spr_flail_spikeball, 0, x+chain_width*i*dsin(angle), y-26, 1+scale, 1+scale, 0, color, 1);
}


//Set depth sorting (this shit is so fucking bloated I'm kms...) 
var _depth = gpu_get_depth();
gpu_set_ztestenable(1);
gpu_set_alphatestenable(1);
gpu_set_zwriteenable(1);

gpu_set_depth(0)
draw_sprite(spr_flail_pole, 0, xstart, ystart);

for(var j = 1; j < chain_length; j++)
{
	gpu_set_depth(j*-dcos(angle))
	draw_flail(chain_length, j);
}

gpu_set_depth(_depth);
gpu_set_ztestenable(0);
gpu_set_zwriteenable(0);
gpu_set_alphatestenable(0);