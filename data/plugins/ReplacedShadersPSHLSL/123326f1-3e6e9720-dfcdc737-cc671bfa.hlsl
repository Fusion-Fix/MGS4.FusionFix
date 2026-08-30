// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:00 2026
Texture2D<uint4> t10 : register(t10);

Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s8_s : register(s8);

SamplerState s7_s : register(s7);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[26];
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
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD6,
  float4 v7 : TEXCOORD7,
  float4 v8 : TEXCOORD8,
  float4 v9 : TEXCOORD9,
  uint v10 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.x = (((uint)v10.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r0.x = (int)r0.x + -1;
  r0.x = (int)r0.x;
  r0.yz = float2(0.699999988,0.699999988) * cb0[24].xy;
  r1.xy = v8.xy / v8.ww;
  r1.xy = r1.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.x = v9.y * r0.x + v8.z;
  r1.z = saturate(r0.x / v8.w);
  r0.x = -1 + cb0[25].x;
  r0.w = 360 / r0.x;
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
      r3.y = r0.y * rotX + r1.x;
      r3.z = r0.z * rotY + r1.y;
      r3.w = r1.z;
      r2.x = t8.SampleCmpLevelZero(s8_s, r3.yz, r3.w).x;
      r2.w = r2.x + r2.w;
    }
  }
  r0.x = cmp(0 < cb0[23].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[23].y;
    r1.zw = float2(0,0);
    r0.y = t10.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  r0.xyz = -cb0[22].xyz + v7.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = r0.xyz * r0.www;
  r3.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r2.xyz = t4.Sample(s4_s, v3.xy).xyz;
  r4.xyz = t2.Sample(s2_s, w2.xy).xyz;
  r5.xy = t1.Sample(s1_s, w2.xy).yw;
  r5.xy = float2(-0.5,-0.5) + r5.yx;
  r5.xy = r5.xy + r5.xy;
  r1.w = -r5.x * r5.x + 1;
  r1.w = -r5.y * r5.y + r1.w;
  r1.w = max(0, r1.w);
  r4.w = cmp(0 < r1.w);
  r5.z = rsqrt(r1.w);
  r1.w = r5.z * r1.w;
  r1.w = r4.w ? r1.w : 0;
  r5.zw = t5.Sample(s5_s, v3.xy).yw;
  r5.zw = float2(-0.5,-0.5) + r5.wz;
  r5.zw = r5.zw + r5.zw;
  r4.w = t7.Sample(s7_s, w2.xy).y;
  r4.w = cb0[2].w * r4.w;
  r5.xy = r5.zw * r4.ww + r5.xy;
  r5.yzw = v5.xyz * r5.yyy;
  r5.xyz = v4.xyz * r5.xxx + r5.yzw;
  r5.xyz = v6.xyz * r1.www + r5.xyz;
  r1.w = dot(r5.xyz, r5.xyz);
  r1.w = rsqrt(r1.w);
  r5.xyz = r5.xyz * r1.www;
  r1.w = dot(cb0[17].xyz, r5.xyz);
  r5.w = 1 / cb0[25].x;
  r6.x = r5.w * r2.w;
  r2.w = -r2.w * r5.w + 1;
  r5.w = saturate(v9.x);
  r2.w = r2.w * r5.w + r6.x;
  r1.w = cmp(r1.w < 0);
  r1.w = r1.w ? r2.w : 0;
  r2.w = saturate(dot(-r5.xyz, cb0[17].xyz));
  r5.w = saturate(dot(-r5.xyz, cb0[18].xyz));
  r6.x = saturate(dot(-r5.xyz, cb0[19].xyz));
  r6.yzw = cb0[8].xyz * r1.www;
  r7.xyz = cb0[9].xyz * r5.www;
  r6.yzw = r6.yzw * r2.www + r7.xyz;
  r6.xyz = cb0[10].xyz * r6.xxx + r6.yzw;
  r2.w = dot(-r5.xyz, cb0[16].xyz);
  r7.xyz = cb0[11].xyz * r2.www + cb0[12].xyz;
  r7.xyz = cb0[1].xyz * r7.xyz;
  r6.xyz = r6.xyz * cb0[0].xyz + r7.xyz;
  r7.xyz = float3(-1,-1,-1) + cb0[3].xyz;
  r7.xyz = r4.www * r7.xyz + float3(1,1,1);
  r2.w = cb0[3].w + -cb0[1].w;
  r2.w = r4.w * r2.w + cb0[1].w;
  r5.w = dot(r5.xyz, -cb0[17].xyz);
  r8.xyz = r0.xyz * r0.www + cb0[17].xyz;
  r6.w = dot(r8.xyz, r8.xyz);
  r6.w = rsqrt(r6.w);
  r8.xyz = r8.xyz * r6.www;
  r6.w = saturate(dot(-r5.xyz, r8.xyz));
  r5.w = saturate(r5.w * 5 + 1);
  r6.w = log2(r6.w);
  r6.w = r6.w * r2.w;
  r6.w = exp2(r6.w);
  r5.w = r6.w * r5.w;
  r6.w = dot(r5.xyz, -cb0[18].xyz);
  r0.xyz = r0.xyz * r0.www + cb0[18].xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.x = saturate(dot(-r5.xyz, r0.xyz));
  r0.y = saturate(r6.w * 5 + 1);
  r0.x = log2(r0.x);
  r0.x = r2.w * r0.x;
  r0.x = exp2(r0.x);
  r0.x = r0.x * r0.y;
  r0.yzw = r2.xyz * cb0[2].xyz + -r3.xyz;
  r0.yzw = r4.www * r0.yzw + r3.xyz;
  r1.x = dot(r5.xyz, r1.xyz);
  r1.x = 1 + -abs(r1.x);
  r1.y = cmp(r1.x < 0.00999999978);
  r1.x = log2(r1.x);
  r1.x = cb0[4].z * r1.x;
  r1.x = exp2(r1.x);
  r1.x = cb0[4].w * r1.x;
  r1.x = cb0[18].w * r1.x;
  r1.x = r1.y ? 0 : r1.x;
  r2.xyz = t6.Sample(s6_s, w2.xy).xyz;
  r0.yzw = r1.xxx * r2.xyz + r0.yzw;
  r2.x = r5.w * 0.939999998 + 0.0500000007;
  r2.yw = float2(0.5,0.5);
  r1.xyz = t3.Sample(s3_s, r2.xy).xyz;
  r1.w = r1.w * 0.75 + 0.25;
  r3.xyz = cb0[8].xyz * r1.www;
  r3.xyz = r4.xyz * r3.xyz;
  r1.xyz = r3.xyz * r1.xyz;
  r1.xyz = max(float3(0,0,0), r1.xyz);
  r1.xyz = r1.xyz * r7.xyz;
  r0.yzw = r0.yzw * r6.xyz + r1.xyz;
  r2.z = r0.x * 0.939999998 + 0.0500000007;
  r1.xyz = t3.Sample(s3_s, r2.zw).xyz;
  r2.xyz = cb0[9].xyz * r4.xyz;
  r1.xyz = r2.xyz * r1.xyz;
  r1.xyz = max(float3(0,0,0), r1.xyz);
  r0.xyz = r1.xyz * r7.xyz + r0.yzw;
  o0.w = v1.w * r3.w;
  r0.w = max(cb0[20].z, v2.x);
  r0.w = min(cb0[20].w, r0.w);
  r0.w = cb0[21].w * r0.w;
  r1.xyz = cb0[21].xyz + -r0.xyz;
  o0.xyz = r0.www * r1.xyz + r0.xyz;
  return;
}