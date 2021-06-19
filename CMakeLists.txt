cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

project(component-views
    LANGUAGES NONE
)
if(NOT DEFINED CMAKE_MODULE_PATH)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/strata-cmake-modules/Modules")
    include(FeatureSummary)
    include(CMakeDependentOption)
    include(GitVersionMacro)
endif()

include(AddViewMacro)

if(NOT DEFINED CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
endif()

file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_VIEWS_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/views")
file(MAKE_DIRECTORY "${CMAKE_VIEWS_OUTPUT_DIRECTORY}")

add_subdirectory(views)
