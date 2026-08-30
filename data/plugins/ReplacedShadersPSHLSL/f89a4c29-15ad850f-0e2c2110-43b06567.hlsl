// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:04 2026
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v3.xy).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.x = (((uint)v9.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r1.x = (int)r1.x + -1;
  r1.x = (int)r1.x;
  r1.yz = float2(0.699999988,0.699999988) * cb0[23].xy;
  r2.xy = v7.xy / v7.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.x = v8.y * r1.x + v7.z;
  r2.z = saturate(r1.x / v7.w);
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
      r3.x = t3.SampleCmpLevelZero(s3_s, r4.yz, r4.w).x;
      r3.w = r3.x + r3.w;
    }
  }
  r1.x = dot(r0.xyz, float3(0.589999974,0.300000012,0.109999999));
  r1.x = 1 + -r1.x;
  r1.x = cmp(r1.x < v1.x);
  r1.y = ~(int)r1.x;
  if (r1.y != 0) discard;
  r1.yz = t1.Sample(s1_s, v3.zw).yw;
  r1.yz = float2(-0.5,-0.5) + r1.zy;
  r1.yz = r1.yz + r1.yz;
  r1.w = -r1.y * r1.y + 1;
  r1.w = -r1.z * r1.z + r1.w;
  r1.w = max(0, r1.w);
  r2.x = cmp(0 < r1.w);
  r2.y = rsqrt(r1.w);
  r1.w = r2.y * r1.w;
  r1.w = r2.x ? r1.w : 0;
  r2.xy = cb0[2].xy * v3.zw;
  r2.xy = t2.Sample(s2_s, r2.xy).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xy = cb0[2].zz * r2.xy;
  r1.yz = r2.xy * float2(2,2) + r1.yz;
  r2.xyz = v4.xyz * r1.zzz;
  r2.xyz = w2.xyz * r1.yyy + r2.xyz;
  r1.yzw = v5.xyz * r1.www + r2.xyz;
  r2.x = dot(r1.yzw, r1.yzw);
  r2.x = rsqrt(r2.x);
  r1.yzw = r2.xxx * r1.yzw;
  r2.x = dot(cb0[17].xyz, r1.yzw);
  r2.y = 1 / cb0[24].x;
  r2.z = r3.w * r2.y;
  r2.y = -r3.w * r2.y + 1;
  r2.w = saturate(v8.x);
  r2.y = r2.y * r2.w + r2.z;
  r2.x = cmp(r2.x < 0);
  r2.x = r2.x ? r2.y : 0;
  r2.y = saturate(dot(-r1.yzw, cb0[17].xyz));
  r2.z = saturate(dot(-r1.yzw, cb0[18].xyz));
  r2.w = saturate(dot(-r1.yzw, cb0[19].xyz));
  r3.xyz = cb0[8].xyz * r2.xxx;
  r4.xyz = cb0[9].xyz * r2.zzz;
  r2.xyz = r3.xyz * r2.yyy + r4.xyz;
  r2.xyz = cb0[10].xyz * r2.www + r2.xyz;
  r1.y = dot(-r1.yzw, cb0[16].xyz);
  r1.yzw = cb0[11].xyz * r1.yyy + cb0[12].xyz;
  r1.yzw = cb0[1].xyz * r1.yzw;
  r1.yzw = r2.xyz * cb0[0].xyz + r1.yzw;
  r2.xyz = r1.yzw * r0.xyz;
  o0.w = r1.x ? r0.w : 0;
  r0.w = max(cb0[20].z, v2.x);
  r0.w = min(cb0[20].w, r0.w);
  r0.w = cb0[21].w * r0.w;
  r0.xyz = -r0.xyz * r1.yzw + cb0[21].xyz;
  o0.xyz = r0.www * r0.xyz + r2.xyz;
  r0.x = cmp(0 < cb0[22].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[22].y;
    r1.zw = float2(0,0);
    r0.y = t5.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  return;
}