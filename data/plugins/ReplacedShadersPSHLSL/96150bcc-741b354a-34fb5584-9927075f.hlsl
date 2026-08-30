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
  float4 cb0[40];
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

  r0.xyzw = t0.Sample(s0_s, v3.xy).xyzw;
  bitmask.x = ((~(-1 << 1)) << 1) & 0xffffffff;  r1.x = (((uint)v12.x << 1) & bitmask.x) | ((uint)0 & ~bitmask.x);
  r1.x = (int)r1.x + -1;
  r1.x = (int)r1.x;
  r1.yz = float2(0.699999988,0.699999988) * cb0[28].xy;
  r2.xy = v10.xy / v10.ww;
  r2.xy = r2.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.x = v11.y * r1.x + v10.z;
  r2.z = saturate(r1.x / v10.w);
  r1.x = -1 + cb0[29].x;
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
      r3.x = t7.SampleCmpLevelZero(s7_s, r4.yz, r4.w).x;
      r3.w = r3.x + r3.w;
    }
  }
  r0.w = v1.w * r0.w;
  r0.w = cmp(r0.w < 0.498039216);
  if (r0.w != 0) discard;
  r1.xyz = t2.Sample(s2_s, v3.xy).xyz;
  r2.xyzw = t3.Sample(s3_s, v3.xy).xyzw;
  r3.xy = t1.Sample(s1_s, v3.xy).yw;
  r3.xy = float2(-0.5,-0.5) + r3.yx;
  r3.xy = r3.xy + r3.xy;
  r0.w = -r3.x * r3.x + 1;
  r0.w = -r3.y * r3.y + r0.w;
  r0.w = max(0, r0.w);
  r1.w = cmp(0 < r0.w);
  r3.z = rsqrt(r0.w);
  r0.w = r3.z * r0.w;
  r0.w = r1.w ? r0.w : 0;
  r1.w = cb0[2].w * r2.w;
  r4.xyz = t5.Sample(s5_s, v3.zw).xyz;
  r4.xyz = r4.xyz * cb0[2].xyz + -r0.xyz;
  r0.xyz = r1.www * r4.xyz + r0.xyz;
  r4.xy = t6.Sample(s6_s, v3.zw).yw;
  r4.xy = float2(-0.5,-0.5) + r4.yx;
  r4.xy = r4.xy * r1.ww;
  r3.xy = r4.xy * float2(2,2) + r3.xy;
  r3.z = cb0[3].w + -cb0[1].w;
  r3.z = r1.w * r3.z + cb0[1].w;
  r4.xyz = v7.xyz * r3.yyy;
  r4.xyz = v6.xyz * r3.xxx + r4.xyz;
  r4.xyz = v8.xyz * r0.www + r4.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r0.w = rsqrt(r0.w);
  r4.xyz = r4.xyz * r0.www;
  r0.w = dot(cb0[17].xyz, r4.xyz);
  r3.x = 1 / cb0[29].x;
  r3.y = r3.w * r3.x;
  r3.x = -r3.w * r3.x + 1;
  r3.w = saturate(v11.x);
  r3.x = r3.x * r3.w + r3.y;
  r0.w = cmp(r0.w < 0);
  r0.w = r0.w ? r3.x : 0;
  r3.xyw = -cb0[22].xyz + v9.xyz;
  r4.w = dot(r3.xyw, r3.xyw);
  r4.w = rsqrt(r4.w);
  r5.x = dot(-r4.xyz, cb0[17].xyz);
  r5.y = dot(-r4.xyz, cb0[18].xyz);
  r5.z = saturate(dot(-r4.xyz, cb0[19].xyz));
  r6.xyz = r3.xyw * r4.www + cb0[17].xyz;
  r5.w = dot(r6.xyz, r6.xyz);
  r5.w = rsqrt(r5.w);
  r6.xyz = r6.xyz * r5.www;
  r5.w = saturate(dot(-r4.xyz, r6.xyz));
  r3.xyw = r3.xyw * r4.www + cb0[18].xyz;
  r4.w = dot(r3.xyw, r3.xyw);
  r4.w = rsqrt(r4.w);
  r3.xyw = r4.www * r3.xyw;
  r3.x = saturate(dot(-r4.xyz, r3.xyw));
  r3.y = saturate(r5.x * 5 + 1);
  r3.w = log2(r5.w);
  r3.w = r3.z * r3.w;
  r3.w = exp2(r3.w);
  r3.y = r3.w * r3.y;
  r3.w = saturate(r5.y * 5 + 1);
  r3.x = log2(r3.x);
  r3.x = r3.z * r3.x;
  r3.x = exp2(r3.x);
  r3.x = r3.x * r3.w;
  r6.xyz = cb0[8].xyz * r0.www;
  r5.xy = saturate(r5.xy);
  r7.xyz = cb0[9].xyz * r5.yyy;
  r5.xyw = r6.xyz * r5.xxx + r7.xyz;
  r5.xyz = cb0[10].xyz * r5.zzz + r5.xyw;
  r0.w = r0.w * 0.75 + 0.25;
  r6.xyz = cb0[8].xyz * r0.www;
  r3.xzw = cb0[9].xyz * r3.xxx;
  r3.xyz = r3.yyy * r6.xyz + r3.xzw;
  r6.xyz = cb0[30].xyz + -v9.xyz;
  r6.xyz = cb0[30].www * r6.xyz;
  r0.w = dot(r6.xyz, r6.xyz);
  r0.w = sqrt(r0.w);
  r3.w = dot(r6.xyz, r4.xyz);
  r3.w = saturate(r3.w / r0.w);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r0.w = r3.w * r0.w;
  r6.xyz = cb0[32].xyz + -v9.xyz;
  r6.xyz = cb0[32].www * r6.xyz;
  r3.w = dot(r6.xyz, r6.xyz);
  r3.w = sqrt(r3.w);
  r4.w = dot(r6.xyz, r4.xyz);
  r4.w = saturate(r4.w / r3.w);
  r3.w = 1 + -r3.w;
  r3.w = max(0, r3.w);
  r3.w = r4.w * r3.w;
  r6.xyz = cb0[33].xyz * r3.www;
  r6.xyz = cb0[31].xyz * r0.www + r6.xyz;
  r7.xyz = cb0[34].xyz + -v9.xyz;
  r7.xyz = cb0[34].www * r7.xyz;
  r0.w = dot(r7.xyz, r7.xyz);
  r0.w = sqrt(r0.w);
  r3.w = dot(r7.xyz, r4.xyz);
  r3.w = saturate(r3.w / r0.w);
  r4.w = 1 + -r0.w;
  r4.w = max(0, r4.w);
  r3.w = r4.w * r3.w;
  r4.w = dot(cb0[35].xyz, -r7.xyz);
  r0.w = r4.w / r0.w;
  r0.w = -cb0[36].w + r0.w;
  r0.w = saturate(cb0[35].w * r0.w);
  r7.xyz = cb0[36].xyz * r3.www;
  r6.xyz = r7.xyz * r0.www + r6.xyz;
  r7.xyz = cb0[37].xyz + -v9.xyz;
  r7.xyz = cb0[37].www * r7.xyz;
  r0.w = dot(r7.xyz, r7.xyz);
  r0.w = sqrt(r0.w);
  r3.w = dot(r7.xyz, r4.xyz);
  r3.w = saturate(r3.w / r0.w);
  r4.w = 1 + -r0.w;
  r4.w = max(0, r4.w);
  r3.w = r4.w * r3.w;
  r4.w = dot(cb0[35].xyz, -r7.xyz);
  r0.w = r4.w / r0.w;
  r0.w = -cb0[39].w + r0.w;
  r0.w = saturate(cb0[38].w * r0.w);
  r7.xyz = cb0[39].xyz * r3.www;
  r6.xyz = r7.xyz * r0.www + r6.xyz;
  r5.xyz = r6.xyz + r5.xyz;
  r0.w = dot(-r4.xyz, cb0[16].xyz);
  r6.xyz = cb0[11].xyz * r0.www + cb0[12].xyz;
  r6.xyz = cb0[1].xyz * r6.xyz;
  r5.xyz = r5.xyz * cb0[0].xyz + r6.xyz;
  r6.xyz = float3(1,1,1) + -cb0[3].xyz;
  r6.xyz = r1.www * r6.xyz + cb0[3].xyz;
  r1.xyz = r6.xyz * r1.xyz;
  r0.w = -cb0[2].w * r2.w + 1;
  r2.xyz = r2.xyz * r0.www;
  r6.xyz = v4.xyz * r4.yyy;
  r4.xyw = w2.xyz * r4.xxx + r6.xyz;
  r4.xyz = v5.xyz * r4.zzz + r4.xyw;
  r0.w = dot(r4.xyz, r4.xyz);
  r0.w = rsqrt(r0.w);
  r4.xy = r4.xy * r0.ww;
  r4.xy = r4.xy * float2(0.5,0.5) + float2(0.5,0.5);
  r4.xyz = t4.Sample(s4_s, r4.xy).xyz;
  r0.xyz = r4.xyz * r2.xyz + r0.xyz;
  r1.xyz = r1.xyz * r3.xyz;
  r0.xyz = r0.xyz * r5.xyz + r1.xyz;
  r1.xyz = float3(-1,-1,-1) + cb0[24].xyz;
  r1.xyz = v1.yyy * r1.xyz + float3(1,1,1);
  r2.xyz = cb0[23].xyz + -r1.xyz;
  r1.xyz = v1.xxx * r2.xyz + r1.xyz;
  r0.w = 1 + -v1.y;
  r0.w = r0.w * v1.x + v1.y;
  r2.xyz = cb0[25].xyz + -r1.xyz;
  r1.xyz = v1.zzz * r2.xyz + r1.xyz;
  r1.w = 1 + -r0.w;
  r0.w = r1.w * v1.z + r0.w;
  r1.xyz = r0.xyz * r1.xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
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
  return;
}