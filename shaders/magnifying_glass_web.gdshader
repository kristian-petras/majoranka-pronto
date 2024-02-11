shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap, repeat_disable;

// Set to the mouse position from script
uniform vec2 target = vec2(300);

uniform float strength_low: hint_range(0.0, 10.0) = 2.0;
uniform float strength_high: hint_range(0.0, 20.0) = 6.0;

uniform float radius: hint_range(50, 200) = 50.0;
uniform float zoom: hint_range(0.1, 1.0) = 0.9;

const float blur_increase = 0.01;

// Xor's gausian blur function 
// Link: https://xorshaders.weebly.com/tutorials/blur-shaders-5-part-2
// Defaults from: https://www.shadertoy.com/view/Xltfzj
//
// BLUR BLURRINESS (Default 8.0)
// BLUR ITERATIONS (Default 16.0 - More is better but slower)
// BLUR QUALITY (Default 4.0 - More is better but slower)
//
// Desc.: Don't have the best performance but will run on almost
// anything, although, if developing for mobile, is better to use 
// 'texture_nodevgaussian(...) instead'.
vec4 texture_xorgaussian(sampler2D tex, vec2 uv, vec2 pixel_size, float blurriness, int iterations, int quality){
	float pi = 6.28;
	
	vec2 blur_radius = blurriness / (1.0 / pixel_size).xy;
	vec4 blurred_tex = texture(tex, uv);
	
	for(float d = 0.0; d < pi; d += pi / float(iterations)){
		for( float i = 1.0 / float(quality); i <= 1.0; i += 1.0 / float(quality) ){
			vec2 directions = uv + vec2(cos(d), sin(d)) * blur_radius * i;
			blurred_tex += texture(tex, directions);
		}
	}
	blurred_tex /= float(quality) * float(iterations) + 1.0;
	
	return blurred_tex;
}

void fragment() {
	float blur_fade_distance = radius / 2.0;
	
	vec2 fragPos = FRAGCOORD.xy;
	float dist = distance(fragPos, target);
	
	// The blur is not constant 
	//	- it depends on the x coordinate of the pixel
	//  - pixels more to the side are blurred more strongly
	//  - this is further modulated based on time
	float modulate = abs((sin(TIME) + sin(10.0 * TIME) / 5.0)/ 10.0);
	float sx = sin(PI * (SCREEN_UV.x + modulate));
	float interpolate = 1.0 - (sx * sx);
	
	float _lod = mix(strength_low, strength_high, interpolate);//strength_low + (interpolate) * (strength_high - strength_low);
	vec2 _uv = SCREEN_UV;
	
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 targetUV = target / resolution;
	
	if (dist < radius) {
		// do not blur
		_lod = 0.0;

		// magnify instead
		_uv = (_uv - targetUV) * zoom + targetUV;
	}
	else {
		float dist_from_radius = dist - radius;
		float fade_factor = clamp(dist_from_radius / blur_fade_distance, 0.0, 1.0);
		float blur_strength = fade_factor * fade_factor;
		
		_lod = _lod * blur_strength;
	
		float zoom_faded = mix(zoom, 1.0, blur_strength);
		_uv = (_uv - targetUV) * zoom_faded + targetUV;
	}

	//COLOR = texture(screen_texture, _uv, _lod);
	COLOR = texture_xorgaussian(screen_texture, _uv, SCREEN_PIXEL_SIZE, _lod, 16, 6);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
