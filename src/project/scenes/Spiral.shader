shader_type canvas_item;

float spiral(vec2 m, float t) {
	float r = length(m);
	float a = atan(m.y, m.x);
	float v = sin(100.*(sqrt(r)-0.02*a-.3*t));
	return clamp(v, 0.,1.);
}

void fragment(){
    // Important vector that determines the center of the spiral
    // Change OFFSET in order to move the spiral's center. 
    vec2 OFFSET = vec2(0.68, 0.643);
    
    vec4 col = texture(TEXTURE, UV); 
	float t = TIME * 0.1;
    vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy / iResolution.y * OFFSET;
    vec2 centered_on = vec2(.9,.5);

	float v = spiral(centered_on-uv, t);

    if(col.a > 0.5) {
    	    vec3 col2 = vec3(v);
        if (col2.r < 0.001) {
            COLOR = vec4(col2,1.);
        } else {
            COLOR = vec4(col2, 0.0);
        }
	    
    }
    else {
        COLOR = col;
    }
}
