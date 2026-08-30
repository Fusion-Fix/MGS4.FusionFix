// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:57 2026
Texture2D<uint4> t4 : register(t4);

Texture2D<float4> t2 : register(t2);

TextureCube<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[15];
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

  r0.x = dot(v6.xyz, v6.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v6.xyz * r0.xxx;
  r1.xyz = t0.Sample(s0_s, w2.xy).xyz;
  r0.w = dot(v5.xyz, v5.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = v5.xyz * r0.www;
  bitmask.w = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.w = (((uint)v9.x << 1) & bitmask.w) | ((uint)0 & ~bitmask.w);
  r0.w = (int)r0.w + -1;
  r0.w = (int)r0.w;
  r1.w = dot(cb0[9].xyz, r2.xyz);
  r3.xy = float2(0.699999988,0.699999988) * cb0[13].xy;
  r3.zw = v7.xy / v7.ww;
  r4.xy = r3.zw * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.w = v8.y * r0.w + v7.z;
  r4.z = saturate(r0.w / v7.w);
  r0.w = -1 + cb0[14].x;
  r2.w = 360 / r0.w;
  r5.z = 0;
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
      sincos(spiralTheta, r6.x, r7.x);
      r5.x = r7.x * spiralR;
      r5.y = r6.x * spiralR;
      rotX = ign_cos * r5.x - ign_sin * r5.y;
      rotY = ign_sin * r5.x + ign_cos * r5.y;
      r5.x = r3.x * rotX + r4.x;
      r5.y = r3.y * rotY + r4.y;
      r5.w = r4.z;
      r5.x = t2.SampleCmpLevelZero(s2_s, r5.xy, r5.w).x;
      r3.w = r5.x + r3.w;
    }
  }
  r0.w = 1 / cb0[14].x;
  r2.w = r3.w * r0.w;
  r0.w = -r3.w * r0.w + 1;
  r3.x = saturate(v8.x);
  r0.w = r0.w * r3.x + r2.w;
  r1.w = cmp(r1.w < 0);
  r0.w = r1.w ? r0.w : 0;
  r1.w = saturate(dot(-cb0[9].xyz, r2.xyz));
  r3.xyz = cb0[8].xyz * r0.www;
  r3.xyz = r3.xyz * r1.www;
  r4.xyz = v1.xyz + v1.xyz;
  r3.xyz = r3.xyz * cb0[0].xyz + r4.xyz;
  r4.xyz = r2.xyz + r2.xyz;
  r0.w = dot(-r2.xyz, r0.xyz);
  r0.xyz = r4.xyz * r0.www + r0.xyz;
  r0.xyz = t1.Sample(s1_s, r0.xyz).xyz;
  r0.xyz = r0.xyz + r0.xyz;
  r2.xyz = r3.xyz * r0.xyz;
  r1.xyz = r2.xyz * r1.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r0.w = 0.57735002 * r0.w;
  r0.w = min(1, r0.w);
  r1.x = max(cb0[2].w, r0.w);
  r1.x = v1.w * r1.x;
  r1.x = cmp(r1.x < 0.498039216);
  if (r1.x != 0) discard;
  r0.xyz = cb0[2].xyz * r0.xyz;
  r1.xyz = float3(0.00999999978,0.00999999978,0.00999999978) + r3.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r1.xyz = saturate(r1.xyz * r1.www);
  r0.xyz = r1.xyz * r0.xyz;
  r1.xyz = float3(1.73204994,1.73204994,1.73204994) * r0.xyz;
  r2.xyz = cb0[1].xyz * r3.xyz;
  r3.xyz = r0.xyz * float3(1.73204994,1.73204994,1.73204994) + -r2.xyz;
  r2.xyz = r0.www * r3.xyz + r2.xyz;
  r0.xyz = -r0.xyz * float3(1.73204994,1.73204994,1.73204994) + r2.xyz;
  r0.xyz = cb0[1].www * r0.xyz + r1.xyz;
  r0.w = max(cb0[10].z, v2.x);
  r0.w = min(cb0[10].w, r0.w);
  r0.w = cb0[11].w * r0.w;
  r1.xyz = cb0[11].xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
  r0.w = max(r0.x, r0.y);
  r1.x = max(0.25, r0.z);
  r0.w = max(r1.x, r0.w);
  r0.w = 1 / r0.w;
  o0.xyz = saturate(r0.xyz * r0.www);
  o0.w = saturate(0.25 * r0.w);
  r0.x = cmp(0 < cb0[12].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[12].y;
    r1.zw = float2(0,0);
    r0.y = t4.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  return;
}