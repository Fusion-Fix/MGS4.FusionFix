Texture2D<float4> t0 : register(t0);
SamplerState s0 : register(s0);

cbuffer cb0 : register(b0)
{
    float4 cb0_0 : packoffset(c0);
    float4 cb0_1 : packoffset(c1);
    float4 cb0_2 : packoffset(c2);
};

struct PSInput
{
    float4 pos : SV_Position;
    float2 uv : TEXCOORD0; // v1.xy
};

float4 main(PSInput IN) : SV_Target
{
    float2 r0;

    r0 = 1.0 / cb0_0.xy;
    r0 = cb0_2.xx - r0;

    float2 delta = IN.uv - cb0_1.xy;
    float2 uv = delta * r0 + cb0_1.xy;

    float2 texDim;
    t0.GetDimensions(texDim.x, texDim.y);
    
    uv = (floor(uv * texDim) + 0.5) / texDim;
    
    float3 texSample = t0.Sample(s0, uv).rgb;

    return float4(texSample, 1.0);
}