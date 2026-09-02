shader_type canvas_item;

uniform sampler2D sandTexture: repeat_enable;
uniform vec4 tint: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 samp1 = texture(sandTexture, FRAGCOORD.xy / 200.0);
	COLOR = samp1 * tint;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
