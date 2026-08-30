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
  float4 cb0[30];
}




// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);


void main( 
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : COLOR2,
  float3 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD2,
  float4 v5 : TEXCOORD3,
  float4 v6 : TEXCOORD4,
  float4 v7 : TEXCOORD5,
  float4 v8 : TEXCOORD6,
  float4 v9 : TEXCOORD7,
  float4 v10 : TEXCOORD8,
  float4 v11 : TEXCOORD9,
  uint v12 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.x = (((uint)v12.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r0.x = (int)r0.x + -1;
  r0.x = (int)r0.x;
  r0.yz = float2(0.699999988,0.699999988) * cb0[28].xy;
  r1.xy = v10.xy / v10.ww;
  r1.xy = r1.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.x = v11.y * r0.x + v10.z;
  r1.z = saturate(r0.x / v10.w);
  r0.x = -1 + cb0[29].x;
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
  r0.x = cmp(0 < cb0[27].x);
  if (r0.x != 0) {
    r0.yz = floor(v0.xy);
    r0.yz = (uint2)r0.yz;
    r1.x = (int)r0.y & 31;
    r1.y = (int)cb0[27].y;
    r1.zw = float2(0,0);
    r0.y = t9.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  r0.xyzw = t0.Sample(s0_s, v3.xy).xyzw;
  r1.xyz = t2.Sample(s2_s, v3.xy).xyz;
  r3.xyzw = t3.Sample(s3_s, v3.xy).xyzw;
  r2.xy = t1.Sample(s1_s, v3.xy).yw;
  r2.xy = float2(-0.5,-0.5) + r2.yx;
  r2.xy = r2.xy + r2.xy;
  r1.w = -r2.x * r2.x + 1;
  r1.w = -r2.y * r2.y + r1.w;
  r1.w = max(0, r1.w);
  r2.z = cmp(0 < r1.w);
  r4.x = rsqrt(r1.w);
  r1.w = r4.x * r1.w;
  r1.w = r2.z ? r1.w : 0;
  r2.z = cb0[2].w * r3.w;
  r4.xyz = t5.Sample(s5_s, v3.zw).xyz;
  r4.xyz = r4.xyz * cb0[2].xyz + -r0.xyz;
  r0.xyz = r2.zzz * r4.xyz + r0.xyz;
  r4.xy = t6.Sample(s6_s, v3.zw).yw;
  r4.xy = float2(-0.5,-0.5) + r4.yx;
  r4.xy = r4.xy * r2.zz;
  r2.xy = r4.xy * float2(2,2) + r2.xy;
  r4.x = cb0[3].w + -cb0[1].w;
  r4.x = r2.z * r4.x + cb0[1].w;
  r4.yzw = v7.xyz * r2.yyy;
  r4.yzw = v6.xyz * r2.xxx + r4.yzw;
  r4.yzw = v8.xyz * r1.www + r4.yzw;
  r1.w = dot(r4.yzw, r4.yzw);
  r1.w = rsqrt(r1.w);
  r4.yzw = r4.yzw * r1.www;
  r1.w = dot(cb0[17].xyz, r4.yzw);
  r2.x = 1 / cb0[29].x;
  r2.y = r2.w * r2.x;
  r2.x = -r2.w * r2.x + 1;
  r2.w = saturate(v11.x);
  r2.x = r2.x * r2.w + r2.y;
  r1.w = cmp(r1.w < 0);
  r1.w = r1.w ? r2.x : 0;
  r2.xyw = -cb0[22].xyz + v9.xyz;
  r5.x = dot(r2.xyw, r2.xyw);
  r5.x = rsqrt(r5.x);
  r5.y = dot(-r4.yzw, cb0[17].xyz);
  r5.z = dot(-r4.yzw, cb0[18].xyz);
  r5.w = saturate(dot(-r4.yzw, cb0[19].xyz));
  r6.xyz = r2.xyw * r5.xxx + cb0[17].xyz;
  r6.w = dot(r6.xyz, r6.xyz);
  r6.w = rsqrt(r6.w);
  r6.xyz = r6.xyz * r6.www;
  r6.x = saturate(dot(-r4.yzw, r6.xyz));
  r2.xyw = r2.xyw * r5.xxx + cb0[18].xyz;
  r5.x = dot(r2.xyw, r2.xyw);
  r5.x = rsqrt(r5.x);
  r2.xyw = r5.xxx * r2.xyw;
  r2.x = saturate(dot(-r4.yzw, r2.xyw));
  r2.y = saturate(r5.y * 5 + 1);
  r2.w = log2(r6.x);
  r2.w = r4.x * r2.w;
  r2.w = exp2(r2.w);
  r2.y = r2.w * r2.y;
  r2.w = saturate(r5.z * 5 + 1);
  r2.x = log2(r2.x);
  r2.x = r4.x * r2.x;
  r2.x = exp2(r2.x);
  r2.x = r2.x * r2.w;
  r6.xyz = cb0[8].xyz * r1.www;
  r5.yz = saturate(r5.yz);
  r7.xyz = cb0[9].xyz * r5.zzz;
  r5.xyz = r6.xyz * r5.yyy + r7.xyz;
  r5.xyz = cb0[10].xyz * r5.www + r5.xyz;
  r1.w = r1.w * 0.75 + 0.25;
  r6.xyz = cb0[8].xyz * r1.www;
  r7.xyz = cb0[9].xyz * r2.xxx;
  r2.xyw = r2.yyy * r6.xyz + r7.xyz;
  r1.w = dot(-r4.yzw, cb0[16].xyz);
  r6.xyz = cb0[11].xyz * r1.www + cb0[12].xyz;
  r6.xyz = cb0[1].xyz * r6.xyz;
  r5.xyz = r5.xyz * cb0[0].xyz + r6.xyz;
  r6.xyz = float3(1,1,1) + -cb0[3].xyz;
  r6.xyz = r2.zzz * r6.xyz + cb0[3].xyz;
  r1.xyz = r6.xyz * r1.xyz;
  r1.w = -cb0[2].w * r3.w + 1;
  r3.xyz = r3.xyz * r1.www;
  r6.xyz = v4.xyz * r4.zzz;
  r4.xyz = w2.xyz * r4.yyy + r6.xyz;
  r4.xyz = v5.xyz * r4.www + r4.xyz;
  r1.w = dot(r4.xyz, r4.xyz);
  r1.w = rsqrt(r1.w);
  r4.xy = r4.xy * r1.ww;
  r4.xy = r4.xy * float2(0.5,0.5) + float2(0.5,0.5);
  r4.xyz = t4.Sample(s4_s, r4.xy).xyz;
  r0.xyz = r4.xyz * r3.xyz + r0.xyz;
  r1.xyz = r1.xyz * r2.xyw;
  r0.xyz = r0.xyz * r5.xyz + r1.xyz;
  r1.xyz = float3(-1,-1,-1) + cb0[24].xyz;
  r1.xyz = v1.yyy * r1.xyz + float3(1,1,1);
  r2.xyz = cb0[23].xyz + -r1.xyz;
  r1.xyz = v1.xxx * r2.xyz + r1.xyz;
  r1.w = 1 + -v1.y;
  r1.w = r1.w * v1.x + v1.y;
  r2.xyz = cb0[25].xyz + -r1.xyz;
  r1.xyz = v1.zzz * r2.xyz + r1.xyz;
  r2.x = 1 + -r1.w;
  r1.w = r2.x * v1.z + r1.w;
  r1.xyz = r0.xyz * r1.xyz + -r0.xyz;
  r0.xyz = r1.www * r1.xyz + r0.xyz;
  r1.x = max(cb0[20].z, v2.x);
  r1.x = min(cb0[20].w, r1.x);
  r1.x = cb0[21].w * r1.x;
  r1.yzw = cb0[21].xyz + -r0.xyz;
  o0.xyz = r1.xxx * r1.yzw + r0.xyz;
  o0.w = v1.w * r0.w;
  return;
}