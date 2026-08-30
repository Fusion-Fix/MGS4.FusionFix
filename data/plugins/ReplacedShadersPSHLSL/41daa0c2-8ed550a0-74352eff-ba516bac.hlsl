// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:57 2026
Texture2D<uint4> t4 : register(t4);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[16];
}




// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);


void main( 
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : COLOR2,
  float3 w2 : TEXCOORD4,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD5,
  float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  uint v9 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v3.xy).xyzw;
  r1.xyzw = t1.Sample(s1_s, v3.zw).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r2.x = (((uint)v9.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r2.x = (int)r2.x + -1;
  r2.x = (int)r2.x;
  r2.yz = float2(0.699999988,0.699999988) * cb0[14].xy;
  r3.xy = v7.xy / v7.ww;
  r3.xy = r3.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r2.x = v8.y * r2.x + v7.z;
  r3.z = saturate(r2.x / v7.w);
  r2.x = -1 + cb0[15].x;
  r2.w = 360 / r2.x;
  r4.z = 0;
    r4.w = 0;
  r5.x = 0;
  {
    r4.w = 0;
    ignAngle = frac(dot(v0.xy, float2(0.06711056, 0.00583715)));
    ignAngle = frac(52.9829189 * ignAngle) * 2 * 3.14159265359;
    sincos(ignAngle, ign_sin, ign_cos);
    [unroll]
    for (int j = 0; j < 8; j++) {
      spiralR = sqrt((j + 0.5) / 8);
      spiralTheta = j * 2.39996323;
      sincos(spiralTheta, r6.x, r7.x);
      r4.x = r7.x * spiralR;
      r4.y = r6.x * spiralR;
      rotX = ign_cos * r4.x - ign_sin * r4.y;
      rotY = ign_sin * r4.x + ign_cos * r4.y;
      r5.y = r2.y * rotX + r3.x;
      r5.z = r2.z * rotY + r3.y;
      r5.w = r3.z;
      r4.x = t2.SampleCmpLevelZero(s2_s, r5.yz, r5.w).x;
      r4.w = r4.x + r4.w;
    }
  }
  r0.w = max(r1.w, r0.w);
  r0.w = v1.w * r0.w;
  r2.x = cmp(r0.w < cb0[0].x);
  if (r2.x != 0) discard;
  r1.xyz = r1.xyz + -r0.xyz;
  r0.xyz = r1.www * r1.xyz + r0.xyz;
  r0.xyz = cb0[1].xyz * r0.xyz;
  r1.xyz = v1.xyz + v1.xyz;
  r1.w = dot(v5.xyz, v5.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = v5.xyz * r1.www;
  r1.w = dot(cb0[10].xyz, r2.xyz);
  r2.w = 1 / cb0[15].x;
  r3.x = r4.w * r2.w;
  r2.w = -r4.w * r2.w + 1;
  r3.y = saturate(v8.x);
  r2.w = r2.w * r3.y + r3.x;
  r1.w = cmp(r1.w < 0);
  r1.w = r1.w ? r2.w : 0;
  r3.xyz = cb0[9].xyz * r1.www;
  r1.w = saturate(dot(cb0[10].xyz, -r2.xyz));
  r1.xyz = r3.xyz * r1.www + r1.xyz;
  r2.xyz = r1.xyz * r0.xyz;
  r1.w = max(cb0[11].z, v2.x);
  r1.w = min(cb0[11].w, r1.w);
  r1.w = cb0[12].w * r1.w;
  r0.xyz = -r0.xyz * r1.xyz + cb0[12].xyz;
  o0.xyz = r1.www * r0.xyz + r2.xyz;
  r0.x = cmp(0 < cb0[13].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[13].y;
    r1.zw = float2(0,0);
    r0.y = t4.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  o0.w = r0.w;
  return;
}