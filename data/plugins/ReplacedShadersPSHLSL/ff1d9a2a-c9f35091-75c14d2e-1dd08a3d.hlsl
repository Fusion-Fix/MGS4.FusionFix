// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:01 2026
Texture2D<float4> t0 : register(t0);

SamplerComparisonState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[2];
}




// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);


void main( 
  float4 v0 : SV_POSITION0,
  float v1 : COLOR2,
  float2 w1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  int4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(0.699999988,0.699999988) * cb0[0].xy;
  r0.zw = v7.xy / v7.ww;
  r1.xy = r0.zw * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.z = v8.y + v7.z;
  r1.z = saturate(r0.z / v7.w);
  r0.z = -1 + cb0[1].x;
  r0.w = 360 / r0.z;
  r2.z = 0;
    r2.w = 0;
  r3.x = 0;
  {
    r2.w = 0;
    ignAngle = frac(dot(v0.xy, float2(0.06711056, 0.00583715)));
    ignAngle = frac(52.9829189 * ignAngle) * 2 * 3.14159265359;
    sincos(ignAngle, ign_sin, ign_cos);
    [unroll]
    for (int j = 0; j < 8; j++) {
      spiralR = sqrt((j + 0.5) / 8);
      spiralTheta = j * 2.39996323;
      sincos(spiralTheta, r4.x, r5.x);
      r2.x = r5.x * spiralR;
      r2.y = r4.x * spiralR;
      rotX = ign_cos * r2.x - ign_sin * r2.y;
      rotY = ign_sin * r2.x + ign_cos * r2.y;
      r3.y = r0.x * rotX + r1.x;
      r3.z = r0.y * rotY + r1.y;
      r3.w = r1.z;
      r2.x = t0.SampleCmpLevelZero(s0_s, r3.yz, r3.w).x;
      r2.w = r2.x + r2.w;
    }
  }
  r0.x = 1 / cb0[1].x;
  r0.y = r2.w * r0.x;
  r0.x = -r2.w * r0.x + 1;
  r0.z = saturate(v8.x);
  r0.x = r0.x * r0.z + r0.y;
  r0.x = 1 + -r0.x;
  r0.x = v6.w * r0.x;
  r0.y = cmp(r0.x < 0.00392156886);
  if (r0.y != 0) discard;
  o0.xyz = float3(0,0,0);
  o0.w = r0.x;
  return;
}