//Guardar puntos
ini_open("puntuacion.ini");
ini_write_real("puntos","highscore",global.highscore);
ini_write_real("puntos","anuncios",ads);
ini_close();