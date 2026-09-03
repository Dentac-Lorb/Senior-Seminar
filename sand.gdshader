shader_type canvas_item;

uniform sampler2D sandTexture: repeat_enable;
uniform sampler2D noiseTexture: repeat_enable;
uniform vec4 tint: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 noiseSamp1 = texture(noiseTexture, FRAGCOORD.xy / 500.0);
	vec4 noiseSamp2 = texture(noiseTexture, FRAGCOORD.yx / 500.0);
	vec2 distortion = vec2(noiseSamp1.r - .5, noiseSamp2.r - .5) * 1.0;
	vec4 samp1 = texture(sandTexture, (FRAGCOORD.xy / 400.0) + distortion);
	COLOR = samp1 * tint;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
