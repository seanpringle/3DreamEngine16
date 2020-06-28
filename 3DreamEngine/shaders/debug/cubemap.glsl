#pragma language glsl3

extern CubeImage tex;

vec4 effect(vec4 c, Image uv, vec2 tc, vec2 sc) {
	vec4 pos = Texel(uv, tc);
	float u = pos.x;
	float v = pos.y;
	int i = int(pos.z*255.0);
	
	float x, y, z;
	
	// convert range 0 to 1 to -1 to 1
	float uc = 2.0 * u - 1.0;
	float vc = 2.0 * v - 1.0;
	if (i == 0) {x =  1.0; y =    vc; z =   -uc;}	// POSITIVE X
	if (i == 1) {x = -1.0; y =    vc; z =    uc;}	// NEGATIVE X
	if (i == 2) {x =    uc; y =  1.0; z =   -vc;}	// POSITIVE Y
	if (i == 3) {x =    uc; y = -1.0; z =    vc;}	// NEGATIVE Y
	if (i == 4) {x =    uc; y =    vc; z =  1.0;}	// POSITIVE Z
	if (i == 5) {x =   -uc; y =    vc; z = -1.0;}	// NEGATIVE Z
  
	vec4 col = textureLod(tex, vec3(x, y, z), 0.0)  ;
	return vec4(col.rgb, pos.a * col.a);
}