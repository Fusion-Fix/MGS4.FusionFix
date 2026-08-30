// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:17:55 2026
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
  float3 w2 : TEXCOORD3,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD2,
  float4 v6 : TEXCOORD4,
  float4 v7 : TEXCOORD5,
  float4 v8 : TEXCOORD6,
  float4 v9 : TEXCOORD8,
  float4 v10 : TEXCOORD9,
  uint v11 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.x = (((uint)v11.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r0.x = (int)r0.x + -1;
  r0.x = (int)r0.x;
  r0.yz = float2(0.699999988,0.699999988) * cb0[13].xy;
  r1.xy = v9.xy / v9.ww;
  r1.xy = r1.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.x = v10.y * r0.x + v9.z;
  r1.z = saturate(r0.x / v9.w);
  r0.x = -1 + cb0[14].x;
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
  r0.x = cmp(0 < cb0[12].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[12].y;
    r1.zw = float2(0,0);
    r0.y = t9.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  r0.x = dot(w2.xyz, w2.xyz);
  r0.x = rsqrt(r0.x);
  r0.yzw = w2.xyz * r0.xxx;
  r1.xy = t2.Sample(s2_s, v5.xy).yw;
  r1.xy = float2(-0.5,-0.5) + r1.yx;
  r1.xy = r1.xy + r1.xy;
  r1.w = -r1.x * r1.x + 1;
  r1.w = -r1.y * r1.y + r1.w;
  r1.w = max(0, r1.w);
  r2.x = cmp(0 < r1.w);
  r2.y = rsqrt(r1.w);
  r1.w = r2.y * r1.w;
  r1.z = r2.x ? r1.w : 0;
  r2.xy = t5.Sample(s5_s, v5.zw).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xy = r2.xy + r2.xy;
  r1.w = -r2.x * r2.x + 1;
  r1.w = -r2.y * r2.y + r1.w;
  r1.w = max(0, r1.w);
  r3.x = cmp(0 < r1.w);
  r3.y = rsqrt(r1.w);
  r1.w = r3.y * r1.w;
  r2.z = r3.x ? r1.w : 0;
  r1.xyz = -r2.xyz + r1.xyz;
  r1.xyz = cb0[7].zzz * r1.xyz + r2.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r1.xyz = r1.xyz * r1.www;
  r3.xyzw = cb0[7].xxyy * r1.xyxy;
  r2.xy = r3.xy * float2(0.100000001,0.100000001) + v3.xy;
  r3.xy = r3.zw * float2(0.100000001,0.100000001) + v4.xy;
  r4.xyz = v7.xyz * r1.yyy;
  r1.xyw = v6.xyz * r1.xxx + r4.xyz;
  r1.xyz = v8.xyz * r1.zzz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r1.xyz = r1.xyz * r1.www;
  r4.xyzw = t0.Sample(s0_s, r2.xy).xyzw;
  r4.xyzw = cb0[0].xyzw * r4.xyzw;
  r1.w = dot(cb0[9].xyz, r1.xyz);
  r2.x = 1 / cb0[14].x;
  r2.y = r2.w * r2.x;
  r2.x = -r2.w * r2.x + 1;
  r2.z = saturate(v10.x);
  r2.x = r2.x * r2.z + r2.y;
  r1.w = cmp(r1.w < 0);
  r1.w = r1.w ? r2.x : 0;
  r2.x = saturate(dot(-cb0[9].xyz, r1.xyz));
  r2.yzw = cb0[8].xyz * r1.www;
  r2.xyz = r2.yzw * r2.xxx;
  r5.xyz = t3.Sample(s3_s, v3.zw).xyz;
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
  r1.x = t1.Sample(s1_s, v5.xy).x;
  r1.y = t1.Sample(s1_s, v5.zw).y;
  r1.z = t1.Sample(s1_s, v4.zw).z;
  r3.xyzw = t4.Sample(s4_s, r3.xy).xyzw;
  r3.xyz = cb0[2].xyz * r3.xyz;
  r3.xyz = r3.xyz * r6.xyz;
  r1.x = r1.x * r1.y + r1.z;
  r1.x = min(1, r1.x);
  r1.x = r3.w * r1.x;
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
  r0.yzw = r0.yzw * r5.xyz;
  r0.yzw = v1.www * r0.yzw;
  r0.xyz = r0.yzw * r0.xxx;
  r0.xyz = r0.xyz + r0.xyz;
  r0.xyz = r4.xyz * r2.xyz + r0.xyz;
  r0.xyz = r3.xyz * r1.xxx + r0.xyz;
  o0.w = v1.w * r4.w;
  r0.w = max(cb0[10].z, v2.x);
  r0.w = min(cb0[10].w, r0.w);
  r0.w = cb0[11].w * r0.w;
  r1.xyz = cb0[11].xyz + -r0.xyz;
  o0.xyz = r0.www * r1.xyz + r0.xyz;
  return;
}