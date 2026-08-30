// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:42 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[10];
}




// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);


void main( 
  float4 v0 : SV_POSITION0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float4 v6 : TEXCOORD5,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(v5.x >= 0);
  if (r0.x != 0) discard;
  r0.x = cmp(v5.y < 0);
  if (r0.x != 0) discard;
  r0.x = cmp(v5.z >= 0);
  if (r0.x != 0) discard;
  r0.x = cmp(v5.w < 0);
  if (r0.x != 0) discard;
  r0.x = cmp(v6.x >= 0);
  if (r0.x != 0) discard;
  r0.x = cmp(v6.y < 0);
  if (r0.x != 0) discard;
  r0.x = cmp(v2.w < 0);
  if (r0.x != 0) discard;
  r0.xyz = v2.xyz / v2.www;
  r1.xyzw = r0.xyxy * float4(0.5,-0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  r0.x = t0.Sample(s0_s, v1.xy).w;
  r2.xyzw = t1.Sample(s1_s, r1.zw).xyzw;
  r2.xyz = r2.xyz * r2.www;
  r2.xyz = cb0[1].xyz * r2.xyz;
  r1.z = saturate(r0.z);
  r0.z = -1 + cb0[9].x;
  r0.w = 360 / r0.z;
  r3.z = 0;
    r1.w = 0;
  r2.w = 0;
  {
    r1.w = 0;
    ignAngle = frac(dot(v0.xy, float2(0.06711056, 0.00583715)));
    ignAngle = frac(52.9829189 * ignAngle) * 2 * 3.14159265359;
    sincos(ignAngle, ign_sin, ign_cos);
    [unroll]
    for (int j = 0; j < 8; j++) {
      spiralR = sqrt((j + 0.5) / 8);
      spiralTheta = j * 2.39996323;
      sincos(spiralTheta, r4.x, r5.x);
      r3.x = r5.x * spiralR;
      r3.y = r4.x * spiralR;
      rotX = ign_cos * r3.x - ign_sin * r3.y;
      rotY = ign_sin * r3.x + ign_cos * r3.y;
      r3.x = cb0[8].z * rotX + r1.x;
      r3.y = cb0[8].w * rotY + r1.y;
      r3.w = r1.z;
      r3.x = t2.SampleCmpLevelZero(s2_s, r3.xy, r3.w).x;
      r1.w = r3.x + r1.w;
    }
  }
  r0.y = 1 / cb0[9].x;
  r0.y = r1.w * r0.y;
  r0.z = saturate(v2.w * cb0[3].x + -cb0[3].y);
  r0.z = saturate(cb0[3].z * r0.z + cb0[3].w);
  r0.w = dot(v4.xyz, v4.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = v4.xyz * r0.www;
  r0.w = dot(v3.xyz, v3.xyz);
  r0.w = rsqrt(r0.w);
  r3.xyz = v3.xyz * r0.www;
  r0.w = saturate(dot(r1.xyz, r3.xyz));
  r0.z = r0.w * r0.z;
  r0.y = r0.y * r0.z;
  o0.xyz = r2.xyz * r0.yyy;
  o0.w = r0.x;
  return;
}