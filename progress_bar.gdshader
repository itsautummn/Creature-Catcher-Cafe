shader_type spatial;

uniform bool billboard;
uniform float progress : hint_range(0.0, 1.0, 0.01);
uniform vec3 progress_color : source_color;
uniform vec3 empty_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
	if (billboard)
	{
        MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
	if (UV.x < progress)
	{
		ALBEDO.rgb *= progress_color;
	}
	else
	{
		ALBEDO.rgb *= empty_color;
	}
}
