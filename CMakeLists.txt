cmake_minimum_required(VERSION 3.25)

project(aeri LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(cmake/AeriOptions.cmake)

enable_testing()

set(AERI_SUBDIRECTORIES
    core
)

foreach(subdir ${AERI_SUBDIRECTORIES})
    add_subdirectory(${subdir})
endforeach()
