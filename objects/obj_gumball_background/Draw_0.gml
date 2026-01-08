/// @description Draw background

draw_background_layer(0);
palette_swap(spr_pal_gumball_background_0, abs(2*dsin(FRAME_TIMER)));
draw_background_layer(1);
shader_reset();
palette_swap(spr_pal_gumball_background_1, abs(6*dsin(FRAME_TIMER)));
draw_background_layer(2);
shader_reset();