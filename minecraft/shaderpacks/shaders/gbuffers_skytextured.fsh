#version 120
/* DRAWBUFFERS:02 */ //0=gcolor, 2=gnormal for normals

varying vec2 texcoord;
varying vec4 color;
uniform sampler2D texture;

void main() {

	gl_FragData[0] = texture2D(texture, texcoord.xy)*color;
    gl_FragData[1] = vec4(0.0); //fills normal buffer with 0.0, improves overall performance
}
