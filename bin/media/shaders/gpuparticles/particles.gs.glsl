#version 430

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

out vec2 ex_TexCoor;

uniform mat4  viewMatrix;
uniform mat4  projMatrix;
uniform vec4  camPos;

float quadLength = 0.01f;

void main(void){
  vec4 normal = normalize(viewMatrix * gl_in[0].gl_Position - camPos);
  
  vec3 rightAxis  = cross(normal.xyz, vec3(0,1,0));
  vec3 upAxis   = cross(rightAxis, normal.xyz);
  
  vec4 rightVector  = projMatrix * vec4(rightAxis.xyz, 1.0f) * (quadLength*0.5f);
  vec4 upVector     = projMatrix * vec4(upAxis.xyz, 1.0f) * (quadLength*0.5f);
  vec4 particlePos  = projMatrix * viewMatrix * gl_in[0].gl_Position;

  gl_Position = particlePos-rightVector - upVector;
  ex_TexCoor = vec2(0,0);
  EmitVertex();
  
  gl_Position = particlePos+rightVector - upVector;
  gl_Position.x += 0.5;
  ex_TexCoor = vec2(1,0);
  EmitVertex();
  
  gl_Position = particlePos-rightVector + upVector;
  gl_Position.y += 0.5;
  ex_TexCoor = vec2(0,1);
  EmitVertex();
  
  gl_Position = particlePos+rightVector + upVector;
  gl_Position.y += 0.5;
  gl_Position.x += 0.5;
  ex_TexCoor = vec2(1,1);
  EmitVertex();
}
