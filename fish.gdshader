shader_type canvas_item;

uniform vec2 pos1;
uniform vec2 pos2;
uniform vec2 pos3;
uniform float rad1 = 30.0;
uniform float rad2 = 25.0;
uniform float rad3 = 20.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	if(distance(FRAGCOORD.xy, pos1) < rad1
	|| distance(FRAGCOORD.xy, pos2) < rad2
	|| distance(FRAGCOORD.xy, pos3) < rad3){
		COLOR = vec4(1,1,1,1);
	} else {
		COLOR = vec4(0,0,0,0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
