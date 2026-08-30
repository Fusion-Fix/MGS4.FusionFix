// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:00 2026
Texture2D<uint4> t5 : register(t5);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[27];
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.x = (((uint)v9.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r0.x = (int)r0.x + -1;
  r0.x = (int)r0.x;
  r1.xyzw = t0.Sample(s0_s, v3.xy).xyzw;
  r0.yz = float2(0.699999988,0.699999988) * cb0[25].xy;
  r2.xy = v7.xy / v7.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.w = v8.y * r0.x + v7.z;
  r2.z = saturate(r0.w / v7.w);
  r0.w = -1 + cb0[26].x;
  r2.w = 360 / r0.w;
  r4.z = 0;
    r3.y = 0;
  r3.z = 0;
  {
    r3.y = 0;
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
      r4.x = r0.y * rotX + r2.x;
      r4.y = r0.z * rotY + r2.y;
      r4.w = r2.z;
      r3.w = t3.SampleCmpLevelZero(s3_s, r4.xy, r4.w).x;
      r3.y = r3.w + r3.y;
    }
  }
  r0.y = v1.w * r1.w;
  r0.z = cmp(0 < cb0[24].x);
  if (r0.z != 0) {
    r2.xy = floor(v0.xy);
    r2.xy = (uint2)r2.xy;
    r4.x = (int)r2.x & 31;
    r4.y = (int)cb0[24].y;
    r4.zw = float2(0,0);
    r0.w = t5.Load(r4.xyz).x;
    r1.w = 1 << (int)r2.y;
    r0.w = (int)r0.w & (int)r1.w;
    r0.w = min(1, (uint)r0.w);
    r0.w = (int)-r0.w + 1;
  }
  r0.z = r0.z ? r0.w : 0;
  if (r0.z != 0) discard;
  r0.z = cmp(cb0[0].x >= 0.501960814);
  r0.w = ~(int)r0.z;
  r1.w = -0.501960814 + cb0[0].x;
  r1.w = cmp(r0.y >= r1.w);
  r0.z = r0.z ? r1.w : 0;
  if (r0.z != 0) discard;
  r0.z = cmp(r0.y < cb0[0].x);
  r0.z = r0.z ? r0.w : 0;
  if (r0.z != 0) discard;
  r0.xzw = v5.xyz * r0.xxx;
  r2.xyz = -cb0[23].xyz + v6.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r3.xzw = r2.xyz * r1.www;
  r2.w = dot(r0.xzw, r0.xzw);
  r2.w = rsqrt(r2.w);
  r0.xzw = r2.www * r0.xzw;
  r2.w = dot(cb0[18].xyz, r0.xzw);
  r4.x = 1 / cb0[26].x;
  r4.y = r4.x * r3.y;
  r3.y = -r3.y * r4.x + 1;
  r4.x = saturate(v8.x);
  r3.y = r3.y * r4.x + r4.y;
  r2.w = cmp(r2.w < 0);
  r2.w = r2.w ? r3.y : 0;
  r3.y = saturate(dot(-r0.xzw, cb0[18].xyz));
  r4.x = saturate(dot(-r0.xzw, cb0[19].xyz));
  r4.y = saturate(dot(-r0.xzw, cb0[20].xyz));
  r5.xyz = cb0[9].xyz * r2.www;
  r4.xzw = cb0[10].xyz * r4.xxx;
  r4.xzw = r5.xyz * r3.yyy + r4.xzw;
  r4.xyz = cb0[11].xyz * r4.yyy + r4.xzw;
  r3.y = dot(-r0.xzw, cb0[17].xyz);
  r5.xyz = cb0[12].xyz * r3.yyy + cb0[13].xyz;
  r5.xyz = cb0[2].xyz * r5.xyz;
  r4.xyz = r4.xyz * cb0[1].xyz + r5.xyz;
  r5.xyz = r2.xyz * r1.www + cb0[18].xyz;
  r3.y = dot(r5.xyz, r5.xyz);
  r3.y = rsqrt(r3.y);
  r5.xyz = r5.xyz * r3.yyy;
  r2.xyz = r2.xyz * r1.www + cb0[19].xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r2.xyz * r1.www;
  r1.w = dot(-v4.xyz, -v4.xyz);
  r1.w = rsqrt(r1.w);
  r6.xyz = -v4.xyz * r1.www;
  r1.w = dot(r5.xyz, r6.xyz);
  r3.y = -r1.w * r1.w + 1;
  r3.y = sqrt(r3.y);
  r1.w = saturate(1 + r1.w);
  r4.w = r1.w * -2 + 3;
  r1.w = r1.w * r1.w;
  r1.w = r4.w * r1.w;
  r3.y = log2(r3.y);
  r3.y = cb0[2].w * r3.y;
  r3.y = exp2(r3.y);
  r1.w = r3.y * r1.w;
  r5.xyz = t1.Sample(s1_s, v3.xy).xyz;
  r7.xyz = r5.xyz * r1.www;
  r7.xyz = v3.zzz * r7.xyz;
  r1.w = r2.w * 0.75 + 0.25;
  r8.xyz = cb0[9].xyz * r1.www;
  r1.w = dot(r2.xyz, r6.xyz);
  r2.x = -r1.w * r1.w + 1;
  r2.x = sqrt(r2.x);
  r1.w = saturate(1 + r1.w);
  r2.y = r1.w * -2 + 3;
  r1.w = r1.w * r1.w;
  r1.w = r2.y * r1.w;
  r2.x = log2(r2.x);
  r2.x = cb0[2].w * r2.x;
  r2.x = exp2(r2.x);
  r1.w = r2.x * r1.w;
  r2.xyz = r1.www * r5.xyz;
  r2.xyz = v3.www * r2.xyz;
  r2.xyz = cb0[10].xyz * r2.xyz;
  r2.xyz = r7.xyz * r8.xyz + r2.xyz;
  r0.x = dot(r0.xzw, r3.xzw);
  r0.x = 1 + -abs(r0.x);
  r0.z = cmp(r0.x < 0.00999999978);
  r0.x = log2(r0.x);
  r0.x = cb0[3].y * r0.x;
  r0.x = exp2(r0.x);
  r0.x = cb0[3].z * r0.x;
  r0.x = cb0[19].w * r0.x;
  r0.x = r0.z ? 0 : r0.x;
  r3.xyz = t2.Sample(s2_s, v3.xy).xyz;
  r0.xzw = r0.xxx * r3.xyz + r1.xyz;
  r0.xzw = r0.xzw * r4.xyz + r2.xyz;
  r1.x = max(cb0[21].z, v2.x);
  r1.x = min(cb0[21].w, r1.x);
  r1.x = cb0[22].w * r1.x;
  r1.yzw = cb0[22].xyz + -r0.xzw;
  o0.xyz = r1.xxx * r1.yzw + r0.xzw;
  o0.w = r0.y;
  return;
}