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
/*--------------------
//ADJUSTABLE VARIABLES//
---------------------*/
#define animationSpeed 1.0  //[0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0]
#define Waving_Leaves
#define Waving_Vines
#define Waving_Grass
#define Waving_Entities			//Includes: Saplings, small flowers, wheat, carrots, potatoes and beetroot.
#define Waving_Tallgrass
#define Waving_Fire
#define Waving_Lava
#define Waving_Water
#define Waving_Lanterns
#define waves_amplitude 0.65    //[0.55 0.65 0.75 0.85 0.95 1.05 1.15 1.25 1.35 1.45 1.55 1.65 1.75 1.85 1.95 2.05]

//Reflections
#define Reflections				//also adjust in fragment aswell as composite.fsh
#define WaterReflection
#define TransparentReflections	//see block.properties, transparent blocks are assigned to ice (79)

#define nMap 0					//[0 1 2]0=Off 1=Bumpmapping, 2=Parallax,

//#define TAA
/*---------------------------
//END OF ADJUSTABLE VARIABLES//
----------------------------*/

//Moving entities IDs
//See block.properties for mapped ids
#define ENTITY_SMALLGRASS   10031.0	//
#define ENTITY_LOWERGRASS   10175.0	//lower half only in 1.13+
#define ENTITY_UPPERGRASS	10176.0 //upper half only used in 1.13+
#define ENTITY_SMALLENTS    10059.0	//sapplings(6), dandelion(37), rose(38), carrots(141), potatoes(142), beetroot(207)

#define ENTITY_LEAVES       10018.0	//161 new leaves
#define ENTITY_VINES        10106.0

#define ENTITY_WATER		10008.0	//9
#define ENTITY_LILYPAD      10111.0	//
#define ENTITY_ICE			10079.0	//transparent reflections, stained glass(95, 160), slimeblock(165)

#define ENTITY_FIRE         10051.0	//
#define ENTITY_LAVA   		10010.0	//11
#define ENTITY_EMISSIVE		10089.0 //emissive blocks defined in block.properties
#define ENTITY_WAVING_LANTERN 10090.0

varying vec4 color;
varying vec3 vworldpos;
varying mat3 tbnMatrix;
varying vec2 texcoord;
varying vec2 lmcoord;
varying float iswater;
varying float mat;

attribute vec4 mc_Entity;
attribute vec4 mc_midTexCoord;
attribute vec4 at_tangent;                      //xyz = tangent vector, w = handedness, added in 1.7.10

uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

//moving stuff
uniform float frameTimeCounter;
const float PI = 3.14;
float pi2wt = (150.79*frameTimeCounter) * animationSpeed;

vec3 calcWave(in vec3 pos, in float fm, in float mm, in float ma, in float f0, in float f1, in float f2, in float f3, in float f4, in float f5) {
	float magnitude = sin(pi2wt*fm + dot(pos, vec3(0.5))) * mm + ma;
	vec3 d012 = sin(vec3(f0, f1, f2)*pi2wt);
	
    vec3 ret;
		 ret.x = pi2wt*f3 + d012.x + d012.y - pos.x + pos.z + pos.y;
		 ret.z = pi2wt*f4 + d012.y + d012.z + pos.x - pos.z + pos.y;
		 ret.y = pi2wt*f5 + d012.z + d012.x + pos.z + pos.y - pos.y;
		 ret = sin(ret)*magnitude;
	
    return ret;
}

vec3 calcMove(in vec3 pos, in float f0, in float f1, in float f2, in float f3, in float f4, in float f5, in vec3 amp1, in vec3 amp2) {
    vec3 move1 = calcWave(pos      , 0.0027, 0.0400, 0.0400, 0.0127, 0.0089, 0.0114, 0.0063, 0.0224, 0.0015) * amp1;
	vec3 move2 = calcWave(pos+move1, 0.0348, 0.0400, 0.0400, f0, f1, f2, f3, f4, f5) * amp2;
    return move1+move2;
}/*---*/

#if nMap == 2
varying float dist;
varying vec3 viewVector;
varying vec4 vtexcoordam; // .st for add, .pq for mul
varying vec2 vtexcoord;
varying float isblock; 	//mc_Entity.x, hack to only apply pom to blocks
#endif

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

	//Positioning
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;	
	vec3 position = mat3(gbufferModelViewInverse) * (gl_ModelViewMatrix * gl_Vertex).xyz + gbufferModelViewInverse[3].xyz;

	vworldpos = position.xyz + cameraPosition;
	bool istopv = gl_MultiTexCoord0.t < mc_midTexCoord.t;

#ifdef Waving_Tallgrass
if (mc_Entity.x == ENTITY_LOWERGRASS && istopv || mc_Entity.x == ENTITY_UPPERGRASS)
			position.xyz += calcMove(vworldpos.xyz,
			0.0041,
			0.0070,
			0.0044,
			0.0038,
			0.0240,
			0.0000,
			vec3(0.8,0.0,0.8),
			vec3(0.4,0.0,0.4));

#endif
if (istopv) {
#ifdef Waving_Grass
	if ( mc_Entity.x == ENTITY_SMALLGRASS)
			position.xyz += calcMove(vworldpos.xyz,
				0.0041,
				0.0070,
				0.0044,
				0.0038,
				0.0063,
				0.0000,
				vec3(3.0,1.6,3.0),
				vec3(0.0,0.0,0.0));
#endif
#ifdef Waving_Entities
	if (mc_Entity.x == ENTITY_SMALLENTS)
			position.xyz += calcMove(vworldpos.xyz,
			0.0041,
			0.0070,
			0.0044,
			0.0038,
			0.0240,
			0.0000,
			vec3(0.8,0.0,0.8),
			vec3(0.4,0.0,0.4));
#endif
#ifdef Waving_Fire
	if ( mc_Entity.x == ENTITY_FIRE)
			position.xyz += calcMove(vworldpos.xyz,
			0.0105,
			0.0096,
			0.0087,
			0.0063,
			0.0097,
			0.0156,
			vec3(1.2,0.4,1.2),
			vec3(0.8,0.8,0.8));
#endif
}

