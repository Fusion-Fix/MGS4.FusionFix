#include <common.hxx>

import common;

void Init()
{
	//FusionFix::onGameInitEvent()
	//FusionFix::onGameProcessEvent()
	
    FusionFix::onInitEvent().executeAll();

    static auto futures = FusionFix::onInitEventAsync().executeAllAsync();

    FusionFix::onGameInitEvent() += []()
    {
        for (auto& f : futures.get())
            f.wait();
        futures.get().clear();
    };
}

extern "C"
{
    void __declspec(dllexport) InitializeASI()
    {
        std::call_once(CallbackHandler::flag, []()
        {
            // Replace the pattern below with one that reliably appears in the target executable:
            CallbackHandler::RegisterCallbackAtGetSystemTimeAsFileTime(Init, hook::pattern(""));
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
