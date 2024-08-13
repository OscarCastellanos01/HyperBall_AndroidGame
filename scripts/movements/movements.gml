///@param right
///@param left
///@param block
function movements(argument0, argument1, argument2) {

	var right, left, block;

	right = argument0;
	left  = argument1;
	block = argument2;

	if (place_meeting(x-16,y,block)){
		hspeed = 0;
	}else if (place_meeting(x+16,y,block)){
		hspeed = 0;
	}

	if (instance_exists(oBall) || instance_exists(oBall2)){
		if (mouse_check_button_pressed(mb_left) && bloqueo = false){
			bloqueo = true;
			hspeed = left
		}else if (mouse_check_button_pressed(mb_left) && bloqueo = true){
			bloqueo = false;
			hspeed = right
		}
	}



}
