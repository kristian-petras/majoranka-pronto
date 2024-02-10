shader_type canvas_item;

uniform int strength_low: hint_range(1, 512) = 2;
uniform int strength_high: hint_range(1, 512) = 10;

vec4 blur_size(sampler2D tex, vec2 fragCoord, vec2 pixelSize, vec2 suv) {
    float strengthLowF = float(strength_low);
	float strengthHighF = float(strength_high);
	
	//float strengthFloat = 10.0;// smoothstep(strengthLowF, strengthHighF, fragCoord.y);
	float modulate = abs((sin(TIME) + sin(10.0 * TIME) / 10.0)/ 10.0);
	float sx = sin(PI * (suv.x + modulate));
	float interpolate = 1.0 - (sx * sx);
	float strengthFloat = strengthLowF + (interpolate) * (strengthHighF - strengthLowF);
    
	vec2 pixel = fragCoord/pixelSize;
    int x_min = max(int(pixel.x-strengthFloat), 0);
    int x_max = min(int(pixel.x+strengthFloat), int(1./pixelSize.x));
    int y_min = max(int(pixel.y-strengthFloat), 0);
    int y_max = min(int(pixel.y+strengthFloat), int(1./pixelSize.y));

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

// if no preview is active and we just see the scene, apply a slight blur to the scene
//  - important things like the clock and the calendar are blurred strongly -> another shader on the object itself
// once the preview becomes active, make the region in front of the camera really blurry - or the other way around?
void fragment() {	
	COLOR = blur_size(TEXTURE, UV, TEXTURE_PIXEL_SIZE, SCREEN_UV);
	//COLOR = vec4(UV.x, 0.0, 0.0, )
	//float dist = distance(fragPos, target);
	//
	//float _lod = lod;
	//vec2 _uv = SCREEN_UV;
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
	//COLOR = texture(screen_texture, _uv, _lod);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
