shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

uniform vec2 target = vec2(300);

uniform float lod: hint_range(0.0, 5) = 0.0;
uniform float radius: hint_range(50, 200) = 50.0;
uniform float zoom: hint_range(0.1, 1.0) = 0.9;

void fragment() {
	vec2 fragPos = FRAGCOORD.xy;
	float dist = distance(fragPos, target);
	
	float _lod = lod;
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
