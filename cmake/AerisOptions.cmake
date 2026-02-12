option(AERIS_ENABLE_CLANG_TIDY "Enable clang-tidy while compiling C++ targets." OFF)
option(AERIS_ENABLE_CLANG_TOOL_TARGETS "Enable clang-format and clang-tidy helper targets." ON)

find_program(CLANG_FORMAT_BIN NAMES clang-format)
find_program(CLANG_TIDY_BIN NAMES clang-tidy)

if(AERIS_ENABLE_CLANG_TIDY)
    if(CLANG_TIDY_BIN)
        set(CMAKE_CXX_CLANG_TIDY
            "${CLANG_TIDY_BIN}"
            "--config-file=${CMAKE_SOURCE_DIR}/.clang-tidy"
        )
        message(STATUS "clang-tidy enabled: ${CLANG_TIDY_BIN}")
    else()
        message(WARNING "AERIS_ENABLE_CLANG_TIDY is ON, but clang-tidy was not found in PATH.")
    endif()
endif()

if(AERIS_ENABLE_CLANG_TOOL_TARGETS)
    set(AERIS_SOURCE_DIRS
        "${CMAKE_SOURCE_DIR}/rt"
        "${CMAKE_SOURCE_DIR}/core"
        "${CMAKE_SOURCE_DIR}/indicators"
        "${CMAKE_SOURCE_DIR}/data"
        "${CMAKE_SOURCE_DIR}/risk"
        "${CMAKE_SOURCE_DIR}/strategy"
        "${CMAKE_SOURCE_DIR}/backtest"
        "${CMAKE_SOURCE_DIR}/exec"
        "${CMAKE_SOURCE_DIR}/python"
        "${CMAKE_SOURCE_DIR}/tools"
        "${CMAKE_SOURCE_DIR}/test"
        "${CMAKE_SOURCE_DIR}/bench"
    )

    set(AERIS_FORMAT_FILES)
    set(AERIS_TIDY_FILES)
    foreach(dir IN LISTS AERIS_SOURCE_DIRS)
        if(EXISTS "${dir}")
            file(
                GLOB_RECURSE DIR_FORMAT_FILES CONFIGURE_DEPENDS
                "${dir}/*.h"
                "${dir}/*.hh"
                "${dir}/*.hpp"
                "${dir}/*.hxx"
                "${dir}/*.c"
                "${dir}/*.cc"
                "${dir}/*.cpp"
                "${dir}/*.cxx"
            )
            file(
                GLOB_RECURSE DIR_TIDY_FILES CONFIGURE_DEPENDS
                "${dir}/*.c"
                "${dir}/*.cc"
                "${dir}/*.cpp"
                "${dir}/*.cxx"
            )
            list(APPEND AERIS_FORMAT_FILES ${DIR_FORMAT_FILES})
            list(APPEND AERIS_TIDY_FILES ${DIR_TIDY_FILES})
        endif()
    endforeach()

    list(REMOVE_DUPLICATES AERIS_FORMAT_FILES)
    list(REMOVE_DUPLICATES AERIS_TIDY_FILES)

    if(CLANG_FORMAT_BIN)
        if(AERIS_FORMAT_FILES)
            add_custom_target(
                clang-format
                COMMAND "${CLANG_FORMAT_BIN}" -i ${AERIS_FORMAT_FILES}
                WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
                COMMENT "Formatting C/C++ sources with clang-format"
                VERBATIM
            )
        else()
            add_custom_target(
                clang-format
                COMMAND ${CMAKE_COMMAND} -E echo "No C/C++ files found to format."
            )
        endif()
    else()
        message(STATUS "clang-format not found; clang-format target will not be created.")
    endif()

    if(CLANG_TIDY_BIN)
        if(AERIS_TIDY_FILES)
            add_custom_target(
                clang-tidy
                COMMAND
                    "${CLANG_TIDY_BIN}"
                    --config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
                    -p "${CMAKE_BINARY_DIR}"
                    ${AERIS_TIDY_FILES}
                WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
                COMMENT "Running clang-tidy over translation units"
                VERBATIM
            )
        else()
            add_custom_target(
                clang-tidy
                COMMAND ${CMAKE_COMMAND} -E echo "No C/C++ translation units found for clang-tidy."
            )
        endif()
    else()
        message(STATUS "clang-tidy not found; clang-tidy target will not be created.")
    endif()
endif()
