#include <common.hxx>

import common;

#define SHADOW_SAMPLE_COUNT 8


namespace DisableBlurShader
{
#include "DisableBlur-ps.h"
}

bool g_bSkipIntro = true;

float g_fDynamicResolutionOverride = 0.0f;

float g_fShadowTexelOverride = 0.0f;
int g_nShadowResOverride = 0;

float g_fShadowSampleCountOverride[4] = { SHADOW_SAMPLE_COUNT , SHADOW_SAMPLE_COUNT , SHADOW_SAMPLE_COUNT , SHADOW_SAMPLE_COUNT };

static safetyhook::InlineHook CreatePixelShaderHook;

struct ShaderData {
    ComPtr<ID3DBlob> shaderBlob = nullptr;
    std::array<uint32_t, 4> shaderHash = {};
};

std::vector<ShaderData> ShaderDataMap;

void* GetPattern(std::string_view pattern, ptrdiff_t offset = 0)
{
    return hook::pattern(pattern).get_first(offset);
}

HRESULT __stdcall CreatePixelShader(ID3D11Device* pDevice,
    const void* pShaderBytecode,
    size_t BytecodeLength,
    ID3D11ClassLinkage* pClassLinkage,
    ID3D11PixelShader** ppPixelShader)
{
    std::array<uint32_t, 4> hash;
    memcpy(hash.data(), (char*)pShaderBytecode + 0x4, 16);
    for (auto& ShaderData : ShaderDataMap) {
        if (memcmp(ShaderData.shaderHash.data(), hash.data(), 16) == 0) {
            pShaderBytecode = ShaderData.shaderBlob->GetBufferPointer();
            BytecodeLength = ShaderData.shaderBlob->GetBufferSize();
            break;
        }
    }

    HRESULT hr = CreatePixelShaderHook.unsafe_stdcall<HRESULT>(pDevice, pShaderBytecode, BytecodeLength, pClassLinkage, ppPixelShader);

    return hr;
}

// thanks to ermaccer https://github.com/ermaccer/MK11Hook
bool DoDXHook()
{
    HWND hWnd = GetDesktopWindow();

    ID3D11Device* device = nullptr;
    ID3D11DeviceContext* context = nullptr;
    IDXGISwapChain* swapChain = nullptr;

    DXGI_SWAP_CHAIN_DESC swapChainDescription;
    ZeroMemory(&swapChainDescription, sizeof(DXGI_SWAP_CHAIN_DESC));

    D3D_FEATURE_LEVEL featureLevel = D3D_FEATURE_LEVEL_11_0;

    swapChainDescription.OutputWindow = hWnd;
    swapChainDescription.Windowed = true;

    swapChainDescription.BufferCount = 1;
    swapChainDescription.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM; // >= 9.1
    swapChainDescription.BufferDesc.Scaling = DXGI_MODE_SCALING_UNSPECIFIED;
    swapChainDescription.BufferDesc.ScanlineOrdering = DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED;
    swapChainDescription.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
    swapChainDescription.SwapEffect = DXGI_SWAP_EFFECT_DISCARD;
    swapChainDescription.SampleDesc.Count = 1;

    HRESULT hResult = D3D11CreateDeviceAndSwapChain(nullptr, D3D_DRIVER_TYPE_NULL, nullptr, 0, &featureLevel, 1,
        D3D11_SDK_VERSION, &swapChainDescription, &swapChain, &device, nullptr, &context);

    uintptr_t* deviceVtable = *reinterpret_cast<uintptr_t**>(device);
    uintptr_t* contextVtable = *reinterpret_cast<uintptr_t**>(context);
    uintptr_t* swapChainVtable = *reinterpret_cast<uintptr_t**>(swapChain);

    uintptr_t pSetPixelShader = contextVtable[9];
    uintptr_t pCreatePixelShader = deviceVtable[15];
    uintptr_t pCreateVertexShader = deviceVtable[12];
    uintptr_t pPresent = swapChainVtable[8];
    uintptr_t pDrawIndexed = contextVtable[12];
    uintptr_t pCreateTexture2D = deviceVtable[5];

    CreatePixelShaderHook = safetyhook::create_inline(pCreatePixelShader, CreatePixelShader);

    device->Release();
    swapChain->Release();
    context->Release();

    return true;
}


