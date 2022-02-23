#version 120
/*
Sildur's enhanced default, before editing, remember the agreement you've accepted by downloading this shaderpack:
http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291396-1-6-4-1-12-1-sildurs-shaders-pc-mac-intel

You are allowed to:
- Modify it for your own personal use only, so don't share it online.

You are not allowed to:
- Rename and/or modify this shaderpack and upload it with your own name on it.
- Provide mirrors by reuploading my shaderpack, if you want to link it, use the link to my thread found above.
- Copy and paste code or even whole files into your "own" shaderpack.
*/

#define Shadows
#define SHADOW_MAP_BIAS 0.80
#define grass_shadows
varying vec3 texcoord;
attribute vec4 mc_Entity;

#ifdef Shadows
vec2 calcShadowDistortion(in vec2 shadowpos) {
	float distortion = ((1.0 - SHADOW_MAP_BIAS) + length(shadowpos.xy * 1.25) * SHADOW_MAP_BIAS) * 0.85;
	return shadowpos.xy / distortion;
}
#endif

void main() {

vec4 position = gl_ModelViewProjectionMatrix * gl_Vertex;
#ifdef Shadows
	 position.xy = calcShadowDistortion(position.xy);
#endif

	gl_Position = position;

	texcoord.xy = (gl_MultiTexCoord0).xy;
	texcoord.z = 1.0;

	if(mc_Entity.x == 10008.0) texcoord.z = 0.0;
#ifndef grass_shadows
	if(mc_Entity.x == 10031.0 || mc_Entity.x == 10175.0 || mc_Entity.x == 10176.0) texcoord.z = 0.0;	
#endif
}
