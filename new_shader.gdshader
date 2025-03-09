shader_type sky;
render_mode use_half_res_pass;

group_uniforms sky;
uniform vec3 top_color : source_color;
uniform vec3 bottom_color : source_color;
uniform vec3 sun_scatter : source_color;

group_uniforms clouds;
uniform int cloud_samples : hint_range(8, 32, 8) = 16;

vec2 cloud_ray_march(vec3 direction, vec3 sun_direction)
{
	float density = 0.0;
	float light = 0.0;
	float height = 0.03;
	
	vec3 sample_point = vec3(0.0, 0.0, 2.0);
	
	int loop_offset = cloud_samples * 3;
	
	for (int i = loop_offset; i < cloud_samples + loop_offset; i++)
	{
		
	}
	
	return vec2(0.0);
}

void sky() 
{
	// Sky
	float horizon_mask = abs(EYEDIR.y);
	
	vec3 sky_gradient = mix(bottom_color.rgb, top_color.rgb, clamp(EYEDIR.y, 0.0, 1.0));
	vec3 sunset_color = sun_scatter * (1.0 - horizon_mask);
	vec3 sky_color = clamp(sky_gradient + sunset_color, 0.0, 1.0);
	COLOR = sky_color;
	
	// Clouds
	if (AT_HALF_RES_PASS)
	{
		vec3 clouds_direction = vec3(EYEDIR.xz / clamp(EYEDIR.y, 0.0, 1.0), 1.0);
		vec2 clouds = EYEDIR.y > 0.0 ? cloud_ray_march(vec3(0.0), vec3(0.0)) : vec2(0.0);
	}
}
