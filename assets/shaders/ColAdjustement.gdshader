shader_type canvas_item;

// Controls
uniform float brightness = 0.0;  // Adjust brightness (-1.0 to 1.0)
uniform float gamma = 1.0;       // Adjust gamma (0.1 to 3.0)
uniform float saturation = 1.0;  // Adjust saturation (0.0 to 2.0)
uniform vec4 modulate : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Tint color

// Converts RGB to grayscale using perceived luminance
float luminance(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}

void fragment() {
    vec4 color = texture(TEXTURE, UV);

    // Adjust brightness
    color.rgb += brightness;

    // Adjust gamma
    color.rgb = pow(color.rgb, vec3(1.0 / gamma));

    // Convert to grayscale for saturation adjustment
    vec3 gray = vec3(luminance(color.rgb));
    color.rgb = mix(gray, color.rgb, saturation);

    // Apply modulation (tint color)
    color *= modulate;

    COLOR = color;
}
