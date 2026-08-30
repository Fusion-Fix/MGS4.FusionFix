// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:42 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s1_s : register(s1);

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
  float4 r0,r1,r2,r3,r4;
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
  r0.x = t0.Sample(s0_s, v1.xy).w;
  r0.x = cmp(r0.x < 0.5);
  if (r0.x != 0) discard;
  r0.xyz = v2.xyz / v2.www;
  r0.xy = r0.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.z = saturate(r0.z);
  r1.x = -1 + cb0[9].x;
  r1.y = 360 / r1.x;
  r2.z = 0;
    r1.z = 0;
  r1.w = 0;
  {
    r1.z = 0;
    ignAngle = frac(dot(v0.xy, float2(0.06711056, 0.00583715)));
    ignAngle = frac(52.9829189 * ignAngle) * 2 * 3.14159265359;
    sincos(ignAngle, ign_sin, ign_cos);
    [unroll]
    for (int j = 0; j < 8; j++) {
      spiralR = sqrt((j + 0.5) / 8);
      spiralTheta = j * 2.39996323;
      sincos(spiralTheta, r3.x, r4.x);
      r2.x = r4.x * spiralR;
      r2.y = r3.x * spiralR;
      rotX = ign_cos * r2.x - ign_sin * r2.y;
      rotY = ign_sin * r2.x + ign_cos * r2.y;
      r2.x = cb0[8].z * rotX + r0.x;
      r2.y = cb0[8].w * rotY + r0.y;
      r2.w = r0.z;
      r2.x = t1.SampleCmpLevelZero(s1_s, r2.xy, r2.w).x;
      r1.z = r2.x + r1.z;
    }
  }
  r0.x = 1 / cb0[9].x;
  r0.y = saturate(v2.w * cb0[3].x + -cb0[3].y);
  r0.y = cb0[3].z * r0.y + cb0[3].w;
  r0.y = saturate(cb0[1].w * r0.y);
  r0.z = dot(cb0[0].xyz, cb0[0].xyz);
  r0.z = rsqrt(r0.z);
  r1.xyw = cb0[0].xyz * r0.zzz;
  r0.z = dot(v3.xyz, v3.xyz);
  r0.z = rsqrt(r0.z);
  r2.xyz = v3.xyz * r0.zzz;
  r0.z = saturate(dot(r1.xyw, r2.xyz));
  r0.x = -r1.z * r0.x + 1;
  r0.x = r0.x * r0.z;
  r0.x = saturate(r0.x * r0.y);
  o0.w = 1 + -r0.x;
  o0.xyz = float3(0,0,0);
  return;
}