std::array<uint32_t, 4> GetHashIntegerFromString(std::string_view hash)
{
    std::array<uint32_t, 4> hashInteger;
    sscanf(hash.data(), "%8x-%8x-%8x-%8x", &hashInteger[0], &hashInteger[1], &hashInteger[2], &hashInteger[3]);
    return hashInteger;
}

void LoadAllReplacedShaders()
{
    if (!fs::exists("ReplacedShadersPS"))
        return;

    for (auto it : fs::directory_iterator("ReplacedShadersPS"))
    {
        if (!fs::is_regular_file(it))
            continue;

        std::string extension = it.path().extension().string();
        std::string hash = it.path().stem().string();

        auto& shaderData = ShaderDataMap.emplace_back();
        shaderData.shaderHash = GetHashIntegerFromString(hash);
        ComPtr<ID3DBlob>& shaderBlob = shaderData.shaderBlob;

        if (extension == ".hlsl") {
            ComPtr<ID3DBlob> errorBlob;

            HRESULT hr = D3DCompileFromFile(
                it.path().native().c_str(),
                nullptr,
                D3D_COMPILE_STANDARD_FILE_INCLUDE,
                "main",
                "ps_5_0",
                D3DCOMPILE_OPTIMIZATION_LEVEL3,
                0,
                &shaderBlob,
                &errorBlob
            );

            if (FAILED(hr))
            {
                if (errorBlob)
                    OutputDebugStringA((const char*)errorBlob->GetBufferPointer());
                continue;
            }
        }
        else if (extension == ".compiled") {
            std::ifstream file(it.path(), std::ios::binary);
            
            file.seekg(0, std::ios::end);
            size_t size = file.tellg();
            D3DCreateBlob(size, &shaderBlob);
            file.seekg(0, std::ios::beg);
            file.read((char*)shaderBlob->GetBufferPointer(), size);
        }
    }
}

void LoadIniSettings()
{
    CIniReader ini("");

    g_bSkipIntro = ini.ReadBoolean("MAIN", "SkipIntro", false);
    g_fDynamicResolutionOverride = ini.ReadFloat("MAIN", "DynamicResolutionOverride", 0.0f);
    g_fShadowTexelOverride = ini.ReadFloat("MAIN", "ShadowTexelOverride", 0.0f);
    g_nShadowResOverride = ini.ReadInteger("MAIN", "ShadowResolutionOverride", 0);
}

void Init()
{
    LoadIniSettings();

    DoDXHook();
    LoadAllReplacedShaders();

    void* addr = nullptr;

    if (g_bSkipIntro) {
        addr = GetPattern("0F B6 0D ? ? ? ? 84 C0");
        static auto SkipIntroHook = safetyhook::create_mid(addr, +[](SafetyHookContext& regs)
            {
                regs.rax = 2;
            });
    }

    if (g_fDynamicResolutionOverride > 0.0f) {
        addr = GetPattern("F3 0F 10 05 ? ? ? ? C3 CC CC CC CC CC CC CC 0F B6 05");
        static auto DisableDynamicResolutionHook = safetyhook::create_inline(addr, +[]
            {
                return g_fDynamicResolutionOverride;
            });

        if (g_fDynamicResolutionOverride == 1.0f) {
            auto& shaderData = ShaderDataMap.emplace_back();
            shaderData.shaderHash = GetHashIntegerFromString("9ba7e7b6-1e974232-85b4be48-4513879c");
            D3DCreateBlob(sizeof(DisableBlurShader::g_main), &shaderData.shaderBlob);
            memcpy(shaderData.shaderBlob->GetBufferPointer(), DisableBlurShader::g_main, sizeof(DisableBlurShader::g_main));
        }
    }

    if (g_nShadowResOverride > 0) {
        addr = GetPattern("33 D2 8D 4A ? E9 ? ? ? ? CC CC CC CC CC CC 48 83 EC ? 48 8D 54 24 ? C7 44 24 ? ? ? ? ? 48 8D 0D ? ? ? ? E8 ? ? ? ? 8B 00 48 83 C4 ? C3 CC CC CC CC CC CC CC CC CC CC CC CC 33 D2");
        static auto ShadowResHook = safetyhook::create_inline(addr, +[]()->int
            {
                return g_nShadowResOverride;
            });
    }

    if (g_fShadowSampleCountOverride[0] > 0.0f) {
        addr = GetPattern("41 B8 ? ? ? ? E8 ? ? ? ? F7 05 ? ? ? ? ? ? ? ? 74 ? 0F B7 0D ? ? ? ? 48 8D 15 ? ? ? ? 41 B8 ? ? ? ? E8 ? ? ? ? 48 C7 05");
        static auto ShadowFilteringHook1 = safetyhook::create_mid(addr, +[](SafetyHookContext& regs)
            {
                regs.rdx = (uintptr_t)&g_fShadowSampleCountOverride;
            });
    }

    if (g_fShadowTexelOverride >= 0.0f) {
        addr = GetPattern("8D 04 09 48 63 C8 48 8D 05 ? ? ? ? 0F 2E 8C 88");
        static auto ShadowFilteringHook2 = safetyhook::create_mid(addr, +[](SafetyHookContext& regs)
            {
                regs.xmm1.f32[0] = g_fShadowTexelOverride;
                regs.xmm2.f32[0] = g_fShadowTexelOverride / 2.0f;
            });
    }
}

