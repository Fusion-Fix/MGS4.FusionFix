// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:57 2026
Texture2D<uint4> t9 : register(t9);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

TextureCube<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerComparisonState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[14];
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
  float4 v10 : TEXCOORD7,
  float4 v11 : TEXCOORD8,
  float4 v12 : TEXCOORD9,
  uint v13 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.x = (((uint)v13.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r0.x = (int)r0.x + -1;
  r0.x = (int)r0.x;
  r0.yz = float2(0.699999988,0.699999988) * cb0[12].xy;
  r1.xy = v11.xy / v11.ww;
  r1.xy = r1.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.x = v12.y * r0.x + v11.z;
  r1.z = saturate(r0.x / v11.w);
  r0.x = -1 + cb0[13].x;
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
      r2.x = t6.SampleCmpLevelZero(s6_s, r3.yz, r3.w).x;
      r2.w = r2.x + r2.w;
    }
  }
  r0.x = cmp(0 < cb0[10].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[10].y;
    r1.zw = float2(0,0);
    r0.y = t9.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  r0.x = dot(v10.xyz, v10.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v10.xyz * r0.xxx;
  r1.xyzw = t0.Sample(s0_s, v3.xy).xyzw;
  r1.xyz = cb0[0].xyz * r1.xyz;
  r2.xyz = t2.Sample(s2_s, v4.xy).xyz;
  r2.xyz = cb0[1].xyz * r2.xyz;
  r3.xyzw = cb0[2].xyzw + v3.zwzw;
  r3.xy = t1.Sample(s1_s, r3.xy).yw;
  r3.xy = float2(-0.5,-0.5) + r3.yx;
  r4.xy = r3.xy + r3.xy;
  r0.w = -r4.x * r4.x + 1;
  r0.w = -r4.y * r4.y + r0.w;
  r0.w = max(0, r0.w);
  r3.x = cmp(0 < r0.w);
  r3.y = rsqrt(r0.w);
  r0.w = r3.y * r0.w;
  r4.z = r3.x ? r0.w : 0;
  r3.xy = t3.Sample(s3_s, r3.zw).yw;
  r3.xy = float2(-0.5,-0.5) + r3.yx;
  r3.xy = r3.xy + r3.xy;
  r0.w = -r3.x * r3.x + 1;
  r0.w = -r3.y * r3.y + r0.w;
  r0.w = max(0, r0.w);
  r3.w = cmp(0 < r0.w);
  r4.w = rsqrt(r0.w);
  r0.w = r4.w * r0.w;
  r3.z = r3.w ? r0.w : 0;
  r0.w = 1 + -cb0[3].w;
  r3.xyz = r3.xyz * r0.www;
  r3.xyz = r4.xyz * cb0[3].www + r3.xyz;
  r0.w = dot(r3.xyz, r3.xyz);
  r0.w = rsqrt(r0.w);
  r3.xyz = r3.xyz * r0.www;
  r4.x = saturate(dot(r3.xyz, float3(0.707099974,-0.408199996,0.577400029)));
  r4.y = saturate(dot(r3.xyz, float3(-0.707099974,-0.408199996,0.577400029)));
  r4.z = saturate(dot(r3.yz, float2(0.816500008,0.577400029)));
  r4.xyz = r4.xyz * r4.xyz;
  r5.xyz = v6.xyz * r4.yyy;
  r4.xyw = v5.xyz * r4.xxx + r5.xyz;
  r4.xyz = v2.xyz * r4.zzz + r4.xyw;
  r4.xyz = v1.xyz * float3(2,2,2) + r4.xyz;
  r5.xyz = v8.xyz * r3.yyy;
  r3.xyw = v7.xyz * r3.xxx + r5.xyz;
  r3.xyz = v9.xyz * r3.zzz + r3.xyw;
  r0.w = dot(r3.xyz, r3.xyz);
  r0.w = rsqrt(r0.w);
  r3.xyz = r3.xyz * r0.www;
  r0.w = dot(r3.xyz, r0.xyz);
  r3.w = r0.w + r0.w;
  r0.xyz = r3.www * r3.xyz + -r0.xyz;
  r0.xyz = t4.Sample(s4_s, r0.xyz).xyz;
  r3.w = dot(cb0[9].xyz, r3.xyz);
  r4.w = 1 / cb0[13].x;
  r5.x = r4.w * r2.w;
  r2.w = -r2.w * r4.w + 1;
  r4.w = saturate(v12.x);
  r2.w = r2.w * r4.w + r5.x;
  r3.w = cmp(r3.w < 0);
  r2.w = r3.w ? r2.w : 0;
  r3.y = saturate(dot(-cb0[9].xyz, r3.xyz));
  r5.xyz = cb0[8].xyz * r2.www;
  r3.yzw = r5.xyz * r3.yyy + r4.xyz;
  r2.w = r2.w * 0.5 + 0.5;
  r4.xyz = cb0[8].xyz * r2.www;
  r2.xyz = r4.xyz * r2.xyz;
  r0.w = 1 + -r0.w;
  r2.w = r0.w * r0.w;
  r2.w = r2.w * r2.w;
  r0.xyzw = r2.xyzw * r0.xyzw;
  r0.w = cb0[3].y * r0.w;
  r0.xyz = v1.www * r0.xyz;
  r0.xyz = r0.xyz + r0.xyz;
  r1.xyz = r1.xyz * r3.yzw + r0.xyz;
  r1.xyz = r0.xyz * r0.www + r1.xyz;
  r0.w = v1.w * r1.w;
  r0.w = cb0[3].x * r0.w;
  r0.w = r0.w * r3.x;
  r2.xy = v0.xy / cb0[11].xy;
  r2.xy = r0.ww * float2(0.150000006,0.150000006) + r2.xy;
  r2.xyz = t5.Sample(s5_s, r2.xy).xyz;
  r2.xyz = float3(0.25,0.25,0.25) * r2.xyz;
  r4.xyzw = cmp(v0.xxxx < float4(512,128,256,384));
  r0.xyz = r4.www ? r0.xyz : r2.xyz;
  r0.xyz = r4.zzz ? r3.yzw : r0.xyz;
  r0.xyz = r4.yyy ? r1.xyz : r0.xyz;
  r0.w = cmp(736 < v0.y);
  r0.xyz = r0.www ? float3(0,0,0.5) : r0.xyz;
  r0.w = 1;
  o0.xyzw = r4.xxxx ? r0.xyzw : 0;
  return;
}