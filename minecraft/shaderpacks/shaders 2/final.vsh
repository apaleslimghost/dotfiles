#version 120

#define final
#include "shaders.settings"

varying vec2 texcoord;

#ifdef Rain_Drops
varying vec2 rainPos1;
varying vec2 rainPos2;
varying vec2 rainPos3;
varying vec2 rainPos4;
varying vec4 weights;
uniform ivec2 eyeBrightnessSmooth;
uniform float rainStrength;
uniform float frameTimeCounter;

vec2 noisepattern(vec2 pos) {
	return vec2(abs(fract(sin(dot(pos, vec2(83147.6995379f, 125370.887575f))))));
}
#endif

void main() {

	gl_Position = ftransform();
	texcoord = (gl_MultiTexCoord0).xy;

#ifdef Rain_Drops
	const float lifetime = 4.0;		//water drop lifetime in seconds
	float ftime = frameTimeCounter*2.0/lifetime;  
	vec2 drop = vec2(0.0,fract(frameTimeCounter/20.0));
	rainPos1 = fract((noisepattern(vec2(-0.94386347*floor(ftime*0.5+0.25),floor(ftime*0.5+0.25))))*0.8+0.1 - drop);
	rainPos2 = fract((noisepattern(vec2(0.9347*floor(ftime*0.5+0.5),-0.2533282*floor(ftime*0.5+0.5))))*0.8+0.1- drop);
	rainPos3 = fract((noisepattern(vec2(0.785282*floor(ftime*0.5+0.75),-0.285282*floor(ftime*0.5+0.75))))*0.8+0.1- drop);
	rainPos4 = fract((noisepattern(vec2(-0.347*floor(ftime*0.5),0.6847*floor(ftime*0.5))))*0.8+0.1- drop);
	weights.x = 1.0-fract((ftime+0.5)*0.5);
	weights.y = 1.0-fract((ftime+1.0)*0.5);
	weights.z = 1.0-fract((ftime+1.5)*0.5);
	weights.w = 1.0-fract(ftime*0.5);
	weights *= rainStrength*clamp((eyeBrightnessSmooth.y-220)/15.0,0.0,1.0);
#endif
}
