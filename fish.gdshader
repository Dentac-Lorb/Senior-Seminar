shader_type canvas_item;

uniform vec2 pos1;
uniform vec2 pos2;
uniform vec2 pos3;
uniform float rad1 = 30.0;
uniform float rad2 = 25.0;
uniform float rad3 = 20.0;
uniform float smoothing = 50;

// Smoothing function from Sebastion Lague
// https://youtu.be/Cp5WWtMoeKg?t=189
float smoothMin(float dstA, float dstB, float k){
	float h = max(k-abs(dstA-dstB), 0) / k;
	return min(dstA, dstB) - h*h*h*k/6.0;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float dst1 = distance(FRAGCOORD.xy, pos1) - rad1;
	float dst2 = distance(FRAGCOORD.xy, pos2) - rad2;
	float dst3 = distance(FRAGCOORD.xy, pos3) - rad3;
	float min1 = smoothMin(dst1, dst2, smoothing);
	float min2 = smoothMin(min1, dst3, smoothing);
	
	if(min2 <= 0.0){
		COLOR = vec4(1,1,1,1);
	} else {
		COLOR = vec4(0,0,0,0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
