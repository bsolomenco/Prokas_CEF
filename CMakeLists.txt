#rd /Q /S .bld & cmake -B .bld -A Win32 && cmake --build .bld --target install --config Release
#rd /Q /S .bld & cmake -B .bld -A Win32 -DCMAKE_INSTALL_PREFIX=dst2 && cmake --build .bld --target install --config Release

cmake_minimum_required(VERSION 3.28)

cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME PROJECT_NAME)
string(REPLACE " " "_" PROJECT_NAME ${PROJECT_NAME})
project(${PROJECT_NAME})

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    #set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/dst")
    set(CMAKE_INSTALL_PREFIX "G:/Prokas2/src/Extern/CEF/90.6.7")
endif()

add_subdirectory("src") #original (patched) files + original CMake project

set(DstDbgDir "${CMAKE_INSTALL_PREFIX}/dbg")
set(DstRlsDir "${CMAKE_INSTALL_PREFIX}/rls")
set(DstIncDir "${CMAKE_INSTALL_PREFIX}/inc")

install(TARGETS libcef_dll_wrapper CONFIGURATIONS Debug
    ARCHIVE         DESTINATION "${DstDbgDir}"
    LIBRARY         DESTINATION "${DstDbgDir}"
    RUNTIME         DESTINATION "${DstDbgDir}"
    PUBLIC_HEADER   DESTINATION "${DstIncDir}"
)
install(TARGETS libcef_dll_wrapper CONFIGURATIONS Release
    ARCHIVE         DESTINATION "${DstRlsDir}"
    LIBRARY         DESTINATION "${DstRlsDir}"
    RUNTIME         DESTINATION "${DstRlsDir}"
    PUBLIC_HEADER   DESTINATION "${DstIncDir}"
)

install(DIRECTORY "src/Debug/"   DESTINATION "${DstDbgDir}" CONFIGURATIONS Debug)
install(DIRECTORY "src/Release/" DESTINATION "${DstRlsDir}" CONFIGURATIONS Release)
install(DIRECTORY "src/include/" DESTINATION "${DstIncDir}/include")

install(FILES "CMakeLists.txt_dst.cmake" DESTINATION "${CMAKE_INSTALL_PREFIX}" RENAME "CMakeLists.txt")
