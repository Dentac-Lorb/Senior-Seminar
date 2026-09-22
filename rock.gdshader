shader_type canvas_item;


uniform float smoothing = 10;

const int circles = 5;
uniform vec2[circles] circleCoords;// = [vec2(0.5,0.5), vec2(0.2,0.7), vec2(0.5,0.5), vec2(0.5,0.5), vec2(0.5,0.5)];
uniform float[circles] radii;
uniform vec2 offset;
uniform sampler2D sandTexture: repeat_enable;



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
	//float dist = distance(POINT_COORD, circleCoords[0]) - radii[0];
	//for(int i = 1; i < circles; i++){
		//dist = smoothMin(dist, distance(POINT_COORD, circleCoords[i]) - radii[i], smoothing);
	//}
	//vec4 sandCol = texture(sandTexture, POINT_COORD*vec2(textureSize(sandTexture, 0)));
	//COLOR = vec4(sandCol.rgb, smoothstep(-2, 0, -dist));
	//COLOR.a = smoothstep(-0.02, 0, -dist);
	float[circles] dists;
	float dist = distance(FRAGCOORD.xy, offset + circleCoords[0]) - radii[0];
	dists[0] = dist;
	float trueMinDist = dist;
	int trueMinDistIndex = 0;
	//for(int i = 1; i < circles; i++){
		//dist = smoothMin(dist, distance(FRAGCOORD.xy, circleCoords[i]) - radii[i], smoothing);
	//}
	vec2 distortionDirection = (circleCoords[trueMinDistIndex] + offset - FRAGCOORD.xy) / radii[trueMinDistIndex]; 
	vec2 distortion = vec2(
		trueMinDist * trueMinDist * cos(distortionDirection.x),
		trueMinDist * trueMinDist * sin(distortionDirection.y)
	);
	float darken = 1.0 - distance(vec2(0.0), distortion) / trueMinDist / trueMinDist;
	vec4 sandCol = texture(sandTexture, (FRAGCOORD.xy + offset + distortion)/500.0) * darken;
	//COLOR = vec4(sandCol.rgb, smoothstep(-2, 0, -dist));
	COLOR.rgb = sandCol.rgb;
	COLOR.a = smoothstep(-0.02, 0, -dist);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
