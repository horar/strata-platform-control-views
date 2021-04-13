cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

project(component-views
    LANGUAGES NONE
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake/Modules")

include(AddViewMacro)
include(FeatureSummary)
include(CMakeDependentOption)
include(GitVersionMacro)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_VIEWS_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/views")
file(MAKE_DIRECTORY "${CMAKE_VIEWS_OUTPUT_DIRECTORY}")

option(APPS_VIEWS "Build Strata 'control-view' components" ON)
add_feature_info(APPS_VIEWS APPS_VIEWS "Build Strata 'control-view' components")


find_package(Qt5 ${VERSION_QT5}
    COMPONENTS Core
    REQUIRED
)

file(GLOB VIEW_FOLDERS *)
foreach(VIEW_DIR ${VIEW_FOLDERS})
    if(IS_DIRECTORY ${VIEW_DIR} AND EXISTS "${VIEW_DIR}/CMakeLists.txt")
        get_filename_component(VIEW_NAME ${VIEW_DIR} NAME_WE)
        add_subdirectory(${VIEW_NAME})
    endif()
endforeach()
