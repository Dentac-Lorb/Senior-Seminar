shader_type canvas_item;


uniform float smoothing = 10;

const int circles = 5;
uniform vec2[circles] circleCoords;// = [vec2(0.5,0.5), vec2(0.2,0.7), vec2(0.5,0.5), vec2(0.5,0.5), vec2(0.5,0.5)];
uniform float[circles] radii;
uniform vec2 offset;
uniform sampler2D sandTexture: repeat_enable;
uniform sampler2D normalTexture: repeat_enable;

global uniform vec3 global_light;


// Smoothing function from Sebastion Lague
// https://youtu.be/Cp5WWtMoeKg?t=189
float smoothMin(float dstA, float dstB, float k){
	float h = max(k-abs(dstA-dstB), 0) / k;
	return min(dstA, dstB) - h*h*h*k/6.0;
}

float shadow(vec2 origin, vec2 relative, float radius){
	float dist = distance(vec2(0.0), relative);
	float intensity = distance(global_light, vec3(0.0));
	float light_angle = asin(global_light.z / intensity);
	float surface_angle = asin(dist/radius);
	if (surface_angle < light_angle){
		return 1.0;
	}
	float light_vertical = (surface_angle-light_angle)/PI;
	float light_horiz_mag = distance(global_light.xy, vec2(0.0));
	float light_horiz_angle = acos(global_light.x / light_horiz_mag);
	float frag_angle = acos(relative.x / dist);
	float angle_dif = light_horiz_angle - frag_angle;
	
	float light_horizontal = 0.0;
	if (angle_dif < 0.25 * PI && angle_dif > -0.25 * PI){
		light_horizontal = 1.0;
	}
	
	return 1.0-light_horizontal;
	
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
	for(int i = 1; i < circles; i++){
		dists[i] = distance(FRAGCOORD.xy, offset + circleCoords[i]) - radii[i];
		if (dists[i] < dist){
			trueMinDist = dists[i];
			trueMinDistIndex = i;
		}
		dist = smoothMin(dist, dists[i], smoothing);
		
	}
	float trueMinDistSq = trueMinDist * trueMinDist;
	vec2 distortionDirection = (circleCoords[trueMinDistIndex] + offset - FRAGCOORD.xy) / radii[trueMinDistIndex]; 
	vec2 distortion = distortionDirection * trueMinDistSq;
	/*vec2(
		trueMinDistSq * sin(distortionDirection.x),
		trueMinDistSq * sin(distortionDirection.y)
	);*/
	float distortion_magnitude = distance(vec2(0.0), distortionDirection);
	float darken = 1.0 - distortion_magnitude * distortion_magnitude * .5;
	//float shadow = shadow(circleCoords[trueMinDistIndex] + offset, circleCoords[trueMinDistIndex] + offset - FRAGCOORD.xy, radii[trueMinDistIndex]);
	vec4 sandCol = texture(sandTexture, (FRAGCOORD.xy + offset + distortion)/1000.0);// * darken;// * shadow;
	//COLOR = vec4(sandCol.rgb, smoothstep(-2, 0, -dist));
	COLOR.rgb = sandCol.rgb;
	COLOR.a = smoothstep(-0.02, 0, -dist);
	
	vec4 sandNorm = texture(normalTexture, (FRAGCOORD.xy + offset)/10.0);
	
	NORMAL.rgb = vec3(distortion.rg / radii[trueMinDistIndex] + sandNorm.rg,  -0.5 + 0.5 * tan(asin(trueMinDist / radii[trueMinDistIndex])) * sandNorm.b);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
