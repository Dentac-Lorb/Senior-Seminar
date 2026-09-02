shader_type canvas_item;

//uniform vec2 pos1;
//uniform vec2 pos2;
//uniform vec2 pos3;
//uniform float rad1 = 20.0;
//uniform float rad1a = 28.0;
//uniform float rad2 = 20.0;
//uniform float rad2a = 17.0;
//uniform float rad3 = 15.0;
uniform float smoothing = 100;

const int circles = 5;
uniform vec2[circles] positions;
uniform float[circles] radii;

// Smoothing function from Sebastion Lague
// https://youtu.be/Cp5WWtMoeKg?t=189
float smoothMin(float dstA, float dstB, float k){
	float h = max(k-abs(dstA-dstB), 0) / k;
	return min(dstA, dstB) - h*h*h*k/6.0;
}

float circleDist(vec4 frag, int index){
	return distance(frag.xy, positions[index]) - radii[index];
}

float smoothMinDist(vec4 frag){
	float mindist = 100000.0;
	for(int i = 0; i < circles; i++){
		mindist = smoothMin(mindist, circleDist(frag, i), smoothing);
	}
	return mindist;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//float dst1 = distance(FRAGCOORD.xy, pos1) - rad1;
	//float dst1a = distance(FRAGCOORD.xy, (pos1 + pos2)/2.0) - rad1a;
	//float dst2 = distance(FRAGCOORD.xy, pos2) - rad2;
	//float dst2a = distance(FRAGCOORD.xy, (pos2 + pos3)/2.0) - rad2a;
	//float dst3 = distance(FRAGCOORD.xy, pos3) - rad3;
	//float min1 = smoothMin(dst1, dst2, smoothing);
	//float min2 = smoothMin(min1, dst3, smoothing);
	//float min3 = smoothMin(min2, dst1a, smoothing);
	//float min4 = smoothMin(min3, dst2a, smoothing);
	float dist = smoothMinDist(FRAGCOORD);
	float alpha = smoothstep(-2, 0, -dist) * .5 + .5;
	COLOR = vec4(1,1,1,alpha);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
