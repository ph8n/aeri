# AERIS

## C++ Tooling Setup (clangd, clang-format, clang-tidy)

### 1) Install toolchain

macOS (Homebrew):

```bash
brew install llvm cmake ninja conan
```

Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y clangd clang-format clang-tidy cmake ninja-build conan
```

### 2) Configure the project

```bash
cmake --preset dev
```

This generates `build/compile_commands.json`, and `.clangd` is configured to use that path.

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

That uses `AERIS_ENABLE_CLANG_TIDY=ON` so CMake runs clang-tidy during target builds.
