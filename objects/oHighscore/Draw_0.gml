draw_set_font(fnt);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_color(make_color_rgb(255,222,0));

draw_text(x+360,y+640,points);
	
if (newHighscore == true){
	draw_set_font(fntScore);
	draw_set_color(make_color_rgb(255,255,244));
	
	draw_text(x+360,y+768,"NEW BEST!");
}else{
	newHighscore = false;
	draw_set_font(fntScore);
	draw_set_color(make_color_rgb(255,255,244));
	
	draw_text(x+360,y+768,"BEST "+string(global.highscore));
}