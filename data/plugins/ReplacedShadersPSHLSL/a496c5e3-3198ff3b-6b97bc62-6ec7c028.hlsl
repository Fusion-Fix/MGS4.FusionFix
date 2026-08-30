// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:54 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
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
  float4 v3 : TEXCOORD8,
  float4 v4 : TEXCOORD9,
  uint v5 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w1.xy).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.x = (((uint)v5.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r1.x = (int)r1.x + -1;
  r1.x = (int)r1.x;
  r1.yz = float2(0.699999988,0.699999988) * cb0[3].xy;
  r2.xy = v3.xy / v3.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.x = v4.y * r1.x + v3.z;
  r2.z = saturate(r1.x / v3.w);
  r1.x = -1 + cb0[4].x;
  r1.w = 360 / r1.x;
  r3.z = 0;
    r3.w = 0;
  r4.x = 0;
  {
    r3.w = 0;
    ignAngle = frac(dot(v0.xy, float2(0.06711056, 0.00583715)));
    ignAngle = frac(52.9829189 * ignAngle) * 2 * 3.14159265359;
    sincos(ignAngle, ign_sin, ign_cos);
    [unroll]
    for (int j = 0; j < 8; j++) {
      spiralR = sqrt((j + 0.5) / 8);
      spiralTheta = j * 2.39996323;
      sincos(spiralTheta, r5.x, r6.x);
      r3.x = r6.x * spiralR;
      r3.y = r5.x * spiralR;
      rotX = ign_cos * r3.x - ign_sin * r3.y;
      rotY = ign_sin * r3.x + ign_cos * r3.y;
      r4.y = r1.y * rotX + r2.x;
      r4.z = r1.z * rotY + r2.y;
      r4.w = r2.z;
      r3.x = t1.SampleCmpLevelZero(s1_s, r4.yz, r4.w).x;
      r3.w = r3.x + r3.w;
    }
  }
  r0.w = cmp(r0.w < 0.498039216);
  if (r0.w != 0) discard;
  r0.w = dot(v2.xyz, cb0[0].xyz);
  r1.x = 1 / cb0[4].x;
  r1.y = r3.w * r1.x;
  r1.x = -r3.w * r1.x + 1;
  r1.z = saturate(v4.x);
  r1.x = r1.x * r1.z + r1.y;
  r0.w = cmp(r0.w < 0);
  r0.w = r0.w ? r1.x : 0;
  r0.w = r0.w * 0.75 + 0.25;
  r1.xyz = r0.xyz * r0.www;
  r1.w = max(cb0[1].z, v1.x);
  r1.w = min(cb0[1].w, r1.w);
  r1.w = cb0[2].w * r1.w;
  r0.xyz = -r0.xyz * r0.www + cb0[2].xyz;
  r0.xyz = r1.www * r0.xyz + r1.xyz;
  r0.w = max(r0.x, r0.y);
  r1.x = max(0.25, r0.z);
  r0.w = max(r1.x, r0.w);
  r0.w = 1 / r0.w;
  o0.xyz = saturate(r0.xyz * r0.www);
  o0.w = saturate(0.25 * r0.w);
  return;
}