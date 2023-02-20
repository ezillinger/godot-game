shader_type canvas_item;

uniform sampler2D noiseTexture;
uniform sampler2D starNoiseTexture;

const float PI = 3.14159265358979323846;

// Takes in the UV and warps the edges, creating the spherized effect
vec2 warp(vec2 uv){
	float warp_amount = 0.9;
	vec2 delta = uv - 0.5;
	float delta2 = dot(delta.xy, delta.xy);
	float delta4 = delta2 * delta2;
	float delta_offset = delta4 * warp_amount;
	
	return uv + delta * delta_offset;
}

float lerp(float a, float b, float t){
	return a + (b - a) * t;
}

vec3 make_stars(vec2 uv) {
	float time = TIME / 7.0;
	vec4 noise = texture(starNoiseTexture, uv + vec2(time, -0.13 * time));
	vec4 noise2 = vec4(0.3) * texture(noiseTexture, uv * 6.4 + vec2(0.01 * time, 0.01 * time));
	float threshold = 1.59;
	float len = length(noise);
	if(len > threshold){
		return vec3(0.5 + noise2.x, 
					0.5 + noise2.y, 
					0.8 + noise2.z) * lerp(0, 100, (len - threshold) * (len - threshold));
	}
	return vec3(0);
	
}

void fragment(){
	float time = TIME / 5.0;
	vec2 uv = warp(UV);
	vec3 stars = make_stars(uv);
	vec4 noise = texture(noiseTexture, uv + vec2(time, -0.13 * time));
	uv += noise.xy;
	COLOR = texture(TEXTURE, fract(UV + noise.xy));
	COLOR.xyz *= COLOR.xyz * 0.25;
	COLOR.xyz += 0.8 * stars;
	
}