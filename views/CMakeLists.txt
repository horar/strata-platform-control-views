##
## Copyright (c) 2018-2022 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##
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