# {{PROJECT_NAME}}

> A fix/enhancement mod for [Game Name].

## Installation

1. Download the latest release from the [Releases]({{REPO_URL}}/releases/latest) page.
2. Extract the archive into the game root directory.
3. Launch the game.

## Building from Source

Requirements:
- Visual Studio 2022 or 2026 (with C++ desktop workload)
- Git (for submodule checkout)

```bat
git clone --recurse-submodules {{REPO_URL}}
cd {{PROJECT_NAME}}
premake5.bat
```

Open `build/{{PROJECT_NAME}}.slnx` in Visual Studio and build.

## Contributing

Pull requests are welcome. Please open an issue first to discuss what you would like to change.
See [contributing.md](contributing.md) for workflow and reverse-engineering note conventions.

## License

[{{LICENSE_SPDX}}](license)