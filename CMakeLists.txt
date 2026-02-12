cmake_minimum_required(VERSION 3.25)

project(aeris LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(cmake/AerisOptions.cmake)

enable_testing()

set(AERIS_SUBDIRECTORIES
    core
)

foreach(subdir ${AERIS_SUBDIRECTORIES})
    add_subdirectory(${subdir})
endforeach()
