// ---- Created with 3Dmigoto v1.2.45 on Sun Aug 30 19:18:00 2026
Texture2D<uint4> t8 : register(t8);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

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
  float2 w2 : TEXCOORD0,
  float4 v3 : TEXCOORD4,
  float4 v4 : TEXCOORD5,
  float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  uint v9 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = t1.Sample(s1_s, w2.xy).yw;
  r0.xy = float2(-0.5,-0.5) + r0.yx;
  r0.xy = r0.xy + r0.xy;
  r0.z = -r0.x * r0.x + 1;
  r0.z = -r0.y * r0.y + r0.z;
  r0.z = max(0, r0.z);
  r0.w = cmp(0 < r0.z);
  r1.x = rsqrt(r0.z);
  r0.z = r1.x * r0.z;
  r0.z = r0.w ? r0.z : 0;
  r1.xyz = v4.xyz * r0.yyy;
  r0.xyw = v3.xyz * r0.xxx + r1.xyz;
  r0.xyz = v5.xyz * r0.zzz + r0.xyw;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  bitmask.w = ((~(-1 << 1)) << 1) & 0xffffffff;  r0.w = (((uint)v9.x << 1) & bitmask.w) | ((uint)0 & ~bitmask.w);
  r0.w = (int)r0.w + -1;
  r0.w = (int)r0.w;
  r1.xy = float2(0.699999988,0.699999988) * cb0[28].xy;
  r1.zw = v7.xy / v7.ww;
  r2.xy = r1.zw * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.w = v8.y * r0.w + v7.z;
  r2.z = saturate(r0.w / v7.w);
  r0.w = -1 + cb0[29].x;
  r1.z = 360 / r0.w;
  r3.z = 0;
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
      sincos(spiralTheta, r4.x, r5.x);
      r3.x = r5.x * spiralR;
      r3.y = r4.x * spiralR;
      rotX = ign_cos * r3.x - ign_sin * r3.y;
      rotY = ign_sin * r3.x + ign_cos * r3.y;
      r4.x = r1.x * rotX + r2.x;
      r4.y = r1.y * rotY + r2.y;
      r4.z = r2.z;
      r3.x = t6.SampleCmpLevelZero(s6_s, r4.xy, r4.z).x;
      r2.w = r3.x + r2.w;
    }
  }
  r1.xyz = cb0[34].xyz + -v6.xyz;
  r1.xyz = cb0[34].www * r1.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r1.w = dot(r1.xyz, r0.xyz);
  r1.w = saturate(r1.w / r0.w);
  r2.x = 1 + -r0.w;
  r2.x = max(0, r2.x);
  r1.w = r2.x * r1.w;
  r1.x = dot(cb0[35].xyz, -r1.xyz);
  r0.w = r1.x / r0.w;
  r0.w = -cb0[36].w + r0.w;
  r0.w = saturate(cb0[35].w * r0.w);
  r1.xyz = cb0[36].xyz * r1.www;
  r2.xyz = cb0[37].xyz + -v6.xyz;
  r2.xyz = cb0[37].www * r2.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = sqrt(r1.w);
  r3.x = dot(r2.xyz, r0.xyz);
  r3.x = saturate(r3.x / r1.w);
  r3.y = 1 + -r1.w;
  r3.y = max(0, r3.y);
  r3.x = r3.x * r3.y;
  r2.x = dot(cb0[35].xyz, -r2.xyz);
  r1.w = r2.x / r1.w;
  r1.w = -cb0[39].w + r1.w;
  r1.w = saturate(cb0[38].w * r1.w);
  r2.xyz = cb0[39].xyz * r3.xxx;
  r3.x = r2.y * r1.w;
  r3.x = r1.y * r0.w + r3.x;
  r3.x = saturate(3 * r3.x);
  r3.x = cmp(r3.x < 0.498039216);
  if (r3.x != 0) discard;
  r3.xyz = -cb0[22].xyz + v6.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = r3.xyz * r3.www;
  r5.xyz = t0.Sample(s0_s, w2.xy).xyz;
  r6.xyz = t2.Sample(s2_s, w2.xy).xyz;
  r4.w = t5.Sample(s5_s, w2.xy).y;
  r4.w = cb0[2].w * r4.w;
  r5.w = dot(cb0[17].xyz, r0.xyz);
  r6.w = 1 / cb0[29].x;
  r7.x = r6.w * r2.w;
  r2.w = -r2.w * r6.w + 1;
  r6.w = saturate(v8.x);
  r2.w = r2.w * r6.w + r7.x;
  r5.w = cmp(r5.w < 0);
  r2.w = r5.w ? r2.w : 0;
  r5.w = saturate(dot(-r0.xyz, cb0[17].xyz));
  r6.w = saturate(dot(-r0.xyz, cb0[18].xyz));
  r7.x = saturate(dot(-r0.xyz, cb0[19].xyz));
  r7.yzw = cb0[8].xyz * r2.www;
  r8.xyz = cb0[9].xyz * r6.www;
  r7.yzw = r7.yzw * r5.www + r8.xyz;
  r7.xyz = cb0[10].xyz * r7.xxx + r7.yzw;
  r8.xyz = cb0[30].xyz + -v6.xyz;
  r8.xyz = cb0[30].www * r8.xyz;
  r5.w = dot(r8.xyz, r8.xyz);
  r5.w = sqrt(r5.w);
  r6.w = dot(r8.xyz, r0.xyz);
  r6.w = saturate(r6.w / r5.w);
  r5.w = 1 + -r5.w;
  r5.w = max(0, r5.w);
  r5.w = r6.w * r5.w;
  r8.xyz = cb0[32].xyz + -v6.xyz;
  r8.xyz = cb0[32].www * r8.xyz;
  r6.w = dot(r8.xyz, r8.xyz);
  r6.w = sqrt(r6.w);
  r7.w = dot(r8.xyz, r0.xyz);
  r7.w = saturate(r7.w / r6.w);
  r6.w = 1 + -r6.w;
  r6.w = max(0, r6.w);
  r6.w = r7.w * r6.w;
  r8.xyz = cb0[33].xyz * r6.www;
  r8.xyz = cb0[31].xyz * r5.www + r8.xyz;
  r1.xyz = r1.xyz * r0.www + r8.xyz;
  r1.xyz = r2.xyz * r1.www + r1.xyz;
  r1.xyz = r7.xyz + r1.xyz;
  r0.w = dot(-r0.xyz, cb0[16].xyz);
  r2.xyz = cb0[11].xyz * r0.www + cb0[12].xyz;
  r2.xyz = cb0[1].xyz * r2.xyz;
  r1.xyz = r1.xyz * cb0[0].xyz + r2.xyz;
  r2.xyz = float3(-1,-1,-1) + cb0[3].xyz;
  r2.xyz = r4.www * r2.xyz + float3(1,1,1);
  r0.w = cb0[3].w + -cb0[1].w;
  r0.w = r4.w * r0.w + cb0[1].w;
  r0.w = v1.y * -r0.w + r0.w;
  r1.w = 1 + v1.y;
  r2.xyz = r2.xyz * r1.www;
  r1.w = dot(r0.xyz, -cb0[17].xyz);
  r7.xyz = r3.xyz * r3.www + cb0[17].xyz;
  r5.w = dot(r7.xyz, r7.xyz);
  r5.w = rsqrt(r5.w);
  r7.xyz = r7.xyz * r5.www;
  r5.w = saturate(dot(-r0.xyz, r7.xyz));
  r1.w = saturate(r1.w * 5 + 1);
  r5.w = log2(r5.w);
  r5.w = r5.w * r0.w;
  r5.w = exp2(r5.w);
  r1.w = r5.w * r1.w;
  r5.w = dot(r0.xyz, -cb0[18].xyz);
  r3.xyz = r3.xyz * r3.www + cb0[18].xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r3.x = saturate(dot(-r0.xyz, r3.xyz));
  r3.y = saturate(r5.w * 5 + 1);
  r3.x = log2(r3.x);
  r0.w = r3.x * r0.w;
  r0.w = exp2(r0.w);
  r0.w = r0.w * r3.y;
  r3.xyz = cb0[2].xyz + -r5.xyz;
  r3.xyz = r4.www * r3.xyz + r5.xyz;
  r0.x = dot(r0.xyz, r4.xyz);
  r0.x = 1 + -abs(r0.x);
  r0.y = cmp(r0.x < 0.00999999978);
  r0.x = log2(r0.x);
  r0.x = cb0[4].x * r0.x;
  r0.x = exp2(r0.x);
  r0.x = cb0[4].y * r0.x;
  r0.x = cb0[18].w * r0.x;
  r0.x = r0.y ? 0 : r0.x;
  r4.xyz = t4.Sample(s4_s, w2.xy).xyz;
  r0.xyz = r0.xxx * r4.xyz + r3.xyz;
  r3.x = r1.w * 0.939999998 + 0.0500000007;
  r3.yw = float2(0.5,0.5);
  r4.xyz = t3.Sample(s3_s, r3.xy).xyz;
  r1.w = r2.w * 0.75 + 0.25;
  r5.xyz = cb0[8].xyz * r1.www;
  r5.xyz = r6.xyz * r5.xyz;
  r4.xyz = r5.xyz * r4.xyz;
  r4.xyz = max(float3(0,0,0), r4.xyz);
  r4.xyz = r4.xyz * r2.xyz;
  r0.xyz = r0.xyz * r1.xyz + r4.xyz;
  r3.z = r0.w * 0.939999998 + 0.0500000007;
  r1.xyz = t3.Sample(s3_s, r3.zw).xyz;
  r3.xyz = cb0[9].xyz * r6.xyz;
  r1.xyz = r3.xyz * r1.xyz;
  r1.xyz = max(float3(0,0,0), r1.xyz);
  r0.xyz = r1.xyz * r2.xyz + r0.xyz;
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
    r0.y = t8.Load(r1.xyz).x;
    r0.z = 1 << (int)r0.z;
    r0.y = (int)r0.z & (int)r0.y;
    r0.y = min(1, (uint)r0.y);
    r0.y = (int)-r0.y + 1;
  }
  r0.x = r0.x ? r0.y : 0;
  if (r0.x != 0) discard;
  return;
}