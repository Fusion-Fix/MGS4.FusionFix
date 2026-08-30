call tools\EmbedPDB\EmbedPDB.exe bin\Release\MGS$.FusionFix.asi


copy bin\Release\MGS$.FusionFix.asi data\plugins\MGS$.FusionFix.asi

7z a "MGS$.FusionFix.zip" ".\data\*" ^
-xr!*\.gitkeep
