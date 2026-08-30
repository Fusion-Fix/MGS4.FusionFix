# MGS4.FusionFix

> A fix/enhancement mod for Metal Gear Solid 4: Guns of the Patriots.

## Disclaimer

Only works with D3D11 renderer for now.

## Installation

1. Download the latest release from the [Releases](https://github.com/Fusion-Fix/MGS4.FusionFix/releases/latest) page.
2. Extract the archive into the game root directory.
3. Launch the game.

## Building from Source

Requirements:
- Visual Studio 2022 or 2026 (with C++ desktop workload)
- Git (for submodule checkout)

```bat
git clone --recurse-submodules https://github.com/Fusion-Fix/MGS4.FusionFix
cd MGS4.FusionFix
premake5.bat
```

Open `build/MGS4.FusionFix.slnx` in Visual Studio and build.

## Contributing

Pull requests are welcome. Please open an issue first to discuss what you would like to change.
See [contributing.md](contributing.md) for workflow and reverse-engineering note conventions.

## License

[MIT](license)