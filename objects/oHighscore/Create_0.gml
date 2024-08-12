newHighscore = false;

if (points>global.highscore){	
	newHighscore = true;
	
	//Guardar highscore
	ini_open("puntuacion.ini");
	ini_write_real("puntos","highscore",points);
	global.highscore = ini_read_real("puntos","highscore",0); //para que aparezca el highscore
	ini_close();
}