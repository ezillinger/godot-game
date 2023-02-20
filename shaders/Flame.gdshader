shader_type canvas_item;

uniform sampler2D noiseTexture;

void fragment(){
	vec2 uv = UV * 2.0 - vec2(1,1);// + vec2(TIME, TIME);
	float alpha = 1.0;
	
	if(true || length(uv) > 0.80){
		alpha = smoothstep(1.0, 0.0, length(uv) + abs(uv.y * uv.y * uv.y));
	}
	
	uv.y += TIME;
	
	vec4 noise = texture(noiseTexture, uv);
	COLOR = vec4(1.64,-0.23,0.2,1.0) * noise * noise;
	COLOR.a = alpha;
	
}