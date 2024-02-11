shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

// Set to the mouse position from script
uniform vec2 target = vec2(300);

uniform float strength_low: hint_range(0.0, 5.0) = 2.0;
uniform float strength_high: hint_range(0.0, 6.0) = 6.0;

uniform float radius: hint_range(50, 200) = 50.0;
uniform float zoom: hint_range(0.1, 1.0) = 0.9;

const float blur_increase = 0.01;

void fragment() {
	float blur_fade_distance = radius / 2.0;
	
	vec2 fragPos = FRAGCOORD.xy;
	float dist = distance(fragPos, target);
	
	// The blur is not constant 
	//	- it depends on the x coordinate of the pixel
	//  - pixels more to the side are blurred more strongly
	//  - this is further modulated based on time
	float modulate = abs((sin(TIME) + sin(10.0 * TIME) / 10.0)/ 10.0);
	float sx = sin(PI * (SCREEN_UV.x + modulate));
	float interpolate = 1.0 - (sx * sx);
	
	float _lod = strength_low + (interpolate) * (strength_high - strength_low);
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
		//float fade_proportion = dist_from_radius / blur_fade_distance;
		//float x = clamp(fade_proportion, 0.0, 1.0);
		//float blur_strength = x;//min(1.0, (x) * blur_increase);
		float blur_strength = clamp(dist_from_radius / blur_fade_distance, 0.0, 1.0);
		
		_lod = _lod * blur_strength;
		
		float zoom_faded = mix(zoom, 1.0, blur_strength);
		_uv = (_uv - targetUV) * zoom_faded + targetUV;
	}

	COLOR = texture(screen_texture, _uv, _lod);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
