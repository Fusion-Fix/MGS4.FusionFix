#pragma once
#define NOMINMAX
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#include <subauth.h>
#include "IniReader.h"
#include "injector/injector.hpp"
#include "injector/calling.hpp"
#include "injector/hooking.hpp"
#include "injector/assembly.hpp"
#include "injector/utility.hpp"
#include "Hooking.Patterns.h"
#include "ModuleList.hpp"
#include <thread>
#include <mutex>
#include <set>
#include <map>
#include <iomanip>
#include <array>
#include <future>
#include <string>
#include <filesystem>
#include <span>
#include <vector>
#include <string_view>
#include <filesystem>
#include <stacktrace>
#include <variant>
#include <unordered_map>
#include <fstream>

#include "bgfx/bgfx.h"

#include <d3d11.h>
#include <dxgi.h>
#include <d3dcompiler.h>
#include <wrl/client.h>
using Microsoft::WRL::ComPtr;

namespace fs = std::filesystem;