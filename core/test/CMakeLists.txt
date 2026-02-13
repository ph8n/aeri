find_package(GTest CONFIG REQUIRED)

add_executable(core_tests
  sanity_check.cpp
)

target_link_libraries(core_tests
  aeri_core
  GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(core_tests)

