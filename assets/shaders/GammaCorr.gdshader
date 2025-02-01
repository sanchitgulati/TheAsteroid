shader_type canvas_item;

uniform float gamma : hint_range(0.1, 3.0) = 1.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.rgb = pow(color.rgb, vec3(1.0 / gamma)); // Apply gamma correction
    COLOR = color;
}
