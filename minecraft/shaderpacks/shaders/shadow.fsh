#version 120
/* DRAWBUFFERS:02 */ //0=gcolor, 2=gnormal for normals

varying vec3 texcoord;
uniform sampler2D texture;
uniform int blockEntityId;

void main() {

	vec4 color = texture2D(texture, texcoord.xy)*texcoord.z;
	if(blockEntityId == 10089.0) color *= 0.0;			 	//remove beacon beam shadows, 10089 is actually the id of all emissive blocks but only the beam should be a block entity

	gl_FragData[0] = color;
	gl_FragData[1] = vec4(0.0); //improves performance
}
