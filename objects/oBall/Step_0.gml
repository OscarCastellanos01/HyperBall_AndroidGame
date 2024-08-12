if (place_meeting(x,y+4,oCircleD2) && vspeed >0){
	vspeed = menosVel;	
	//Aumento velocidad
	menosVel -= 1.5;
	instance_change(choose(oBall2,oBall),false)
	
	//Dar un punto
	points += 1;
	
	//Sonido
	audio_play_sound(snScore,4,false);
	
}else if (place_meeting(x,y-4,oCircle2Up) && vspeed <0){
	vspeed = masVel;	
	//Aumento velocidad
	masVel += 1.5;
	instance_change(choose(oBall2,oBall),false);
	
	//Dar un punto
	points += 1;
	
	//Sonido
	audio_play_sound(snScore,4,false);
}

if (menosVel <= -10){ //BAJAR A 10
	menosVel = -10;
}else

if (masVel >= 10){
	masVel = 10;
}


//GAME OVER
if (place_meeting(x,y+4,oCircleD) && vspeed >0){	
	instance_destroy();
	
	particle_play(100,10,12,c_white,5,-100,x+32,y+32);

	//Sonido
	audio_play_sound(snDeath,4,false);
	
	
}else if (place_meeting(x,y-4,oCircleUp) && vspeed <0){
	instance_destroy();

	particle_play (100,10,12,c_white,5,-100,x+32,y+32);

	//Sonido
	audio_play_sound(snDeath,4,false);
}