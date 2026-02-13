from conan import ConanFile

class EngineRecipe(ConanFile):
    name = "aeri"
    version = "0.1"

    settings = "os", "compiler", "build_type", "arch"

    requires = (
               "fmt/10.2.1",
               "gtest/1.14.0",
               "pybind11/2.11.1",
            )

    generators = "CMakeDeps", "CMakeToolchain"

