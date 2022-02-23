#version 120

varying vec4 color;
varying vec2 lmcoord;
varying vec3 normal;

void main() {
	
	gl_Position = ftransform();
	
	color = gl_Color;
	
	lmcoord = gl_MultiTexCoord1.xy/255.0;
	normal = normalize(gl_NormalMatrix * gl_Normal);	

}