#rd /Q /S .bld & cmake -B .bld -A Win32 && cmake --build .bld --target install --config Release

cmake_minimum_required(VERSION 3.28)

cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME PROJECT_NAME)
string(REPLACE " " "_" PROJECT_NAME ${PROJECT_NAME})
project(${PROJECT_NAME})

set(BinDbgDir "dbg")
set(BinRelDir "rel")

add_subdirectory("_original")

install(TARGETS libcef_dll_wrapper CONFIGURATIONS Debug
    ARCHIVE         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/${BinDbgDir}"
    LIBRARY         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/${BinDbgDir}"
    RUNTIME         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/${BinDbgDir}"
)
install(TARGETS libcef_dll_wrapper CONFIGURATIONS Release
    ARCHIVE         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/${BinRelDir}"
    LIBRARY         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/${BinRelDir}"
    RUNTIME         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/bin/${BinRelDir}"
)
