/// @description Update Pause Menu
    //Temporary variable
    var y_input = Input.DownPress - Input.UpPress;
    
    //Don't process the objects right now
	global.process_objects = false;
    
    //Timer
    timer++;
    
    //Wrap the select var
    instance_activate_object(obj_fade);
    
    //Change the select var by your inputs
    pause_select += y_input;    
    pause_select %= 3;
    
    //Do stuff based on pause_select
    if(Input.StartPress && timer > 2) {
        switch(pause_select) {
            case 0: 
                play_sound(sfx_checkpoint); 
                global.process_objects = true; 
                audio_resume_all(); 
                instance_destroy();
            break;
            
            case 1:
                if(global.life > 1) {
                    global.process_objects = true;
                    instance_activate_all(); 
                    surface_free(pause_menu); 
                    pause_menu = -1; 
                    reset_stage_data(); 
                    global.life -= 1; 
                    room_togo = room;
                    instance_destroy();
                }
                else play_sound(sfx_hurt);
            break;
            
            case 2:
                global.process_objects = true;
                instance_activate_all(); 
                surface_free(pause_menu); 
                pause_menu = -1; 
                reset_stage_data(); 
                room_togo = rm_stage_select;
                instance_destroy();
        }
    }