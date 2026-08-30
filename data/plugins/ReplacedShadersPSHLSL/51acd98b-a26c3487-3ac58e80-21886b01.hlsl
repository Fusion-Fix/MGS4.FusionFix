// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:01 2026
Texture2D<uint4> t3 : register(t3);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[25];
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
  float4 v3 : TEXCOORD4,
  float4 v4 : TEXCOORD5,
  float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD8,
  float4 v7 : TEXCOORD9,
  uint v8 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.x = (((uint)v8.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r1.x = (int)r1.x + -1;
  r1.x = (int)r1.x;
  r1.yz = float2(0.699999988,0.699999988) * cb0[23].xy;
  r2.xy = v6.xy / v6.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.x = v7.y * r1.x + v6.z;
  r2.z = saturate(r1.x / v6.w);
  r1.x = -1 + cb0[24].x;
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
  r0.w = v1.w * r0.w;
  r0.w = cmp(r0.w < 0.498039216);
  if (r0.w != 0) discard;
  r0.w = dot(cb0[17].xyz, v5.xyz);
  r1.x = 1 / cb0[24].x;
  r1.y = r3.w * r1.x;
  r1.x = -r3.w * r1.x + 1;
  r1.z = saturate(v7.x);
  r1.x = r1.x * r1.z + r1.y;
  r0.w = cmp(r0.w < 0);
  r0.w = r0.w ? r1.x : 0;
  r1.x = saturate(dot(-v5.xyz, cb0[17].xyz));
  r1.y = saturate(dot(-v5.xyz, cb0[18].xyz));
  r1.z = saturate(dot(-v5.xyz, cb0[19].xyz));
  r2.xyz = cb0[8].xyz * r0.www;
  r3.xyz = cb0[9].xyz * r1.yyy;
  r1.xyw = r2.xyz * r1.xxx + r3.xyz;
  r1.xyz = cb0[10].xyz * r1.zzz + r1.xyw;
  r0.w = dot(-v5.xyz, cb0[16].xyz);
  r2.xyz = cb0[11].xyz * r0.www + cb0[12].xyz;
  r2.xyz = cb0[1].xyz * r2.xyz;
  r1.xyz = r1.xyz * cb0[0].xyz + r2.xyz;
  r2.xyz = r1.xyz * r0.xyz;
  r0.w = max(cb0[20].z, v2.x);
  r0.w = min(cb0[20].w, r0.w);
  r0.w = cb0[21].w * r0.w;
  r0.xyz = -r0.xyz * r1.xyz + cb0[21].xyz;
  r0.xyz = r0.www * r0.xyz + r2.xyz;
  r0.w = max(r0.x, r0.y);
  r1.x = max(0.25, r0.z);
  r0.w = max(r1.x, r0.w);
  r0.w = 1 / r0.w;
  o0.xyz = saturate(r0.xyz * r0.www);
  o0.w = saturate(0.25 * r0.w);
  r0.x = cmp(0 < cb0[22].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[22].y;
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