#ifdef Waving_Leaves
	if ( mc_Entity.x == ENTITY_LEAVES)
			position.xyz += calcMove(vworldpos.xyz,
			0.0040,
			0.0064,
			0.0043,
			0.0035,
			0.0037,
			0.0041,
			vec3(1.0,0.2,1.0),
			vec3(0.5,0.1,0.5));
#endif
#ifdef Waving_Vines
	if ( mc_Entity.x == ENTITY_VINES)
			position.xyz += calcMove(vworldpos.xyz,
			0.0040,
			0.0064,
			0.0043,
			0.0035,
			0.0037,
			0.0041,
			vec3(0.5,1.0,0.5),
			vec3(0.25,0.5,0.25));
#endif
#ifdef Waving_Lava
	if(mc_Entity.x == ENTITY_LAVA){
		float fy = fract(vworldpos.y + 0.001);
		float wave = 0.05 * sin(2 * PI * (frameTimeCounter*0.2 + vworldpos.x /  7.0 + vworldpos.z / 13.0))
				   + 0.05 * sin(2 * PI * (frameTimeCounter*0.15 + vworldpos.x / 11.0 + vworldpos.z /  5.0));
		position.y += clamp(wave, -fy, 1.0-fy)*0.5;
	}
#endif
	iswater = 0.0;
	if(mc_Entity.x == ENTITY_WATER)iswater = 0.95;	//don't fully remove shadows on water plane
#ifdef Waving_Water
	if(mc_Entity.x == ENTITY_WATER || mc_Entity.x == ENTITY_LILYPAD) { //water, lilypads
		float fy = fract(vworldpos.y + 0.001);
		float wave = 0.05 * sin(2 * PI * (frameTimeCounter*0.8 + vworldpos.x /  2.5 + vworldpos.z / 5.0))
				   + 0.05 * sin(2 * PI * (frameTimeCounter*0.6 + vworldpos.x / 6.0 + vworldpos.z /  12.0));
		position.y += clamp(wave, -fy, 1.0-fy)*waves_amplitude;
	}
#endif

#ifdef Waving_Lanterns
	if(mc_Entity.x == ENTITY_WAVING_LANTERN){
		vec3 fxyz = fract(vworldpos.xyz + 0.001);
		float wave = 0.025 * sin(2 * PI * (frameTimeCounter*0.4 + vworldpos.x * 0.5 + vworldpos.z * 0.5));
					//+ 0.025 * sin(2 * PI * (frameTimeCounter*0.4 + worldpos.y *0.25 + worldpos.z *0.25));
		float waveY = 0.05 * cos(frameTimeCounter*2.0 + vworldpos.y);
		position.x -= clamp(wave, -fxyz.x, 1.0-fxyz.x);
		position.y += clamp(waveY*0.25, -fxyz.y, 1.0-fxyz.y)+0.015;		
		position.z += clamp(wave*0.45, -fxyz.z, 1.0-fxyz.z);
	}
#endif

mat = 0.0;
#ifdef Reflections
#ifdef WaterReflection
	if(mc_Entity.x == ENTITY_WATER)mat = 1.0;
#endif
#ifdef TransparentReflections
	if(mc_Entity.x == ENTITY_ICE)mat = 2.0; //various ids are mapped to ice in block.properties
#endif
#endif

	gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(position, 1.0);

#ifdef TAA
	gl_Position.xy += offsets[framemod8] * gl_Position.w*texelSize;
#endif

	//Fog
	gl_FogFragCoord = length(position.xyz);

	color = gl_Color;

	//Fix colors on emissive blocks
	if(mc_Entity.x == ENTITY_EMISSIVE || mc_Entity.x == ENTITY_LAVA || mc_Entity.x == ENTITY_FIRE ||  mc_Entity.x == ENTITY_WAVING_LANTERN || mc_Entity.x == 10300.0)color = vec4(1.0);

	//Bump & Parallax mapping
	vec3 normal = normalize(gl_NormalMatrix * gl_Normal);	
	vec3 tangent = normalize(gl_NormalMatrix * at_tangent.xyz);
	vec3 binormal = normalize(gl_NormalMatrix * cross(at_tangent.xyz, gl_Normal.xyz) * at_tangent.w);
	tbnMatrix = mat3(tangent.x, binormal.x, normal.x,
					 tangent.y, binormal.y, normal.y,
					 tangent.z, binormal.z, normal.z);

#if nMap == 2
	isblock = mc_Entity.x;
	if(mc_Entity.x == ENTITY_EMISSIVE || mc_Entity.x == 10300.0)isblock = -1.0; //enable bump and parallax mapping for defined ids.	
	vec2 midcoord = (gl_TextureMatrix[0] *  mc_midTexCoord).st;
	vec2 texcoordminusmid = texcoord.xy-midcoord;
	vtexcoordam.pq  = abs(texcoordminusmid)*2;
	vtexcoordam.st  = min(texcoord.xy ,midcoord-texcoordminusmid);
	vtexcoord.xy    = sign(texcoordminusmid)*0.5+0.5;
	
	viewVector = tbnMatrix * (mat3(gl_ModelViewMatrix) * gl_Vertex.xyz + gl_ModelViewMatrix[3].xyz);
	dist = length(gl_ModelViewMatrix * gl_Vertex);
#endif
}