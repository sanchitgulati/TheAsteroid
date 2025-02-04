shader_type canvas_item;

void fragment() {
    vec4 src_color = texture(TEXTURE, UV);
    float alpha = src_color.a;
    
    // Draw the outline
    vec4 out_color = vec4(vec3(0.0), 1.0); // The color of your outline (here it's black)
    float out_alpha = 0.5; // The opacity of your outline
    
    vec4 final_color = mix(src_color, out_color, out_alpha);
    
    // Uncomment the line below if you want to discard pixels that are fully transparent
    // discard if (final_color.a == 0.0);

    COLOR = final_color;
}
