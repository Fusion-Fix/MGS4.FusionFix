// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:54 2026
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
  float4 cb0[16];
}




// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);


void main( 
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float3 v2 : COLOR1,
  float w2 : COLOR2,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD2,
  float4 v6 : TEXCOORD3,
  float4 v7 : TEXCOORD4,
  float4 v8 : TEXCOORD5,
  float4 v9 : TEXCOORD6,
  float4 v10 : TEXCOORD8,
  float4 v11 : TEXCOORD9,
  uint v12 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v3.xy).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.x = (((uint)v12.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r1.x = (int)r1.x + -1;
  r1.x = (int)r1.x;
  r1.yz = float2(0.699999988,0.699999988) * cb0[14].xy;
  r2.xy = v10.xy / v10.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.x = v11.y * r1.x + v10.z;
  r2.z = saturate(r1.x / v10.w);
  r1.x = -1 + cb0[15].x;
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
  r0.w = v1.w * r0.w;
  r1.x = cmp(r0.w < cb0[0].x);
  if (r1.x != 0) discard;
  r1.xyzw = t2.Sample(s2_s, v4.zw).xyzw;
  r1.xyz = v1.www * r1.xyz;
  r0.xyz = r1.xyz * r1.www + r0.xyz;
  r0.xyz = cb0[1].xyz * r0.xyz;
  r1.xyz = float3(4,4,4) * v2.xyz;
  r2.xy = t1.Sample(s1_s, v3.zw).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xy = r2.xy + r2.xy;
  r1.w = -r2.x * r2.x + 1;
  r1.w = -r2.y * r2.y + r1.w;
  r1.w = max(0, r1.w);
  r2.w = cmp(0 < r1.w);
  r3.x = rsqrt(r1.w);
  r1.w = r3.x * r1.w;
  r2.z = r2.w ? r1.w : 0;
  r3.xyz = v8.xyz * r2.yyy;
  r3.xyz = v7.xyz * r2.xxx + r3.xyz;
  r3.xyz = v9.xyz * r2.zzz + r3.xyz;
  r1.w = dot(r3.xyz, r3.xyz);
  r1.w = rsqrt(r1.w);
  r3.xyz = r3.xyz * r1.www;
  r4.x = saturate(dot(r2.xyz, float3(0.707099974,-0.408199996,0.577400029)));
  r4.y = saturate(dot(r2.xyz, float3(-0.707099974,-0.408199996,0.577400029)));
  r4.z = saturate(dot(r2.yz, float2(0.816500008,0.577400029)));
  r2.xyz = r4.xyz * r4.xyz;
  r4.xyz = v6.xyz * r2.yyy;
  r2.xyw = v5.xyz * r2.xxx + r4.xyz;
  r1.xyz = r1.xyz * r2.zzz + r2.xyw;
  r1.xyz = v1.xyz * float3(2,2,2) + r1.xyz;
  r1.w = dot(cb0[10].xyz, r3.xyz);
  r2.x = 1 / cb0[15].x;
  r2.y = r3.w * r2.x;
  r2.x = -r3.w * r2.x + 1;
  r2.z = saturate(v11.x);
  r2.x = r2.x * r2.z + r2.y;
  r1.w = cmp(r1.w < 0);
  r1.w = r1.w ? r2.x : 0;
  r2.x = saturate(dot(-cb0[10].xyz, r3.xyz));
  r2.yzw = cb0[9].xyz * r1.www;
  r1.xyz = r2.yzw * r2.xxx + r1.xyz;
  r2.xyz = r1.xyz * r0.xyz;
  r1.w = max(cb0[11].z, w2.x);
  r1.w = min(cb0[11].w, r1.w);
  r1.w = cb0[12].w * r1.w;
  r0.xyz = -r0.xyz * r1.xyz + cb0[12].xyz;
  o0.xyz = r1.www * r0.xyz + r2.xyz;
  r0.x = cmp(0 < cb0[13].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[13].y;
    r1.zw = float2(0,0);
    r0.y = t5.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  o0.w = r0.w;
  return;
}