// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:42 2026
Texture2D<uint4> t9 : register(t9);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s7_s : register(s7);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

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

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.x = (((uint)v9.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r1.x = (int)r1.x + -1;
  r1.x = (int)r1.x;
  r1.yz = float2(0.699999988,0.699999988) * cb0[25].xy;
  r2.xy = v7.xy / v7.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.x = v8.y * r1.x + v7.z;
  r2.z = saturate(r1.x / v7.w);
  r1.x = -1 + cb0[26].x;
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
      r3.x = t7.SampleCmpLevelZero(s7_s, r4.yz, r4.w).x;
      r3.w = r3.x + r3.w;
    }
  }
  r0.w = v1.w * r0.w;
  r0.w = cmp(r0.w < 0.498039216);
  if (r0.w != 0) discard;
  r1.xyz = t2.Sample(s2_s, w2.xy).xyz;
  r2.xy = t1.Sample(s1_s, w2.xy).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xy = r2.xy + r2.xy;
  r2.zw = t4.Sample(s4_s, w2.xy).yw;
  r2.zw = float2(-0.5,-0.5) + r2.wz;
  r2.zw = r2.zw * float2(2,2) + -r2.xy;
  r2.xy = cb0[3].zz * r2.zw + r2.xy;
  r0.w = -r2.x * r2.x + 1;
  r0.w = -r2.y * r2.y + r0.w;
  r0.w = max(0, r0.w);
  r1.w = cmp(0 < r0.w);
  r2.z = rsqrt(r0.w);
  r0.w = r2.z * r0.w;
  r0.w = r1.w ? r0.w : 0;
  r1.w = t6.Sample(s6_s, w2.xy).y;
  r1.w = cb0[5].w * r1.w;
  r3.xyz = cb0[5].xyz + -r0.xyz;
  r0.xyz = r1.www * r3.xyz + r0.xyz;
  r2.yzw = v4.xyz * r2.yyy;
  r2.xyz = v3.xyz * r2.xxx + r2.yzw;
  r2.xyz = v5.xyz * r0.www + r2.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(cb0[18].xyz, r2.xyz);
  r2.w = 1 / cb0[26].x;
  r3.x = r3.w * r2.w;
  r2.w = -r3.w * r2.w + 1;
  r3.y = saturate(v8.x);
  r2.w = r2.w * r3.y + r3.x;
  r0.w = cmp(r0.w < 0);
  r0.w = r0.w ? r2.w : 0;
  r3.xyz = -cb0[23].xyz + v6.xyz;
  r2.w = dot(r3.xyz, r3.xyz);
  r2.w = rsqrt(r2.w);
  r4.xyz = r3.xyz * r2.www;
  r3.w = dot(-r2.xyz, cb0[18].xyz);
  r4.w = dot(-r2.xyz, cb0[19].xyz);
  r5.x = saturate(dot(-r2.xyz, cb0[20].xyz));
  r5.yzw = r3.xyz * r2.www + cb0[18].xyz;
  r6.x = dot(r5.yzw, r5.yzw);
  r6.x = rsqrt(r6.x);
  r5.yzw = r6.xxx * r5.yzw;
  r5.y = saturate(dot(-r2.xyz, r5.yzw));
  r3.xyz = r3.xyz * r2.www + cb0[19].xyz;
  r2.w = dot(r3.xyz, r3.xyz);
  r2.w = rsqrt(r2.w);
  r3.xyz = r3.xyz * r2.www;
  r2.w = saturate(dot(-r2.xyz, r3.xyz));
  r3.x = saturate(r3.w * 5 + 1);
  r3.y = log2(r5.y);
  r3.z = cb0[2].w * r3.y;
  r3.z = exp2(r3.z);
  r3.x = r3.z * r3.x;
  r3.z = saturate(r4.w * 5 + 1);
  r2.w = log2(r2.w);
  r5.y = cb0[2].w * r2.w;
  r5.y = exp2(r5.y);
  r3.z = r5.y * r3.z;
  r5.yzw = cb0[9].xyz * r0.www;
  r3.w = saturate(r3.w);
  r4.w = saturate(r4.w);
  r6.xyz = cb0[10].xyz * r4.www;
  r5.yzw = r5.yzw * r3.www + r6.xyz;
  r5.xyz = cb0[11].xyz * r5.xxx + r5.yzw;
  r0.w = r0.w * 0.75 + 0.25;
  r6.xyz = cb0[9].xyz * r0.www;
  r7.xyz = cb0[10].xyz * r3.zzz;
  r3.xzw = r3.xxx * r6.xyz + r7.xyz;
  r0.w = dot(-r2.xyz, cb0[17].xyz);
  r7.xyz = cb0[12].xyz * r0.www + cb0[13].xyz;
  r7.xyz = cb0[2].xyz * r7.xyz;
  r5.xyz = r5.xyz * cb0[1].xyz + r7.xyz;
  r7.xyz = t3.Sample(s3_s, w2.xy).xyz;
  r0.w = dot(r2.xyz, r4.xyz);
  r0.w = 1 + -abs(r0.w);
  r4.x = cmp(r0.w < 0.00999999978);
  r0.w = log2(r0.w);
  r0.w = cb0[3].x * r0.w;
  r0.w = exp2(r0.w);
  r0.w = cb0[3].y * r0.w;
  r0.w = cb0[19].w * r0.w;
  r0.w = r4.x ? 0 : r0.w;
  r0.xyz = r0.www * r7.xyz + r0.xyz;
  r3.xzw = r3.xzw * r1.xyz;
  r3.xzw = r1.www * -r3.xzw + r3.xzw;
  r0.xyz = r0.xyz * r5.xyz + r3.xzw;
  r0.w = dot(r2.xyz, -cb0[18].xyz);
  r0.w = saturate(r0.w * 5 + 1);
  r3.x = cb0[4].w * r3.y;
  r3.x = exp2(r3.x);
  r0.w = r3.x * r0.w;
  r3.x = r0.w * 0.939999998 + 0.0500000007;
  r3.yw = float2(0.5,0.5);
  r4.xyz = t5.Sample(s5_s, r3.xy).xyz;
  r5.xyz = r6.xyz * r1.xyz;
  r4.xyz = r5.xyz * r4.xyz;
  r4.xyz = max(float3(0,0,0), r4.xyz);
  r4.xyz = cb0[4].xyz * r4.xyz;
  r0.xyz = r1.www * r4.xyz + r0.xyz;
  r0.w = dot(r2.xyz, -cb0[19].xyz);
  r0.w = saturate(r0.w * 5 + 1);
  r2.x = cb0[4].w * r2.w;
  r2.x = exp2(r2.x);
  r0.w = r2.x * r0.w;
  r3.z = r0.w * 0.939999998 + 0.0500000007;
  r2.xyz = t5.Sample(s5_s, r3.zw).xyz;
  r1.xyz = cb0[10].xyz * r1.xyz;
  r1.xyz = r2.xyz * r1.xyz;
  r1.xyz = max(float3(0,0,0), r1.xyz);
  r1.xyz = cb0[4].xyz * r1.xyz;
  r0.xyz = r1.www * r1.xyz + r0.xyz;
  r0.w = max(cb0[21].z, v2.x);
  r0.w = min(cb0[21].w, r0.w);
  r0.w = cb0[22].w * r0.w;
  r1.xyz = cb0[22].xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
  r0.w = max(r0.x, r0.y);
  r1.x = max(0.25, r0.z);
  r0.w = max(r1.x, r0.w);
  r0.w = 1 / r0.w;
  r1.xyz = saturate(r0.xyz * r0.www);
  r1.w = saturate(0.25 * r0.w);
  o0.xyzw = r1.xyzw;
  r0.x = cmp(0 < cb0[24].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r2.x = (int)r0.y & 31;
    r2.y = (int)cb0[24].y;
    r2.zw = float2(0,0);
    r0.y = t9.Load(r2.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  r0.x = cmp(cb0[0].x >= 0.501960814);
  r0.y = ~(int)r0.x;
  r0.z = -0.501960814 + cb0[0].x;
  r0.z = cmp(r1.w >= r0.z);
  r0.x = r0.z ? r0.x : 0;
  if (r0.x != 0) discard;
  r0.x = cmp(r1.w < cb0[0].x);
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  return;
}