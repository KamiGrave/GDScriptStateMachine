shader_type canvas_item;

void fragment()
{
	vec4 light_mask_a = texture(TEXTURE, UV);
	COLOR = vec4(0.0f,0.0f,0.0f,1.0f-light_mask_a.a);
}