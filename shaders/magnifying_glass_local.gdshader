shader_type canvas_item;

//uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform vec2 target = vec2(300);
uniform float radius: hint_range(50, 200) = 50.0;
uniform int strength: hint_range(1, 512) = 2;

vec4 blur_size(sampler2D tex,vec2 fragCoord, vec2 pixelSize) {
    float strengthFloat = float(strength);
	float strenghtX = strengthFloat + sin(TIME);
	float strenghtY = strengthFloat + 2.0 * sin(0.5 * TIME);

    vec2 pixel = fragCoord/pixelSize;
    int x_min = max(int(pixel.x-strenghtX), 0);
    int x_max = min(int(pixel.x+strenghtX), int(1./pixelSize.x));
    int y_min = max(int(pixel.y-strenghtY), 0);
    int y_max = min(int(pixel.y+strenghtY), int(1./pixelSize.y));

    vec4 color = vec4(0.,0.,0.,0.);
	
    // Sum the pixels colors
    for(int x=x_min; x <= x_max; x++) {
        for(int y = y_min; y <= y_max; y++) {           
            color += texture(tex, vec2(float(x), float(y)) * pixelSize);
        }
    }
    
    // Divide the color by the number of colors you summed up
	int count = (y_max - y_min + 1) * (x_max - x_min + 1);
    color /= float(count);
    
    return color;
}

const int pixelSize = 10;
vec2 pixelize(vec2 fragCoord) {
	float x = float(int(fragCoord.x) % pixelSize);
	float y = float(int(fragCoord.y) % pixelSize);
	
	float fpxHalf = floor(float(pixelSize) / 2.0);
	x = fpxHalf - x;
	y = fpxHalf - y;
	
	x = fragCoord.x + x;
	y = fragCoord.y + y;
	
	return vec2(x, y);
}

// if no preview is active and we just see the scene, apply a slight blur to the scene
//  - important things like the clock and the calendar are blurred strongly -> another shader on the object itself
// once the preview becomes active, make the region in front of the camera really blurry - or the other way around?
void fragment() {
	vec2 fragPos = FRAGCOORD.xy;
	float dist = distance(fragPos, target);
	
	if (dist < radius) {
		COLOR = texture(TEXTURE, UV);
	}
	else {
		COLOR = blur_size(TEXTURE, UV, TEXTURE_PIXEL_SIZE);	
	}
	//COLOR = texture(TEXTURE, pixelize(FRAGCOORD.xy) * SCREEN_PIXEL_SIZE);
	//return;
	//vec2 fragPos = FRAGCOORD.xy;
	//float dist = distance(fragPos, target);
	//
	//float _lod = lod;
	//vec2 _uv = UV;
	//
	//if (dist < radius) {
		//// do not blur
		//_lod = 0.0;
		//
		//// magnify
		//vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
		//vec2 targetUV = target / resolution;
		//_uv = (_uv - targetUV) * zoom + targetUV;
	//}
//
	//COLOR = texture(TEXTURE, _uv, _lod);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