extern "C"
{
    void __declspec(dllexport) InitializeASI()
    {
        std::call_once(CallbackHandler::flag, []()
        {
            Init();
        });
    }
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD reason, LPVOID lpReserved)
{
    if (reason == DLL_PROCESS_ATTACH)
    {
        if (!IsUALPresent()) { InitializeASI(); }
    }
    if (reason == DLL_PROCESS_DETACH)
    {
        FusionFix::onShutdownEvent().executeAll();
    }
    return TRUE;
}


// all this is for later

/*struct bgfx__RendererContextIVtbl // sizeof=0x160
{
    void *destructor_00;
    void *getRendererType;
    void *getRendererName;
    void *isDeviceRemoved;              // XREF: sub_140772290+7B/r
                                        // sub_140772290+83/o ...
    void *flip;                         // XREF: sub_140772290+122/w
                                        // sub_140772290:loc_1407723CA/o ...
    void *createIndexBuffer;            // XREF: sub_140772290+141/w
    void *destroyIndexBuffer;           // XREF: sub_140772290+F7/r
                                        // sub_140772290+FF/o ...
    void *createVertexLayout;           // XREF: sub_140776C60+3B/w
                                        // sub_140776C60:loc_140776D04/w ...
    void *destroyVertexLayout;          // XREF: sub_14077C250:loc_14077CD33/o
    void *createVertexBuffer;
    void *destroyVertexBuffer;
    void *createDynamicIndexBuffer;
    void *updateDynamicIndexBuffer;
    void *destroyDynamicIndexBuffer;
    void *createDynamicVertexBuffer;
    void *updateDynamicVertexBuffer;
    void *destroyDynamicVertexBuffer;
    void *createShader;
    void *destroyShader;
    void *createProgram;
    void *destroyProgram;
    void *createTexture;
    void *updateTextureBegin;
    void *updateTexture;
    void *updateTextureEnd;
    void *readTexture;
    void *resizeTexture;
    void *overrideInternal;
    void *getInternal;
    void *destroyTexture;
    void *createFrameBuffer_Attachment;
    void *createFrameBuffer_Nwh;
    void *destroyFrameBuffer;
    void *createUniform;
    void *destroyUniform;
    void *requestScreenShot;
    void *updateViewName;
    void *updateUniform;
    void *invalidateOcclusionQuery;
    void *setMarker;
    void *setName;
    void *submit;
    void *blitSetup;
    void *blitRender;
};

struct bgfx__RendererContext // sizeof=0x8
{
    bgfx__RendererContextIVtbl* vtbl;
};

struct bgfx__Context // sizeof=0x4C12CC0
{                                       // XREF: .data:bgfx__s_ctx/r
    uint8_t unknown1[79766600];         // XREF: .text:000000014075773E/r
                                        // .text:000000014075775A/r ...
    bgfx__RendererContext *RendererContext;
    uint8_t unknown2[2160];
};*/

/*               addr = GetPattern("48 89 5C 24 20 57 48 83 EC 20 80 B9 52 24 C1 04 00");
static auto context = safetyhook::create_mid(addr, +[](SafetyHookContext& regs)
    {
        bgfx__Context* context = (bgfx__Context*)regs.rcx;
        int a = 1;
    });*/