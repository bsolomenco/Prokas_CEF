#rd /Q /S .bld & cmake -B .bld -A Win32 && cmake --build .bld --target install --config Release

cmake_minimum_required(VERSION 3.28)

cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME PROJECT_NAME)
string(REPLACE " " "_" PROJECT_NAME ${PROJECT_NAME})
project(${PROJECT_NAME})

set(BinDbgDir "bin/dbg")
set(BinRlsDir "bin/rls")

add_subdirectory("src")

install(TARGETS libcef_dll_wrapper CONFIGURATIONS Debug
    ARCHIVE         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/${BinDbgDir}"
    LIBRARY         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/${BinDbgDir}"
    RUNTIME         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/${BinDbgDir}"
)
install(TARGETS libcef_dll_wrapper CONFIGURATIONS Release
    ARCHIVE         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/${BinRlsDir}"
    LIBRARY         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/${BinRlsDir}"
    RUNTIME         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/${BinRlsDir}"
)
