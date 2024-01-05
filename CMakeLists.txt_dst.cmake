#USAGE (in a project using CEF):
#   add_subdirectory("thisDir" ProkasCefImportLibs)
#   target_link_libraries(${PROJECT_NAME} PRIVATE ProkasCefImportLibs_libcef ProkasCefImportLibs_libcef_dll_wrapper)

cmake_minimum_required(VERSION 3.28)

project(ProkasCefImportLibs)

#set(CefDir "../src")
#set(IncDir "inc")

file(GLOB_RECURSE Hdr CONFIGURE_DEPENDS "include")

add_library(ProkasCefImportLibs_libcef SHARED IMPORTED GLOBAL)
set_target_properties(ProkasCefImportLibs_libcef PROPERTIES
    #IMPORTED_LOCATION                   ${CMAKE_CURRENT_SOURCE_DIR}/rel/libcef.dll
    IMPORTED_LOCATION                   ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef.dll
    IMPORTED_LOCATION_DEBUG             ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef.dll
    #IMPORTED_LOCATION_RELWITHDEBINFO    ${CMAKE_CURRENT_SOURCE_DIR}/FreeImage.dll
    IMPORTED_IMPLIB                     ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef.lib
    IMPORTED_IMPLIB_DEBUG               ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef.lib
    #IMPORTED_SONAME                     ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef.lib
    #IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
)
set_property(TARGET ProkasCefImportLibs_libcef APPEND PROPERTY PUBLIC_HEADER ${Hdr})
target_include_directories(ProkasCefImportLibs_libcef BEFORE INTERFACE ".")

########

add_library(ProkasCefImportLibs_libcef_dll_wrapper STATIC IMPORTED GLOBAL)
set_target_properties(ProkasCefImportLibs_libcef_dll_wrapper PROPERTIES
    IMPORTED_LOCATION                   ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef_dll_wrapper.lib
    IMPORTED_LOCATION_DEBUG             ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef_dll_wrapper.lib
    IMPORTED_IMPLIB                     ${CMAKE_CURRENT_SOURCE_DIR}/rls/libcef_dll_wrapper.lib
    IMPORTED_IMPLIB_DEBUG               ${CMAKE_CURRENT_SOURCE_DIR}/dbg/libcef_dll_wrapper.lib
)
set_property(TARGET ProkasCefImportLibs_libcef_dll_wrapper APPEND PROPERTY PUBLIC_HEADER ${Hdr})
target_include_directories(ProkasCefImportLibs_libcef_dll_wrapper BEFORE INTERFACE ".")
