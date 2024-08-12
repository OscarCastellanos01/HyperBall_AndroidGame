if (mouse_check_button_pressed(mb_left)){
	instance_destroy();
	
	//Score
	instance_create_layer(oControl.x,oControl.y,"Instances",oScore);
	
	//Crear los objetos despues de tocar la pantalla
	
	//crear la bola en movimiento.
	randomize();
	cambio = choose(oBall2,oBall);
	instance_create_layer(oControl.x+320,oControl.y+704,"Instances",cambio);
	
	//Crea el jugador.
	
	//Up
	instance_create_layer(oScore.x+128,oScore.y+448,"Instances",oCircleUp);
	instance_create_layer(oScore.x+320,oScore.y+448, "Instances",oCircle2Up);
	
	//Down
	instance_create_layer(oScore.x+320,oScore.y+960,"Instances",oCircleD);
	instance_create_layer(oScore.x+512,oScore.y+960,"Instances",oCircleD2);
}