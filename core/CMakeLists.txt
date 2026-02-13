add_library(aeri_core
  src/engine.cpp
  src/portfolio.cpp
  src/clock.cpp
)

target_include_directories(aeri_core PUBLIC include)

add_subdirectory(test)
