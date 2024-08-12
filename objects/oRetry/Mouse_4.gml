//Guardar el contador de ads
ini_open("puntuacion.ini");
ini_write_real("puntos","anuncios",ads);
ini_close();	

game_restart();