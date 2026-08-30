newoption {
    trigger     = "with-version",
    value       = "STRING",
    description = "Current version",
}

workspace "{{PROJECT_NAME}}"
   configurations { "Release", "Debug" }
   architecture "{{ARCHITECTURE}}"
   location "build"
   cppdialect "C++latest"
   targetdir "bin/%{cfg.buildcfg}"
   buildoptions { "/dxifcInlineFunctions- /Zc:__cplusplus /utf-8" }
   staticruntime "On"
   multiprocessorcompile ("On")
   startproject "{{PROJECT_NAME}}"

   local major = os.date("%d")
   local minor = os.date("%m")
   local build = os.date("%Y")
   local revision = os.date("%H") .. os.date("%M")

   if _OPTIONS["with-version"] then
      local t = {}
      for i in _OPTIONS["with-version"]:gmatch("([^.]+)") do
         t[#t + 1], _ = i:gsub("%D+", "")
      end
      while #t < 4 do t[#t + 1] = 0 end
      major    = math.min(tonumber(t[1]), 255)
      minor    = math.min(tonumber(t[2]), 255)
      build    = math.min(tonumber(t[3]), 65535)
      revision = math.min(tonumber(t[4]), 65535)
   end

   local githash = ""
   local f = io.popen("git rev-parse --short HEAD")
   if f then
      githash = f:read("*a"):gsub("%s+", "")
      f:close()
   end

   local productVersion = major .. "." .. minor .. "." .. build .. "." .. revision
   if githash ~= "" then
      productVersion = productVersion .. "-" .. githash
   end

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

   filter {}

   pbcommands = {
      "setlocal EnableDelayedExpansion",
      "set file=$(TargetPath)",
      "FOR %%i IN (\"%file%\") DO (",
      "set filename=%%~ni",
      "set fileextension=%%~xi",
      "set target=!path!!filename!!fileextension!",
      "if exist \"!target!\" copy /y \"!file!\" \"!target!\"",
      ")" }

   function setpaths (gamepath, exepath, scriptspath)
      scriptspath = scriptspath or "scripts/"
      if (gamepath) then
         cmdcopy = { "set \"path=" .. gamepath .. scriptspath .. "\"" }
         table.insert(cmdcopy, pbcommands)
         postbuildcommands (cmdcopy)
         debugdir (gamepath)
         if (exepath) then
            debugcommand (gamepath .. exepath)
            dir, file = exepath:match'(.*/)(.*)'
            debugdir (gamepath .. (dir or ""))
         end
      end
      targetdir ("bin/%{cfg.buildcfg}")
   end

project "{{PROJECT_NAME}}"
   kind "{{OUTPUT_KIND}}"
   language "C++"
   targetdir "bin/%{cfg.buildcfg}"
   targetextension "{{TARGET_EXTENSION}}"
   characterset ("Unicode")

   defines { "rsc_CompanyName=\"{{PROJECT_NAME}}\"" }
   defines { "rsc_LegalCopyright=\"{{LICENSE_SPDX}}\""}
   defines { "rsc_InternalName=\"%{prj.name}\"", "rsc_ProductName=\"%{prj.name}\"", "rsc_OriginalFilename=\"%{cfg.buildtarget.name}\"" }
   defines { "rsc_FileDescription=\"{{PROJECT_NAME}}\"" }
   defines { "rsc_UpdateUrl=\"{{REPO_URL}}\"" }
   defines { "rsc_FileVersion_MAJOR=" .. major }
   defines { "rsc_FileVersion_MINOR=" .. minor }
   defines { "rsc_FileVersion_BUILD=" .. build }
   defines { "rsc_FileVersion_REVISION=" .. revision }
   defines { "rsc_FileVersion=\"" .. major .. "." .. minor .. "." .. build .. "\"" }
   defines { "rsc_ProductVersion=\"" .. productVersion .. "\"" }
   defines { "rsc_GitSHA1=\"" .. githash .. "\"" }
   defines { "rsc_GitSHA1W=L\"" .. githash .. "\"" }
   defines { "_CRT_SECURE_NO_WARNINGS" }

   includedirs { "source" }
   includedirs { "source/includes" }
   files { "source/**.h", "source/**.hpp", "source/**.cpp", "source/**.hxx", "source/**.ixx" }
   files { "source/resources/Versioninfo.rc" }

   -- ##BEGIN_EXTERNAL_SUBMODULES## (managed by setup.py - do not edit this line)
   -- ##END_EXTERNAL_SUBMODULES## (managed by setup.py - do not edit this line)

   -- Set game install path here for local debugging (not committed):
   -- setpaths("C:/Games/GameName/", "Game.exe", "plugins/")
