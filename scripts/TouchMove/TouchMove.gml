///@param right
///@param left
///@param bloque
function TouchMove(argument0, argument1, argument2) {

	var left, right, bloque;

	right = argument0;
	left  = argument1;
	bloque = argument2;

	if (!mouse_check_button(mb_left)) {
		is_dragging_x = false;
		return;	
	}
	
	if !is_dragging_x {
		dragging_start_x = window_mouse_get_x();
		is_dragging_x = true;
	
	} else {
		if room_width < dragging_start_x {
		return;
	    }
	
		window_mouse_x = window_mouse_get_x();
		var drag_distance;
	
		if window_mouse_x > dragging_start_x {
			drag_distance = window_mouse_x - dragging_start_x;
		} else {
			drag_distance = dragging_start_x - window_mouse_x;
		}
	
		if drag_distance < room_width / 20 {
			return;
		}
	
		if window_mouse_x > dragging_start_x {
			if (place_meeting(x+right,y,bloque)){
				right = 0;
			}
			hspeed = right;
		} else {
			if (place_meeting(x+left,y,bloque)){
				left = 0;
			}
			hspeed = left;
		}	
	}


}
