function play_sound(sound, loop = false){
	//Stop the audio before playing so it doesn't overlay
	audio_stop_sound(sound);
	
	//Play the sound
	audio_play_sound(sound, 0, loop);
	
	//Change the volume to match the global volume
	audio_sound_gain(sound, global.sfx_volume, -1);
}

function play_sound_extra_life()
{
	if(global.extra_life_jingle) play_sound(j_extra_life) else play_sound(sfx_extralife)
}