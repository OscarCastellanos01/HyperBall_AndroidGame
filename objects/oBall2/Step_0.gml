if (place_meeting(x,y+4,oCircleD) && vspeed >0){
	vspeed = menosVel;
	
	//Aumento velocidad
	menosVel -= 1.5;
	instance_change(choose(oBall,oBall2),false);
	
	//Dar un punto
	points += 1;

	//Sonido
	audio_play_sound(snScore,4,false);
	
}else if (place_meeting(x,y-4,oCircleUp) && vspeed <0){
	vspeed = masVel;
	
	//Aumento velocidad
	masVel += 1.5;
	instance_change(choose(oBall,oBall2),false);
	
	//Dar un punto
	points += 1;

	//Sonido
	audio_play_sound(snScore,4,false);
}

if (menosVel <= -10){
	menosVel = -10;
}

if (masVel >= 10){
	masVel = 10;
}

//GAME OVER
if (place_meeting(x,y+4,oCircleD2) && vspeed >0){
	instance_destroy();
	particle_play(100,10,12,make_color_rgb(255,222,0),5,-100,x+32,y+32);

	//Sonido
	audio_play_sound(snDeath,4,false);
	
}else if (place_meeting(x,y-4,oCircle2Up) && vspeed <0){
	instance_destroy();

	particle_play(100,10,12,make_color_rgb(255,222,0),5,-100,x+32,y+32);
	
	//Sonido
	audio_play_sound(snDeath,4,false);
}