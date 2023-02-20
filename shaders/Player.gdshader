shader_type canvas_item;

uniform vec4 player_color;
uniform vec4 flash_color;
uniform float flash_amount;

uniform sampler2D noiseTexture;

void fragment(){

	
	vec2 uv = (2.0 * UV - vec2(1,1));
	uv.x = 2. * abs(uv.x);
	
	float time = TIME * 10.0;
	vec4 noise = texture(noiseTexture, UV + vec2(sin(time* 0.071), cos(time * 0.089)));
	
	COLOR = vec4(0);
	
	if(uv.x < (-uv.y + 1.0) 
	//&& (mod(uv.x, 0.2) > 0.1 || uv.y > 0. - uv.x)
	//&& (uv.x > 0.1 || uv.y > 0. - uv.x)
	){
		vec4 color = noise * 0.2 + player_color;
		COLOR = color;
		COLOR = clamp(COLOR, vec4(0,0,0,1), vec4(1,1,1,1));
		COLOR = mix(COLOR, flash_color, flash_amount);
	}
	
	

}