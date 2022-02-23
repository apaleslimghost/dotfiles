#version 120

//#define TAA

varying vec2 texcoord;
varying vec4 color;

#ifdef TAA
uniform float viewWidth;
uniform float viewHeight;
vec2 texelSize = vec2(1.0/viewWidth,1.0/viewHeight);
uniform int framemod8;
const vec2[8] offsets = vec2[8](vec2(1./8.,-3./8.),
								vec2(-1.,3.)/8.,
								vec2(5.0,1.)/8.,
								vec2(-3,-5.)/8.,
								vec2(-5.,5.)/8.,
								vec2(-7.,-1.)/8.,
								vec2(3,7.)/8.,
								vec2(7.,-7.)/8.);
#endif

void main() {
	gl_Position = ftransform();
#ifdef TAA
	gl_Position.xy += offsets[framemod8] * gl_Position.w*texelSize;
#endif
	texcoord = (gl_MultiTexCoord0).xy;
	color = gl_Color;
}
