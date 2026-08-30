// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:58 2026
Texture2D<uint4> t7 : register(t7);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[31];
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.x = (((uint)v10.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r1.x = (int)r1.x + -1;
  r1.x = (int)r1.x;
  r1.yz = float2(0.699999988,0.699999988) * cb0[29].xy;
  r2.xy = v8.xy / v8.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.x = v9.y * r1.x + v8.z;
  r2.z = saturate(r1.x / v8.w);
  r1.x = -1 + cb0[30].x;
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
      r3.x = t5.SampleCmpLevelZero(s5_s, r4.yz, r4.w).x;
      r3.w = r3.x + r3.w;
    }
  }
  r0.w = v1.w * r0.w;
  r0.w = cmp(r0.w < 0.498039216);
  if (r0.w != 0) discard;
  r1.xyzw = t2.Sample(s2_s, w2.xy).xyzw;
  r2.xy = t1.Sample(s1_s, v3.xy).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xy = r2.xy + r2.xy;
  r0.w = -r2.x * r2.x + 1;
  r0.w = -r2.y * r2.y + r0.w;
  r0.w = max(0, r0.w);
  r2.z = cmp(0 < r0.w);
  r2.w = rsqrt(r0.w);
  r0.w = r2.w * r0.w;
  r0.w = r2.z ? r0.w : 0;
  r2.zw = v3.xy * cb0[3].xy + cb0[4].xy;
  r2.zw = t3.Sample(s3_s, r2.zw).yw;
  r2.zw = float2(-0.5,-0.5) + r2.wz;
  r2.zw = cb0[3].zz * r2.zw;
  r2.zw = r2.zw * r1.ww;
  r2.xy = r2.zw * float2(2,2) + r2.xy;
  r2.yzw = v5.xyz * r2.yyy;
  r2.xyz = v4.xyz * r2.xxx + r2.yzw;
  r2.xyz = v6.xyz * r0.www + r2.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(cb0[18].xyz, r2.xyz);
  r1.w = 1 / cb0[30].x;
  r2.w = r3.w * r1.w;
  r1.w = -r3.w * r1.w + 1;
  r3.x = saturate(v9.x);
  r1.w = r1.w * r3.x + r2.w;
  r0.w = cmp(r0.w < 0);
  r0.w = r0.w ? r1.w : 0;
  r3.xyz = -cb0[23].xyz + v7.xyz;
  r1.w = dot(r3.xyz, r3.xyz);
  r1.w = rsqrt(r1.w);
  r4.xyz = r3.xyz * r1.www;
  r2.w = dot(-r2.xyz, cb0[18].xyz);
  r3.w = dot(-r2.xyz, cb0[19].xyz);
  r4.w = saturate(dot(-r2.xyz, cb0[20].xyz));
  r5.xyz = r3.xyz * r1.www + cb0[18].xyz;
  r5.w = dot(r5.xyz, r5.xyz);
  r5.w = rsqrt(r5.w);
  r5.xyz = r5.xyz * r5.www;
  r5.x = saturate(dot(-r2.xyz, r5.xyz));
  r3.xyz = r3.xyz * r1.www + cb0[19].xyz;
  r1.w = dot(r3.xyz, r3.xyz);
  r1.w = rsqrt(r1.w);
  r3.xyz = r3.xyz * r1.www;
  r1.w = saturate(dot(-r2.xyz, r3.xyz));
  r3.x = saturate(r2.w * 5 + 1);
  r3.y = log2(r5.x);
  r3.y = cb0[2].w * r3.y;
  r3.y = exp2(r3.y);
  r3.x = r3.y * r3.x;
  r3.y = saturate(r3.w * 5 + 1);
  r1.w = log2(r1.w);
  r1.w = cb0[2].w * r1.w;
  r1.w = exp2(r1.w);
  r1.w = r1.w * r3.y;
  r5.xyz = cb0[9].xyz * r0.www;
  r2.w = saturate(r2.w);
  r3.w = saturate(r3.w);
  r3.yzw = cb0[10].xyz * r3.www;
  r3.yzw = r5.xyz * r2.www + r3.yzw;
  r3.yzw = cb0[11].xyz * r4.www + r3.yzw;
  r0.w = r0.w * 0.75 + 0.25;
  r5.xyz = cb0[9].xyz * r0.www;
  r6.xyz = cb0[10].xyz * r1.www;
  r5.xyz = r3.xxx * r5.xyz + r6.xyz;
  r0.w = dot(-r2.xyz, cb0[17].xyz);
  r6.xyz = cb0[12].xyz * r0.www + cb0[13].xyz;
  r6.xyz = cb0[2].xyz * r6.xyz;
  r3.xyz = r3.yzw * cb0[1].xyz + r6.xyz;
  r6.xyz = t4.Sample(s4_s, w2.xy).xyz;
  r0.w = dot(r2.xyz, r4.xyz);
  r0.w = 1 + -abs(r0.w);
  r1.w = cmp(r0.w < 0.00999999978);
  r0.w = log2(r0.w);
  r0.w = cb0[4].z * r0.w;
  r0.w = exp2(r0.w);
  r0.w = cb0[4].w * r0.w;
  r0.w = cb0[19].w * r0.w;
  r0.w = r1.w ? 0 : r0.w;
  r0.xyz = r0.www * r6.xyz + r0.xyz;
  r1.xyz = r5.xyz * r1.xyz;
  r0.xyz = r0.xyz * r3.xyz + r1.xyz;
  r1.xyz = float3(-1,-1,-1) + cb0[25].xyz;
  r1.xyz = v1.yyy * r1.xyz + float3(1,1,1);
  r2.xyz = cb0[24].xyz + -r1.xyz;
  r1.xyz = v1.xxx * r2.xyz + r1.xyz;
  r0.w = 1 + -v1.y;
  r0.w = r0.w * v1.x + v1.y;
  r2.xyz = cb0[26].xyz + -r1.xyz;
  r1.xyz = v1.zzz * r2.xyz + r1.xyz;
  r1.w = 1 + -r0.w;
  r0.w = r1.w * v1.z + r0.w;
  r1.xyz = r0.xyz * r1.xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
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
  r0.x = cmp(0 < cb0[28].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r2.x = (int)r0.y & 31;
    r2.y = (int)cb0[28].y;
    r2.zw = float2(0,0);
    r0.y = t7.Load(r2.xyz).x;
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