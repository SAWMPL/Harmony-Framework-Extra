/// @param {real}  x_left     The x (object x + x_left) coordinate of the left side of the rectangle to check.
/// @param {real}  y_top      The y (object y + y_top) coordinate of the top side of the rectangle to check.
/// @param {real}  x_right    The x (object x + x_right) coordinate of the right side of the rectangle to check.
/// @param {real}  y_bottom   The y (object y + y_bottom) coordinate of the bottom side of the rectangle to check.
/// @param {real}  _x         The x (_x = x by default) position of the x center of the rectangle to check.
/// @param {real}  _y	      The y (_y = y by default) position of the y center of the rectangle to check.
/// @description              Function check_region() uses six arguments (x_left,y_top,x_right,y_bottom,_x,_y,) to define area within the current room and then checks to see if the player is in collision with that area.

function check_region(x_left,y_top,x_right,y_bottom,_x = x,_y = y)
{
	if(collision_rectangle(_x + x_left, _y + y_top, _x + x_right, _y + y_bottom, obj_player, true, true))
	{
		return true;
	}
    
    return false;
}