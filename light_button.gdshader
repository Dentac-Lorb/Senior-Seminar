shader_type canvas_item;

uniform vec2 center;
uniform vec4 color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float dist = distance(FRAGCOORD.xy, center);
	float glow = 1.0 - max(0.0, dist * dist / 256.0);
	COLOR = vec4(color.rgb, color.a * glow);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
