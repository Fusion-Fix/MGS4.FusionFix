// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:57 2026
Texture2D<uint4> t3 : register(t3);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[14];
}




// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);


void main( 
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : COLOR2,
  float2 w2 : TEXCOORD0,
  float4 v3 : TEXCOORD8,
  float4 v4 : TEXCOORD9,
  uint v5 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyz = cb0[1].xyz * r0.xyz;
  r1.w = 10.6761513 * cb0[2].x;
  r1.w = exp2(r1.w);
  r1.xyz = r1.xyz * r1.www;
  bitmask.w = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.w = (((uint)v5.x << 1) & bitmask.w) | ((uint)0 & ~bitmask.w);
  r1.w = (int)r1.w + -1;
  r1.w = (int)r1.w;
  r2.xy = float2(0.699999988,0.699999988) * cb0[12].xy;
  r2.zw = v3.xy / v3.ww;
  r3.xy = r2.zw * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.w = v4.y * r1.w + v3.z;
  r3.z = saturate(r1.w / v3.w);
  r1.w = -1 + cb0[13].x;
  r2.z = 360 / r1.w;
  r4.z = 0;
    r3.w = 0;
  r4.w = 0;
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
      r4.x = r6.x * spiralR;
      r4.y = r5.x * spiralR;
      rotX = ign_cos * r4.x - ign_sin * r4.y;
      rotY = ign_sin * r4.x + ign_cos * r4.y;
      r5.x = r2.x * rotX + r3.x;
      r5.y = r2.y * rotY + r3.y;
      r5.z = r3.z;
      r4.x = t1.SampleCmpLevelZero(s1_s, r5.xy, r5.z).x;
      r3.w = r4.x + r3.w;
    }
  }
  r1.w = 1 / cb0[13].x;
  r2.x = r3.w * r1.w;
  r1.w = -r3.w * r1.w + 1;
  r2.y = saturate(v4.x);
  r1.w = r1.w * r2.y + r2.x;
  r2.x = cmp(v4.z < 0);
  r1.w = r2.x ? r1.w : 0;
  r1.w = r1.w * 0.5 + 0.5;
  r0.xyz = r1.xyz * r1.www;
  r1.xyzw = v1.xyzw * r0.xyzw;
  r0.w = cmp(r1.w < 0.498039216);
  if (r0.w != 0) discard;
  r0.w = max(cb0[9].z, v2.x);
  r0.w = min(cb0[9].w, r0.w);
  r0.w = cb0[10].w * r0.w;
  r0.xyz = -r0.xyz * v1.xyz + cb0[10].xyz;
  r0.xyz = r0.www * r0.xyz + r1.xyz;
  r0.w = max(r0.x, r0.y);
  r1.x = max(0.25, r0.z);
  r0.w = max(r1.x, r0.w);
  r0.w = 1 / r0.w;
  r1.xyz = saturate(r0.xyz * r0.www);
  r1.w = saturate(0.25 * r0.w);
  o0.xyzw = r1.xyzw;
  r0.x = cmp(cb0[0].x >= 0.501960814);
  r0.y = ~(int)r0.x;
  r0.z = -0.501960814 + cb0[0].x;
  r0.z = cmp(r1.w >= r0.z);
  r0.x = r0.z ? r0.x : 0;
  if (r0.x != 0) discard;
  r0.x = cmp(r1.w < cb0[0].x);
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  r0.x = cmp(0 < cb0[11].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[11].y;
    r1.zw = float2(0,0);
    r0.y = t3.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  return;
}