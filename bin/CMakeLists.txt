#rd /Q /S .tmp & cmake -A Win32 -B .tmp && cmake --build .tmp --target install --config Release
#rm -rf .tmp   ; cmake -A Win32 -B .tmp && cmake --build .tmp --target install --config Release

cmake_minimum_required(VERSION 3.28)

project(Prokas_CEF_ImportLib)

set(CefDir "../src")
set(IncDir "${CefDir}/include")

file(GLOB_RECURSE Hdr CONFIGURE_DEPENDS ${IncDir}/*)

add_library(Prokas_libcef SHARED IMPORTED GLOBAL)
set_target_properties(Prokas_libcef PROPERTIES
    #IMPORTED_LOCATION                   ${CMAKE_CURRENT_SOURCE_DIR}/rel/libcef.dll
    IMPORTED_LOCATION                   ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef.dll
    IMPORTED_LOCATION_DEBUG             ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef.dll
    #IMPORTED_LOCATION_RELWITHDEBINFO    ${CMAKE_CURRENT_SOURCE_DIR}/FreeImage.dll
    IMPORTED_IMPLIB                     ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef.lib
    IMPORTED_IMPLIB_DEBUG               ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef.lib
    #IMPORTED_SONAME                     ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef.lib
    #IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
)
set_property(TARGET Prokas_libcef APPEND PROPERTY PUBLIC_HEADER ${Hdr})
target_include_directories(Prokas_libcef BEFORE INTERFACE ${CefDir})

########

add_library(Prokas_libcef_dll_wrapper STATIC IMPORTED GLOBAL)
set_target_properties(Prokas_libcef_dll_wrapper PROPERTIES
    IMPORTED_LOCATION                   ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef_dll_wrapper.lib
    IMPORTED_LOCATION_DEBUG             ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef_dll_wrapper.lib
    IMPORTED_IMPLIB                     ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef_dll_wrapper.lib
    IMPORTED_IMPLIB_DEBUG               ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef_dll_wrapper.lib
)
set_property(TARGET Prokas_libcef_dll_wrapper APPEND PROPERTY PUBLIC_HEADER ${Hdr})
target_include_directories(Prokas_libcef_dll_wrapper BEFORE INTERFACE ${CefDir})
