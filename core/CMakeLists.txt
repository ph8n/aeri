add_library(aeris_core
  src/engine.cpp
  src/portfolio.cpp
  src/clock.cpp
)

target_include_directories(aeris_core PUBLIC include)

add_subdirectory(test)
