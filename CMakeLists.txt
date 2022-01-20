##
## Copyright (c) 2018-2022 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##
cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

project(component-views
    LANGUAGES NONE
)

if(NOT DEFINED CMAKE_MODULE_PATH)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/strata-cmake-modules/Modules")
    include(FeatureSummary)
    include(CMakeDependentOption)
    include(GitVersionMacro)
    include(AddQmlImportPathMacro)
endif()

include(AddViewMacro)

find_package(Git)
if(NOT Git_FOUND)
    message(FATAL_ERROR "'git' program not found")
endif()

if(NOT DEFINED CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
endif()

file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_VIEWS_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/views")
file(MAKE_DIRECTORY "${CMAKE_VIEWS_OUTPUT_DIRECTORY}")

add_subdirectory(views)
