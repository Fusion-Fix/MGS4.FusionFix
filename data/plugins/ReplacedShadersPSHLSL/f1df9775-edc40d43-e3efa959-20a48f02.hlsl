// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:00 2026
Texture2D<uint4> t6 : register(t6);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s4_s : register(s4);

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
      r2.x = t4.SampleCmpLevelZero(s4_s, r3.yz, r3.w).x;
      r2.w = r2.x + r2.w;
    }
  }
  r0.x = cmp(v1.w < 0.498039216);
  if (r0.x != 0) discard;
  r0.xyz = -cb0[22].xyz + v7.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r2.xyz = t2.Sample(s2_s, w2.xy).xyz;
  r3.xy = t1.Sample(s1_s, w2.xy).yw;
  r3.xy = float2(-0.5,-0.5) + r3.yx;
  r3.xy = r3.xy + r3.xy;
  r3.z = -r3.x * r3.x + 1;
  r3.z = -r3.y * r3.y + r3.z;
  r3.z = max(0, r3.z);
  r3.w = cmp(0 < r3.z);
  r4.x = rsqrt(r3.z);
  r3.z = r4.x * r3.z;
  r3.z = r3.w ? r3.z : 0;
  r4.xyz = v5.xyz * r3.yyy;
  r3.xyw = v4.xyz * r3.xxx + r4.xyz;
  r3.xyz = v6.xyz * r3.zzz + r3.xyw;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r3.w = dot(cb0[17].xyz, r3.xyz);
  r4.x = 1 / cb0[25].x;
  r4.y = r4.x * r2.w;
  r2.w = -r2.w * r4.x + 1;
  r4.x = saturate(v9.x);
  r2.w = r2.w * r4.x + r4.y;
  r3.w = cmp(r3.w < 0);
  r2.w = r3.w ? r2.w : 0;
  r3.w = dot(-r3.xyz, cb0[17].xyz);
  r4.x = dot(-r3.xyz, cb0[18].xyz);
  r4.y = saturate(dot(-r3.xyz, cb0[19].xyz));
  r5.xyz = r0.xyz * r0.www + cb0[17].xyz;
  r4.z = dot(r5.xyz, r5.xyz);
  r4.z = rsqrt(r4.z);
  r5.xyz = r5.xyz * r4.zzz;
  r4.z = saturate(dot(-r3.xyz, r5.xyz));
  r0.xyz = r0.xyz * r0.www + cb0[18].xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.x = saturate(dot(-r3.xyz, r0.xyz));
  r0.y = saturate(r3.w * 5 + 1);
  r0.z = log2(r4.z);
  r0.z = cb0[1].w * r0.z;
  r0.z = exp2(r0.z);
  r0.y = r0.z * r0.y;
  r0.z = saturate(r4.x * 5 + 1);
  r0.x = log2(r0.x);
  r0.x = cb0[1].w * r0.x;
  r0.x = exp2(r0.x);
  r0.x = r0.x * r0.z;
  r5.xyz = cb0[8].xyz * r2.www;
  r3.w = saturate(r3.w);
  r4.x = saturate(r4.x);
  r4.xzw = cb0[9].xyz * r4.xxx;
  r4.xzw = r5.xyz * r3.www + r4.xzw;
  r4.xyz = cb0[10].xyz * r4.yyy + r4.xzw;
  r0.z = r2.w * 0.75 + 0.25;
  r6.xyz = cb0[8].xyz * r0.zzz;
  r0.xzw = cb0[9].xyz * r0.xxx;
  r0.xyz = r0.yyy * r6.xyz + r0.xzw;
  r0.w = dot(-r3.xyz, cb0[16].xyz);
  r6.xyz = cb0[11].xyz * r0.www + cb0[12].xyz;
  r7.xyz = cb0[1].xyz * r6.xyz;
  r4.xyz = r4.xyz * cb0[0].xyz + r7.xyz;
  r0.w = saturate(dot(r3.xyz, -cb0[17].xyz));
  r2.w = saturate(dot(r3.xyz, -cb0[18].xyz));
  r3.x = saturate(dot(r3.xyz, -cb0[19].xyz));
  r3.yzw = cb0[9].xyz * r2.www;
  r3.yzw = r5.xyz * r0.www + r3.yzw;
  r3.xyz = cb0[10].xyz * r3.xxx + r3.yzw;
  r3.xyz = r3.xyz + r6.xyz;
  r5.xyz = t3.Sample(s3_s, v3.xy).xyz;
  r3.xyz = cb0[2].xyz * r3.xyz;
  r3.xyz = r3.xyz * r1.www;
  r3.xyz = r5.xyz * r3.xyz;
  r0.xyz = r2.xyz * r0.xyz;
  r0.xyz = max(r0.xyz, r3.xyz);
  r0.xyz = r1.xyz * r4.xyz + r0.xyz;
  r0.w = max(cb0[20].z, v2.x);
  r0.w = min(cb0[20].w, r0.w);
  r0.w = cb0[21].w * r0.w;
  r1.xyz = cb0[21].xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
  r0.w = max(r0.x, r0.y);
  r1.x = max(0.25, r0.z);
  r0.w = max(r1.x, r0.w);
  r0.w = 1 / r0.w;
  o0.xyz = saturate(r0.xyz * r0.www);
  o0.w = saturate(0.25 * r0.w);
  r0.x = cmp(0 < cb0[23].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[23].y;
    r1.zw = float2(0,0);
    r0.y = t6.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  return;
}