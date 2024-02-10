shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

uniform vec2 target = vec2(300);


uniform float strength_low: hint_range(0.0, 5.0) = 2.0;
uniform float strength_high: hint_range(0.0, 6.0) = 6.0;

uniform float radius: hint_range(50, 200) = 50.0;
uniform float zoom: hint_range(0.1, 1.0) = 0.9;

// if no preview is active and we just see the scene, apply a slight blur to the scene
//  - important things like the clock and the calendar are blurred strongly -> another shader on the object itself
// once the preview becomes active, make the region in front of the camera really blurry - or the other way around?
void fragment() {
	vec2 fragPos = FRAGCOORD.xy;
	float dist = distance(fragPos, target);
	
	float modulate = abs((sin(TIME) + sin(10.0 * TIME) / 10.0)/ 10.0);
	float sx = sin(PI * (SCREEN_UV.x + modulate));
	float interpolate = 1.0 - (sx * sx);
	
	float _lod = strength_low + (interpolate) * (strength_high - strength_low);
	vec2 _uv = SCREEN_UV;
	
	if (dist < radius) {
		// do not blur
		_lod = 0.0;
		
		// magnify
		vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
		vec2 targetUV = target / resolution;
		_uv = (_uv - targetUV) * zoom + targetUV;
	}

	COLOR = texture(screen_texture, _uv, _lod);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
