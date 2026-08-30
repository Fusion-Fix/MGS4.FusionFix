// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:57 2026
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
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD6,
  float4 v7 : TEXCOORD7,
  float4 v8 : TEXCOORD8,
  float4 v9 : TEXCOORD9,
  uint v10 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
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
      r2.x = t7.SampleCmpLevelZero(s7_s, r3.yz, r3.w).x;
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
    r0.y = t9.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = t2.Sample(s2_s, w2.xy).xyzw;
  r2.xy = t1.Sample(s1_s, w2.xy).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xy = r2.xy + r2.xy;
  r3.x = -r2.x * r2.x + 1;
  r3.x = -r2.y * r2.y + r3.x;
  r3.x = max(0, r3.x);
  r3.y = cmp(0 < r3.x);
  r3.z = rsqrt(r3.x);
  r3.x = r3.x * r3.z;
  r2.z = r3.y ? r3.x : 0;
  r3.xyz = max(cb0[3].xyz, v1.xxx);
  r3.xyz = r3.xyz * r1.www;
  r1.xyzw = cb0[5].zwww * r1.wxyz;
  r4.xyz = t4.Sample(s4_s, w2.xy).xyz;
  r4.xyz = r4.xyz * cb0[6].xyz + -r0.xyz;
  r0.xyz = r3.xxx * r4.xyz + r0.xyz;
  r3.xw = t5.Sample(s5_s, w2.xy).yw;
  r3.xw = float2(-0.5,-0.5) + r3.wx;
  r4.xy = r3.xw + r3.xw;
  r3.x = -r4.x * r4.x + 1;
  r3.x = -r4.y * r4.y + r3.x;
  r3.x = max(0, r3.x);
  r3.w = cmp(0 < r3.x);
  r4.w = rsqrt(r3.x);
  r3.x = r4.w * r3.x;
  r4.z = r3.w ? r3.x : 0;
  r4.xyz = r4.xyz + -r2.xyz;
  r2.xyz = r3.yyy * r4.xyz + r2.xyz;
  r3.xy = cb0[5].xy + v3.xy;
  r3.xy = t6.Sample(s6_s, r3.xy).yw;
  r3.xy = float2(-0.5,-0.5) + r3.yx;
  r3.xy = r3.xy * r1.xx;
  r2.xy = r3.xy * float2(2,2) + r2.xy;
  r1.x = dot(r2.xyz, r2.xyz);
  r1.x = rsqrt(r1.x);
  r2.xyz = r2.xyz * r1.xxx;
  r1.x = cb0[2].z + -cb0[1].w;
  r1.x = r3.z * r1.x + cb0[1].w;
  r3.xy = cb0[4].xy + -cb0[2].xy;
  r3.xy = r3.zz * r3.xy + cb0[2].xy;
  r4.xyz = v5.xyz * r2.yyy;
  r4.xyz = v4.xyz * r2.xxx + r4.xyz;
  r2.xyz = v6.xyz * r2.zzz + r4.xyz;
  r3.z = dot(r2.xyz, r2.xyz);
  r3.z = rsqrt(r3.z);
  r2.xyz = r3.zzz * r2.xyz;
  r3.z = dot(cb0[17].xyz, r2.xyz);
  r3.w = 1 / cb0[25].x;
  r4.x = r3.w * r2.w;
  r2.w = -r2.w * r3.w + 1;
  r3.w = saturate(v9.x);
  r2.w = r2.w * r3.w + r4.x;
  r3.z = cmp(r3.z < 0);
  r2.w = r3.z ? r2.w : 0;
  r4.xyz = -cb0[22].xyz + v7.xyz;
  r3.z = dot(r4.xyz, r4.xyz);
  r3.z = rsqrt(r3.z);
  r5.xyz = r4.xyz * r3.zzz;
  r3.w = dot(-r2.xyz, cb0[17].xyz);
  r4.w = dot(-r2.xyz, cb0[18].xyz);
  r5.w = saturate(dot(-r2.xyz, cb0[19].xyz));
  r6.xyz = r4.xyz * r3.zzz + cb0[17].xyz;
  r6.w = dot(r6.xyz, r6.xyz);
  r6.w = rsqrt(r6.w);
  r6.xyz = r6.xyz * r6.www;
  r6.x = saturate(dot(-r2.xyz, r6.xyz));
  r4.xyz = r4.xyz * r3.zzz + cb0[18].xyz;
  r3.z = dot(r4.xyz, r4.xyz);
  r3.z = rsqrt(r3.z);
  r4.xyz = r4.xyz * r3.zzz;
  r3.z = saturate(dot(-r2.xyz, r4.xyz));
  r4.x = saturate(r3.w * 5 + 1);
  r4.y = log2(r6.x);
  r4.y = r4.y * r1.x;
  r4.y = exp2(r4.y);
  r4.x = r4.y * r4.x;
  r4.y = saturate(r4.w * 5 + 1);
  r3.z = log2(r3.z);
  r1.x = r3.z * r1.x;
  r1.x = exp2(r1.x);
  r1.x = r1.x * r4.y;
  r6.xyz = cb0[8].xyz * r2.www;
  r3.w = saturate(r3.w);
  r4.w = saturate(r4.w);
  r4.yzw = cb0[9].xyz * r4.www;
  r4.yzw = r6.xyz * r3.www + r4.yzw;
  r4.yzw = cb0[10].xyz * r5.www + r4.yzw;
  r2.w = r2.w * 0.75 + 0.25;
  r6.xyz = cb0[8].xyz * r2.www;
  r7.xyz = cb0[9].xyz * r1.xxx;
  r6.xyz = r4.xxx * r6.xyz + r7.xyz;
  r1.x = dot(-r2.xyz, cb0[16].xyz);
  r7.xyz = cb0[11].xyz * r1.xxx + cb0[12].xyz;
  r7.xyz = cb0[1].xyz * r7.xyz;
  r4.xyz = r4.yzw * cb0[0].xyz + r7.xyz;
  r7.xyz = t3.Sample(s3_s, w2.xy).xyz;
  r1.x = dot(r2.xyz, r5.xyz);
  r1.x = 1 + -abs(r1.x);
  r2.x = cmp(r1.x < 0.00999999978);
  r1.x = log2(r1.x);
  r1.x = r3.x * r1.x;
  r1.x = exp2(r1.x);
  r1.x = r1.x * r3.y;
  r1.x = cb0[18].w * r1.x;
  r1.x = r2.x ? 0 : r1.x;
  r0.xyz = r1.xxx * r7.xyz + r0.xyz;
  r1.xyz = r6.xyz * r1.yzw;
  r0.xyz = r0.xyz * r4.xyz + r1.xyz;
  r1.x = max(cb0[20].z, v2.x);
  r1.x = min(cb0[20].w, r1.x);
  r1.x = cb0[21].w * r1.x;
  r1.yzw = cb0[21].xyz + -r0.xyz;
  o0.xyz = r1.xxx * r1.yzw + r0.xyz;
  o0.w = v1.w * r0.w;
  return;
}