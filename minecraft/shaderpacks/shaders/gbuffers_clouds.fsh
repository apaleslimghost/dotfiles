#version 120
/* DRAWBUFFERS:02 */ //0=gcolor, 2=gnormal for normals
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

#define Fog		//Toggle default fog.

varying vec2 texcoord;
varying vec4 color;
uniform sampler2D texture;

#ifdef Fog
const int GL_LINEAR = 9729;
const int GL_EXP = 2048;
uniform int fogMode;
#endif

void main() {

	gl_FragData[0] = texture2D(texture, texcoord.xy)*color;
	gl_FragData[1] = vec4(0.0); //fill normal buffer with 0.0, improves performance

#ifdef Fog
	if (fogMode == GL_EXP) {
		gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, 1.0 - clamp(exp(-gl_Fog.density * gl_FogFragCoord), 0.0, 1.0));
	} else if (fogMode == GL_LINEAR) {
		gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
	}
#endif	
}
