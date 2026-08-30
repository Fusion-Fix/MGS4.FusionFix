call tools\EmbedPDB\EmbedPDB.exe bin\Release\MGS4.FusionFix.asi


copy bin\Release\MGS4.FusionFix.asi data\plugins\MGS4.FusionFix.asi

7z a "MGS4.FusionFix.zip" ".\data\*" ^
-xr!*\.gitkeep
