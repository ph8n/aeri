# AERI

## C++ Tooling Setup (clangd, clang-format, clang-tidy)

### 1) Install toolchain

 - llvm 
 - cmake
 - ninja 
 - conan

### 2) Configure the project

```bash
cmake --preset dev
```

This configures an out-of-tree build in `../aeri-build` (derived from the repo name via presets) and writes `compile_commands.json` there. The repo-root `compile_commands.json` symlink points to that file for clangd.

### 3) Build

```bash
cmake --build --preset dev
```

### 4) Run formatter

```bash
cmake --build --preset dev --target clang-format
```

### 5) Run clang-tidy (manual target)

```bash
cmake --build --preset dev --target clang-tidy
```

### 6) Enable compile-time clang-tidy checks (optional)

```bash
cmake --preset tidy
cmake --build --preset tidy
```

That uses `AERI_ENABLE_CLANG_TIDY=ON` so CMake runs clang-tidy during target builds.
