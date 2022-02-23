#version 120
/* DRAWBUFFERS:0 */

varying vec4 color;

varying vec2 lmcoord;
varying vec3 normal;

//encode normal in two channel (xy), emissive lightmap (z) and sky lightmap (w), blend mode must be disabled in shaders.properties for this to work without issues.
vec4 encode (vec3 n){
    return vec4(n.xy*inversesqrt(n.z*8.0+8.0) + 0.5, lmcoord);
}

float encodeVec2(float x, float y){
    const vec2 constant1 = vec2(1.0, 256.0) / 65535.0;
    vec2 temp = floor(vec2(x,y) * 255.0);
	return temp.x*constant1.x+temp.y*constant1.y;
}

void main() {

	vec4 albedo = color;
		 albedo.a = (albedo.a>0.1)? 1.0 : 0.0;

	vec4 normalmat = clamp(encode(normal),0.0,1.0);	
	gl_FragData[0] = vec4(encodeVec2(albedo.x,normalmat.x),encodeVec2(albedo.y,normalmat.y),encodeVec2(albedo.z,normalmat.z),encodeVec2(normalmat.w,albedo.w));	
}