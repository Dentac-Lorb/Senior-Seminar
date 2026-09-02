shader_type canvas_item;

uniform sampler2D refractionTexture: repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 samp1 = texture(refractionTexture, FRAGCOORD.xy / 2000.0 + vec2(TIME, TIME) / 20.0);
	vec4 samp2 = texture(refractionTexture, FRAGCOORD.yx / 2000.0 + vec2(TIME, -TIME) / 40.0);
	COLOR.a = 0.5 - (samp1.r + samp2.r) / 4.0;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
