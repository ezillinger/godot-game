shader_type canvas_item;

uniform vec4 player_color;
uniform vec4 flash_color;
uniform float flash_amount;

uniform sampler2D noiseTexture;

void fragment(){

	
	vec2 uv = (2.0 * UV - vec2(1,1));
	uv.x = 2. * abs(uv.x);
	
	float time = TIME * 10.0;
	vec4 noise = texture(noiseTexture, uv);
	
	
	
	COLOR = vec4(0);
	
	if((uv.x < (-uv.y + 1.0))
	&& (mod(uv.x, 0.79) > 0.1 || uv.y > 0. - uv.x)
	&& (uv.y < 0.7)//&& ((abs(uv.x) > 0.1 && uv.y < 0.7 ) && uv.y > 0.0 - uv.x)
	){
		vec4 color = noise * 0.2 + player_color;
		COLOR = color;
		COLOR = clamp(COLOR, vec4(0,0,0,1), vec4(1));
		COLOR = mix(COLOR, flash_color, flash_amount);
	}
	else {
		if(
			mod(uv.x, 0.5) < 0.4
			&& uv.x < 1.50
			&& (uv.x > 1.0)
			&& (uv.y < 0.05 / (sqrt(uv.x) ))
		){
			COLOR = vec4(0,0,0,1);
			float t = 0.01 * mod(time, 1000.0);
			COLOR += 1.0 * texture(noiseTexture, vec2(uv.x + t, uv.y + t)) * vec4(player_color);
		}
	}
	
	float len = length(uv);
	if(len < 0.35){
		COLOR = mix(vec4(0,0,1,1), vec4(1,0,1,0.5), len);
	}
	

	
	

}