#version 120

void main() {
	gl_FragData[0] = vec4(0.0); //remove default sky etc to prevent it from messing with out shader sky.
}