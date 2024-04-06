# MCGLSL

Makefile and convenient setup for building Minecraft GLSL shader resource packs.

## Directory structure

```
.
├── LICENSE
├── m4
│   ├── custom.m4
│   └── vendor.m4
├── Makefile
├── README.md
└── src
    ├── include
    └── root
        ├── assets
        │   └── minecraft
        │       ├── shaders
        │       │   ├── core
        │       │   ├── include
        │       │   ├── post
        │       │   └── program
        │       └── textures
        │           └── effect
        └── pack.mcmeta
```

`m4` contains GNU M4 scripts that are prepended as input files for every M4 call. You can create more of them, but basic template contains only 2 files: `vendor` for repository default M4 macros and `custom` for user own macros.

`src/include` is an include dir that GNU M4 uses when building. Put Your shared logic here. If there is a logic that is used in both core and post shaders You should create a file under `src/include` and an additional file under `minecraft/shaders/include` with ```include(`your_file.glsl')``` line.

> [!WARNING]
> Directories contain the .gitkeep files so they're added to git properly. Remove it, otherwise it
> will be copied right to your resource-pack zip.

## Macro processing

Macros are proccesed by GNU M4. You can override the flags via `M4_FLAGS` env variable.

## License and contributing

Licensed under MIT. Contribute via PR, issues and discussions.
