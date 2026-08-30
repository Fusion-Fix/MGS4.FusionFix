// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:56 2026
Texture2D<uint4> t7 : register(t7);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

TextureCube<float4> t3 : register(t3);

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
  float4 cb0[27];
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
  r0.yz = float2(0.699999988,0.699999988) * cb0[15].xy;
  r1.xy = v11.xy / v11.ww;
  r1.xy = r1.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.x = v12.y * r0.x + v11.z;
  r1.z = saturate(r0.x / v11.w);
  r0.x = -1 + cb0[16].x;
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
      r2.x = t5.SampleCmpLevelZero(s5_s, r3.yz, r3.w).x;
      r2.w = r2.x + r2.w;
    }
  }
  r0.x = cmp(1 < cb0[0].x);
  if (r0.x != 0) discard;
  r0.x = t4.Sample(s4_s, v3.xy).y;
  r0.xy = v4.xy * r0.xx + v3.xy;
  r1.xyzw = cb0[3].zzww * r0.xyxy;
  r2.xyz = t0.Sample(s0_s, r1.xy).xyz;
  r2.xyz = cb0[1].xyz * r2.xyz;
  r3.xyz = float3(4,4,4) * v2.xyz;
  r0.xy = t1.Sample(s1_s, r0.xy).yw;
  r0.xy = float2(-0.5,-0.5) + r0.yx;
  r0.xy = r0.xy + r0.xy;
  r0.w = -r0.x * r0.x + 1;
  r0.w = -r0.y * r0.y + r0.w;
  r0.w = max(0, r0.w);
  r1.x = cmp(0 < r0.w);
  r1.y = rsqrt(r0.w);
  r0.w = r1.y * r0.w;
  r0.z = r1.x ? r0.w : 0;
  r4.xyz = v8.xyz * r0.yyy;
  r4.xyz = v7.xyz * r0.xxx + r4.xyz;
  r4.xyz = v9.xyz * r0.zzz + r4.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r0.w = rsqrt(r0.w);
  r4.xyz = r4.xyz * r0.www;
  r5.x = saturate(dot(r0.xyz, float3(0.707099974,-0.408199996,0.577400029)));
  r5.y = saturate(dot(r0.xyz, float3(-0.707099974,-0.408199996,0.577400029)));
  r5.z = saturate(dot(r0.yz, float2(0.816500008,0.577400029)));
  r0.xyz = r5.xyz * r5.xyz;
  r5.xyz = v6.xyz * r0.yyy;
  r0.xyw = v5.xyz * r0.xxx + r5.xyz;
  r0.xyz = r3.xyz * r0.zzz + r0.xyw;
  r0.xyz = v1.xyz * float3(2,2,2) + r0.xyz;
  r0.w = dot(cb0[10].xyz, r4.xyz);
  r1.x = 1 / cb0[16].x;
  r1.y = r2.w * r1.x;
  r1.x = -r2.w * r1.x + 1;
  r2.w = saturate(v12.x);
  r1.x = r1.x * r2.w + r1.y;
  r0.w = cmp(r0.w < 0);
  r0.w = r0.w ? r1.x : 0;
  r1.x = saturate(dot(-cb0[10].xyz, r4.xyz));
  r3.xyz = cb0[9].xyz * r0.www;
  r0.xyz = r3.xyz * r1.xxx + r0.xyz;
  r3.xyz = cb0[17].xyz + -v10.xyz;
  r3.xyz = cb0[17].www * r3.xyz;
  r1.x = dot(r3.xyz, r3.xyz);
  r1.x = sqrt(r1.x);
  r1.y = dot(r3.xyz, r4.xyz);
  r1.y = saturate(r1.y / r1.x);
  r1.x = 1 + -r1.x;
  r1.x = max(0, r1.x);
  r1.x = r1.y * r1.x;
  r3.xyz = cb0[19].xyz + -v10.xyz;
  r3.xyz = cb0[19].www * r3.xyz;
  r1.y = dot(r3.xyz, r3.xyz);
  r1.y = sqrt(r1.y);
  r2.w = dot(r3.xyz, r4.xyz);
  r2.w = saturate(r2.w / r1.y);
  r1.y = 1 + -r1.y;
  r1.y = max(0, r1.y);
  r1.y = r2.w * r1.y;
  r3.xyz = cb0[20].xyz * r1.yyy;
  r3.xyz = cb0[18].xyz * r1.xxx + r3.xyz;
  r5.xyz = cb0[21].xyz + -v10.xyz;
  r5.xyz = cb0[21].www * r5.xyz;
  r1.x = dot(r5.xyz, r5.xyz);
  r1.x = sqrt(r1.x);
  r1.y = dot(r5.xyz, r4.xyz);
  r1.y = saturate(r1.y / r1.x);
  r2.w = 1 + -r1.x;
  r2.w = max(0, r2.w);
  r1.y = r2.w * r1.y;
  r2.w = dot(cb0[22].xyz, -r5.xyz);
  r1.x = r2.w / r1.x;
  r1.x = -cb0[23].w + r1.x;
  r1.x = saturate(cb0[22].w * r1.x);
  r5.xyz = cb0[23].xyz * r1.yyy;
  r3.xyz = r5.xyz * r1.xxx + r3.xyz;
  r5.xyz = cb0[24].xyz + -v10.xyz;
  r5.xyz = cb0[24].www * r5.xyz;
  r1.x = dot(r5.xyz, r5.xyz);
  r1.x = sqrt(r1.x);
  r1.y = dot(r5.xyz, r4.xyz);
  r1.y = saturate(r1.y / r1.x);
  r2.w = 1 + -r1.x;
  r2.w = max(0, r2.w);
  r1.y = r2.w * r1.y;
  r2.w = dot(cb0[22].xyz, -r5.xyz);
  r1.x = r2.w / r1.x;
  r1.x = -cb0[26].w + r1.x;
  r1.x = saturate(cb0[25].w * r1.x);
  r5.xyz = cb0[26].xyz * r1.yyy;
  r3.xyz = r5.xyz * r1.xxx + r3.xyz;
  r0.xyz = r3.xyz + r0.xyz;
  r3.xyz = -cb0[13].xyz + v10.xyz;
  r1.x = dot(r3.xyz, r3.xyz);
  r1.x = rsqrt(r1.x);
  r3.xyz = r3.xyz * r1.xxx;
  r5.xyz = r4.xyz + r4.xyz;
  r1.x = dot(-r4.xyz, r3.xyz);
  r3.xyz = r5.xyz * r1.xxx + r3.xyz;
  r3.xyz = t3.Sample(s3_s, r3.xyz).xyz;
  r1.xyz = t2.Sample(s2_s, r1.zw).xyz;
  r1.xyz = cb0[2].xyz * r1.xyz;
  r0.w = r0.w * 0.5 + 0.5;
  r4.xyz = cb0[9].xyz * r0.www;
  r1.xyz = r4.xyz * r1.xyz;
  r1.xyz = r3.xyz * r1.xyz;
  r1.xyz = v1.www * r1.xyz;
  r1.xyz = r1.xyz + r1.xyz;
  r0.xyz = r2.xyz * r0.xyz + r1.xyz;
  r0.w = max(cb0[11].z, w2.x);
  r0.w = min(cb0[11].w, r0.w);
  r0.w = cb0[12].w * r0.w;
  r1.xyz = cb0[12].xyz + -r0.xyz;
  o0.xyz = r0.www * r1.xyz + r0.xyz;
  r0.x = cmp(0 < cb0[14].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[14].y;
    r1.zw = float2(0,0);
    r0.y = t7.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  o0.w = 1;
  return;
}