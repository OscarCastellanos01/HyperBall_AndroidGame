///@param duracion
///@param velocidad
///@param cantidad
///@param color
///@param tamano
///@param profundidad
///@param x
///@param y

dire_anim_part = 360 / argument2;

repeat(argument2){
	part_cont_act = instance_create_layer(argument6,argument7,"Instances",oParticles);
    part_cont_act.limit = argument0;
    part_cont_act.speed = argument1;
    part_cont_act.co = argument3;
    part_cont_act.image_xscale = argument4;
    part_cont_act.image_yscale = argument4;
    part_cont_act.depth = argument5;
    part_cont_act.direction = dire_anim_part;
    dire_anim_part += 360 / argument2;
}