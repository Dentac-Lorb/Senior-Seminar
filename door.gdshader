shader_type canvas_item;


uniform float door_size;
uniform vec2 offset;
uniform vec2 angle;
uniform mat2 rotation;
uniform vec2 fulcrum1;
uniform vec2 fulcrum2;
uniform float openness;
uniform mat2 open_top; 
uniform mat2 open_bottom;



void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 relative_coord = FRAGCOORD.xy - offset;
	vec2 rot_coord = relative_coord * rotation;
	mat2 open_mat;
	float ogy = rot_coord.y;
	bool oob = false;
	//if (abs(ogy) <= door_size){
	if (ogy > 0.0){
		open_mat = open_top;
		rot_coord.y -= door_size;
	} else {
		open_mat = open_bottom;
		rot_coord.y += door_size;
	}
	//} else oob = true;
	//if (!oob){
	vec2 final_coord = rot_coord * open_mat;
	float len_bounds;
	if (ogy>0.0){
		len_bounds = min(-final_coord.y, final_coord.y + door_size );
	} else {
		len_bounds = min(final_coord.y, -final_coord.y + door_size);
	}
	COLOR.a = max(
		//0.3,
		0.0,
		min(smoothstep(-6, -4, -abs(final_coord.x)), smoothstep(-2, 0, len_bounds)));
	//} else if (abs(rot_coord.x) > 5.0){
		//COLOR.a = 0.5;
	//}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
