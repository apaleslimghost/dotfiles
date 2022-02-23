#version 120

//#define Godrays

varying vec2 texcoord;
varying vec4 color;
#ifdef Godrays
varying vec2 lightPos;
#endif
uniform vec3 sunPosition;
uniform mat4 gbufferProjection;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_MultiTexCoord0).xy;
#ifdef Godrays	
	vec4 tpos = vec4(sunPosition,1.0)*gbufferProjection;
	tpos = vec4(tpos.xyz/tpos.w,1.0);
	vec2 pos1 = tpos.xy/tpos.z;
	lightPos = pos1*0.5+0.5;
#endif

	color = gl_Color;
}
