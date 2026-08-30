// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:05 2026
Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s8_s : register(s8);

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
  float4 cb0[15];
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
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD2,
  float4 v6 : TEXCOORD3,
  float4 v7 : TEXCOORD5,
  float4 v8 : TEXCOORD8,
  float4 v9 : TEXCOORD9,
  uint v10 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(w2.xyz, w2.xyz);
  r0.x = rsqrt(r0.x);
  r0.yzw = w2.xyz * r0.xxx;
  r1.xy = t3.Sample(s3_s, v6.xy).yw;
  r1.xy = float2(-0.5,-0.5) + r1.yx;
  r1.xz = r1.xy + r1.xy;
  r1.w = -r1.x * r1.x + 1;
  r1.w = -r1.z * r1.z + r1.w;
  r1.w = max(0, r1.w);
  r2.x = cmp(0 < r1.w);
  r2.y = rsqrt(r1.w);
  r1.w = r2.y * r1.w;
  r1.y = r2.x ? r1.w : 0;
  r2.xy = t5.Sample(s5_s, v6.zw).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xz = r2.xy + r2.xy;
  r1.w = -r2.x * r2.x + 1;
  r1.w = -r2.z * r2.z + r1.w;
  r1.w = max(0, r1.w);
  r2.w = cmp(0 < r1.w);
  r3.x = rsqrt(r1.w);
  r1.w = r3.x * r1.w;
  r2.y = r2.w ? r1.w : 0;
  r1.xyz = -r2.xyz + r1.xyz;
  r1.xyz = cb0[7].zzz * r1.xyz + r2.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r1.xyz = r1.xyz * r1.www;
  r2.xyzw = cb0[7].xxyy * r1.xzxz;
  r2.xy = r2.xy * float2(0.100000001,0.100000001) + v3.xy;
  r2.zw = r2.zw * float2(0.100000001,0.100000001) + v5.zw;
  r3.xyzw = t0.Sample(s0_s, r2.xy).xyzw;
  r3.xyzw = cb0[0].xyzw * r3.xyzw;
  bitmask.w = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.w = (((uint)v10.x << 1) & bitmask.w) | ((uint)0 & ~bitmask.w);
  r1.w = (int)r1.w + -1;
  r1.w = (int)r1.w;
  r2.x = dot(cb0[9].xyz, r1.xyz);
  r4.xy = float2(0.699999988,0.699999988) * cb0[13].xy;
  r4.zw = v8.xy / v8.ww;
  r5.xy = r4.zw * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.w = v9.y * r1.w + v8.z;
  r5.z = saturate(r1.w / v8.w);
  r1.w = -1 + cb0[14].x;
  r2.y = 360 / r1.w;
  r6.z = 0;
    r4.w = 0;
  r5.w = 0;
  {
    r4.w = 0;
    ignAngle = frac(dot(v0.xy, float2(0.06711056, 0.00583715)));
    ignAngle = frac(52.9829189 * ignAngle) * 2 * 3.14159265359;
    sincos(ignAngle, ign_sin, ign_cos);
    [unroll]
    for (int j = 0; j < 8; j++) {
      spiralR = sqrt((j + 0.5) / 8);
      spiralTheta = j * 2.39996323;
      sincos(spiralTheta, r7.x, r8.x);
      r6.x = r8.x * spiralR;
      r6.y = r7.x * spiralR;
      rotX = ign_cos * r6.x - ign_sin * r6.y;
      rotY = ign_sin * r6.x + ign_cos * r6.y;
      r6.x = r4.x * rotX + r5.x;
      r6.y = r4.y * rotY + r5.y;
      r6.w = r5.z;
      r6.x = t7.SampleCmpLevelZero(s7_s, r6.xy, r6.w).x;
      r4.w = r6.x + r4.w;
    }
  }
  r1.w = 1 / cb0[14].x;
  r2.y = r4.w * r1.w;
  r1.w = -r4.w * r1.w + 1;
  r4.x = saturate(v9.x);
  r1.w = r1.w * r4.x + r2.y;
  r2.x = cmp(r2.x < 0);
  r1.w = r2.x ? r1.w : 0;
  r2.x = saturate(dot(-cb0[9].xyz, r1.xyz));
  r4.xyz = cb0[8].xyz * r1.www;
  r4.xyz = r4.xyz * r2.xxx;
  r5.xyz = t4.Sample(s4_s, v3.zw).xyz;
  r5.xyz = cb0[1].xyz * r5.xyz;
  r1.w = r1.w * 0.5 + 0.5;
  r6.xyz = cb0[8].xyz * r1.www;
  r5.xyz = r6.xyz * r5.xyz;
  r1.w = dot(r1.xyz, r0.yzw);
  r1.w = r1.w + r1.w;
  r0.yzw = r1.www * r1.xyz + -r0.yzw;
  r0.z = dot(r0.yzw, r0.yzw);
  r0.z = rsqrt(r0.z);
  r0.yz = r0.yw * r0.zz;
  r0.yz = r0.yz * float2(0.5,0.5) + float2(0.5,0.5);
  r0.yzw = t6.Sample(s6_s, r0.yz).xyz;
  r1.x = t1.Sample(s1_s, v4.xy).x;
  r1.y = t1.Sample(s1_s, v4.zw).y;
  r1.z = t1.Sample(s1_s, v5.xy).z;
  r2.xyzw = t2.Sample(s2_s, r2.zw).xyzw;
  r2.xyz = r2.xyz * r6.xyz;
  r1.x = r1.x * r1.y + r1.z;
  r1.x = saturate(r2.w * r1.x);
  r1.yzw = w2.xyz * r0.xxx + -cb0[9].xyz;
  r0.x = dot(r1.yzw, r1.yzw);
  r0.x = rsqrt(r0.x);
  r1.yzw = r1.yzw * r0.xxx;
  r0.x = dot(-cb0[9].xyz, r1.yzw);
  r0.x = 1 + -r0.x;
  r1.y = r0.x * r0.x;
  r1.y = r1.y * r1.y;
  r0.x = r1.y * r0.x;
  r0.x = r0.x * cb0[7].w + -cb0[7].w;
  r0.x = 1 + r0.x;
  r1.yz = v0.xy / cb0[12].xy;
  r1.y = t8.Sample(s8_s, r1.yz).x;
  r1.z = v1.w * r3.w;
  r1.y = -v7.w + r1.y;
  r1.y = saturate(v7.z * r1.y);
  r1.y = r1.z * r1.y;
  r0.yzw = r0.yzw * r5.xyz;
  r0.yzw = r0.yzw * r1.yyy;
  r0.xyz = r0.yzw * r0.xxx;
  r0.xyz = r0.xyz + r0.xyz;
  r0.xyz = r3.xyz * r4.xyz + r0.xyz;
  r1.xzw = r2.xyz * r1.xxx;
  r0.xyz = r1.xzw * r1.yyy + r0.xyz;
  r0.w = max(cb0[10].z, v2.x);
  r0.w = min(cb0[10].w, r0.w);
  r0.w = cb0[11].w * r0.w;
  r1.xzw = cb0[11].xyz + -r0.xyz;
  r1.xzw = r1.xzw * r0.www;
  o0.xyz = r1.yyy * r1.xzw + r0.xyz;
  o0.w = r1.y;
  return;
}