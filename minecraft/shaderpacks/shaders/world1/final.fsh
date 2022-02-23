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
/*---------------------------
/////ADJUSTABLE VARIABLES/////
----------------------------*/	
//#define Crossprocess				//It's like a color filter, alters all colors abit if enabled.	

//#define Depth_of_Field			//Simulates eye focusing on objects. Low performance impact
	//#define Distance_Blur			//Requires Depth of Field to be enabled. Replaces eye focusing effect with distance being blurred instead.
    #define smoothDof				//Toggle smooth transition between clear and blurry.	
	#define DoF_Strength 90			//[60 90 120 150]
	#define Dof_Distance_View 256	//[128 256 384 512]
	
//#define Motionblur				//Blurres your view/camera during movemenent. Low performance impact. Doesn't work with Depth of Field.
	#define MB_strength 0.014		//[0.008 0.014 0.020]

//#define Tonemap					//Toggle tonemapping, slightly altering colors / color balance. Based of vibrant shaders, which uses uncharted2tonemap.
/*---------------------------
//END OF ADJUSTABLE VARIABLES//
----------------------------*/	

varying vec2 texcoord;
varying vec4 color;

uniform sampler2D colortex3;	//taa mixed with everything

//Disable uneeded samplers and such if neither dof nor motionblur is used.
#ifdef Depth_of_Field
#define Blur
#endif
#ifdef Motionblur
#define Blur
#endif

#ifdef Blur
uniform sampler2D depthtex0;	//everything
uniform sampler2D depthtex1;	//everything but transparency
uniform sampler2D depthtex2;	//everything but transparency+hand
uniform float near;
uniform float far;
uniform float aspectRatio;
uniform float viewWidth;
uniform float rainStrength;
uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferPreviousProjection;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferPreviousModelView;
#endif

#ifdef Depth_of_Field
//Dof constant values
const float focal = 0.024;
float aperture = 0.008;	
const float sizemult = DoF_Strength;
uniform float centerDepthSmooth; 
const float centerDepthHalflife = 2.0f; 

float ld(float depth) {
    return (2.0 * near) / (far + near - depth * (far - near));
}

float fast_blur[9] = float[9](-0.5, -0.375, -0.25, -0.125, 0.0, 0.125, 0.25, 0.375, 0.5);

vec3 calcDof(vec3 color, float depth0, float depth1){
	float pw = 1.0/ viewWidth;
	float z = ld(depth0)*far;
	#ifdef smoothDof
	float focus = ld(centerDepthSmooth)*far;
	#else
	float focus = ld(texture2D(depthtex0, vec2(0.5)).r)*far;
	#endif
	float pcoc = min(abs(aperture * (focal * (z - focus)) / (z * (focus - focal)))*sizemult,pw*15.0);
#ifdef Distance_Blur
	float getdist = 1-(exp(-pow(ld(depth1)/Dof_Distance_View*far,4.0)*4.0));	
	if(depth1 < 1.0-near/far/far)pcoc = getdist*pw*20.0;
#endif
	for ( int i = 0; i < 9; i++) {
		color += texture2D(colortex3, texcoord.xy + fast_blur[i]*pcoc*vec2(1.0,aspectRatio)).rgb;
	}
return color*0.11; //*0.11 = / 9
}
#endif

#ifdef Motionblur
vec3 calcMotionBlur(vec3 color, float depth1){
	vec4 currentPosition = vec4(texcoord.xy, depth1, 1.0)*2.0-1.0;
	
	vec4 fragposition = gbufferProjectionInverse * currentPosition;
		 fragposition = gbufferModelViewInverse * fragposition;
		 fragposition /= fragposition.w;
		 fragposition.xyz += cameraPosition;
	
	vec4 previousPosition = fragposition;
		 previousPosition.xyz -= previousCameraPosition;
		 previousPosition = gbufferPreviousModelView * previousPosition;
		 previousPosition = gbufferPreviousProjection * previousPosition;
		 previousPosition /= previousPosition.w;

	vec2 velocity = (currentPosition - previousPosition).st * MB_strength;
	vec2 coord = texcoord.st + velocity;

	int mb = 1;
	for (int i = 0; i < 15; ++i, coord += velocity) {
		if (coord.s > 1.0 || coord.t > 1.0 || coord.s < 0.0 || coord.t < 0.0) break;
		color += texture2D(colortex3, coord).xyz;
		++mb;
	}
return color /= mb;
}
#endif

#ifdef Tonemap
#define gamma 2.2	//Adjust gamma used by tonemapping. [1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0]
vec3 Uncharted2Tonemap(vec3 x) {
	float A = 0.28;
	float B = 0.29;		
	float C = 0.08;	//default 0.010
	float D = 0.2;
	float E = 0.025;
	float F = 0.35;
	return ((x*(A*x+C*B)+D*E)/(x*(A*x+B)+D*F))-E/F;
}
#endif

void main() {

	vec4 tex = texture2D(colortex3, texcoord.xy)*color;
	
#ifdef Blur
//Setup depths, do it here because amd drivers suck and texture reads outside of void main or functions are broken, thanks amd
float depth0 = texture2D(depthtex0, texcoord.xy).x;
float depth1 = texture2D(depthtex1, texcoord.xy).x;
float depth2 = texture2D(depthtex2, texcoord.xy).x;
bool hand = depth0 < depth2;
if(depth0 < depth1 || !hand){
	#ifdef Depth_of_Field
		tex.rgb = calcDof(tex.rgb, depth0, depth1);
	#endif

	#ifdef Motionblur
		tex.rgb = calcMotionBlur(tex.rgb, depth1);
	#endif
}
#endif

#ifdef Crossprocess
	tex.r = (tex.r*1.3)+(tex.b+tex.g)*(-0.1);
    tex.g = (tex.g*1.2)+(tex.r+tex.b)*(-0.1);
    tex.b = (tex.b*1.1)+(tex.r+tex.g)*(-0.1);
	tex = tex / (tex + 2.2) * (1.0+2.0);
#endif

#ifdef Tonemap
	tex.rgb = Uncharted2Tonemap(tex.rgb)*gamma;
#endif

	gl_FragData[0] = tex;
}
