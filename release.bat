call tools\EmbedPDB\EmbedPDB.exe bin\Release\{{PROJECT_NAME}}{{TARGET_EXTENSION}}

powershell -NoProfile -ExecutionPolicy Bypass -File "sign.ps1" -SearchPaths ".\bin\Release\{{PROJECT_NAME}}{{TARGET_EXTENSION}}"

copy bin\Release\{{PROJECT_NAME}}{{TARGET_EXTENSION}} data\plugins\{{PROJECT_NAME}}{{TARGET_EXTENSION}}

7z a "{{PROJECT_NAME}}.zip" ".\data\*" ^
-xr!*\.gitkeep
