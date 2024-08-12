if (file_exists("puntuacion.ini")){
	ini_open("puntuacion.ini");
	//points = ini_read_real("puntos","score",0);
	global.highscore = ini_read_real("puntos","highscore",0);
	ads = ini_read_real("puntos","anuncios",0);
	ini_close();
}else {
	points = 0;
	ads = 0;
	global.highscore = 0;
}