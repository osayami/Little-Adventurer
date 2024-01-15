shader_type spatial;

uniform vec3 baseColor_2 : source_color;
varying vec2 world_vertex;
uniform sampler2D base;
uniform sampler2D tex1;
uniform sampler2D grassTexture;
uniform sampler2D AOMap;
uniform sampler2D maskMap;
uniform sampler2D normalMap;
uniform float intensity=0.5f;
uniform vec3 baseColor:source_color;
uniform vec3 blockColor:source_color;

void vertex(){
	world_vertex = (MODEL_MATRIX * vec4(VERTEX,1.0)).xz;
	world_vertex.x = world_vertex.x * 0.01f;
	world_vertex.y = world_vertex.y * 0.01f;
}


void fragment()
{
  vec2 time = TIME * vec2(1.0f,1.0f) * 0.005f;
	
  ALBEDO = texture(tex1,world_vertex + time).rgb;
  ALBEDO += intensity;
  ALBEDO = clamp(ALBEDO,0.0f,1.0f);
  vec3 color = ALBEDO.rgb;
  color *= texture(AOMap,UV2).rgb;
  color *= texture(base,UV).rgb;
  float mask = texture(maskMap,UV).r;
if(mask< 0.4f){
	color *= blockColor;
}else{
	  color *=  mix(baseColor,baseColor_2, (1.0f - texture(grassTexture,UV2).rgb));
	  color *= (baseColor*(mask));
	
}

  ALBEDO = color.rgb;

  NORMAL_MAP = texture(normalMap,UV).rgb;
  AO = 1.0f;
  AO_LIGHT_AFFECT = 1.0f;
  METALLIC = 0.0f;
  ROUGHNESS = 1.0f;
 
 
}