gml_pragma("global","init()");

var _p = part_type_create();

part_type_shape(_p, pt_shape_square);
part_type_life(_p,20,40);

part_type_alpha2(_p,1,0);
part_type_color2(_p,c_white,c_white);
part_type_size(_p,0.1,0.2,0.025,0);

part_type_speed(_p,2,4,0,0);
part_type_direction(_p,0,360,0,0);
global.ptBasic = _p;