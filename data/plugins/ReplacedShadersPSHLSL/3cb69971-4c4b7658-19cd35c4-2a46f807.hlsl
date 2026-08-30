// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:55 2026
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t2.Sample(s2_s, v3.xy).y;
  r0.xy = v4.xy * r0.xx + v3.xy;
  r0.zw = cb0[1].zz * r0.xy;
  r1.xyzw = t0.Sample(s0_s, r0.zw).xyzw;
  bitmask.z = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.z = (((uint)v13.x << 1) & bitmask.z) | ((uint)0 & ~bitmask.z);
  r0.z = (int)r0.z + -1;
  r0.z = (int)r0.z;
  r2.xy = float2(0.699999988,0.699999988) * cb0[13].xy;
  r2.zw = v11.xy / v11.ww;
  r3.xy = r2.zw * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.z = v12.y * r0.z + v11.z;
  r3.z = saturate(r0.z / v11.w);
  r0.z = -1 + cb0[14].x;
  r0.w = 360 / r0.z;
  r4.z = 0;
    r2.w = 0;
  r3.w = 0;
  {
    r2.w = 0;
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
      r4.x = r2.x * rotX + r3.x;
      r4.y = r2.y * rotY + r3.y;
      r4.w = r3.z;
      r4.x = t3.SampleCmpLevelZero(s3_s, r4.xy, r4.w).x;
      r2.w = r4.x + r2.w;
    }
  }
  r0.z = v1.w * r1.w;
  r0.z = cmp(r0.z < 0.498039216);
  if (r0.z != 0) discard;
  r1.xyz = cb0[0].xyz * r1.xyz;
  r2.xyz = float3(4,4,4) * v2.xyz;
  r0.xy = t1.Sample(s1_s, r0.xy).yw;
  r0.xy = float2(-0.5,-0.5) + r0.yx;
  r0.xy = r0.xy + r0.xy;
  r0.w = -r0.x * r0.x + 1;
  r0.w = -r0.y * r0.y + r0.w;
  r0.w = max(0, r0.w);
  r1.w = cmp(0 < r0.w);
  r3.x = rsqrt(r0.w);
  r0.w = r3.x * r0.w;
  r0.z = r1.w ? r0.w : 0;
  r3.xyz = v8.xyz * r0.yyy;
  r3.xyz = v7.xyz * r0.xxx + r3.xyz;
  r3.xyz = v9.xyz * r0.zzz + r3.xyz;
  r0.w = dot(r3.xyz, r3.xyz);
  r0.w = rsqrt(r0.w);
  r3.xyz = r3.xyz * r0.www;
  r4.x = saturate(dot(r0.xyz, float3(0.707099974,-0.408199996,0.577400029)));
  r4.y = saturate(dot(r0.xyz, float3(-0.707099974,-0.408199996,0.577400029)));
  r4.z = saturate(dot(r0.yz, float2(0.816500008,0.577400029)));
  r0.xyz = r4.xyz * r4.xyz;
  r4.xyz = v6.xyz * r0.yyy;
  r0.xyw = v5.xyz * r0.xxx + r4.xyz;
  r0.xyz = r2.xyz * r0.zzz + r0.xyw;
  r0.xyz = v1.xyz * float3(2,2,2) + r0.xyz;
  r0.w = dot(cb0[9].xyz, r3.xyz);
  r1.w = 1 / cb0[14].x;
  r2.x = r2.w * r1.w;
  r1.w = -r2.w * r1.w + 1;
  r2.y = saturate(v12.x);
  r1.w = r1.w * r2.y + r2.x;
  r0.w = cmp(r0.w < 0);
  r0.w = r0.w ? r1.w : 0;
  r1.w = saturate(dot(-cb0[9].xyz, r3.xyz));
  r2.xyz = cb0[8].xyz * r0.www;
  r0.xyz = r2.xyz * r1.www + r0.xyz;
  r2.xyz = cb0[15].xyz + -v10.xyz;
  r2.xyz = cb0[15].www * r2.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = sqrt(r0.w);
  r1.w = dot(r2.xyz, r3.xyz);
  r1.w = saturate(r1.w / r0.w);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r0.w = r1.w * r0.w;
  r2.xyz = cb0[17].xyz + -v10.xyz;
  r2.xyz = cb0[17].www * r2.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = sqrt(r1.w);
  r2.x = dot(r2.xyz, r3.xyz);
  r2.x = saturate(r2.x / r1.w);
  r1.w = 1 + -r1.w;
  r1.w = max(0, r1.w);
  r1.w = r2.x * r1.w;
  r2.xyz = cb0[18].xyz * r1.www;
  r2.xyz = cb0[16].xyz * r0.www + r2.xyz;
  r4.xyz = cb0[19].xyz + -v10.xyz;
  r4.xyz = cb0[19].www * r4.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r0.w = sqrt(r0.w);
  r1.w = dot(r4.xyz, r3.xyz);
  r1.w = saturate(r1.w / r0.w);
  r2.w = 1 + -r0.w;
  r2.w = max(0, r2.w);
  r1.w = r2.w * r1.w;
  r2.w = dot(cb0[20].xyz, -r4.xyz);
  r0.w = r2.w / r0.w;
  r0.w = -cb0[21].w + r0.w;
  r0.w = saturate(cb0[20].w * r0.w);
  r4.xyz = cb0[21].xyz * r1.www;
  r2.xyz = r4.xyz * r0.www + r2.xyz;
  r4.xyz = cb0[22].xyz + -v10.xyz;
  r4.xyz = cb0[22].www * r4.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r0.w = sqrt(r0.w);
  r1.w = dot(r4.xyz, r3.xyz);
  r1.w = saturate(r1.w / r0.w);
  r2.w = 1 + -r0.w;
  r2.w = max(0, r2.w);
  r1.w = r2.w * r1.w;
  r2.w = dot(cb0[20].xyz, -r4.xyz);
  r0.w = r2.w / r0.w;
  r0.w = -cb0[24].w + r0.w;
  r0.w = saturate(cb0[23].w * r0.w);
  r3.xyz = cb0[24].xyz * r1.www;
  r2.xyz = r3.xyz * r0.www + r2.xyz;
  r0.xyz = r2.xyz + r0.xyz;
  r2.xyz = r1.xyz * r0.xyz;
  r0.w = max(cb0[10].z, w2.x);
  r0.w = min(cb0[10].w, r0.w);
  r0.w = cb0[11].w * r0.w;
  r0.xyz = -r1.xyz * r0.xyz + cb0[11].xyz;
  r0.xyz = r0.www * r0.xyz + r2.xyz;
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