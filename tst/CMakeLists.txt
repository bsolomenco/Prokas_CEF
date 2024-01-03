#rd /Q /S .bld & cmake -B .bld -A Win32 && cmake --build .bld --target install --config Release
cmake_minimum_required(VERSION 3.28)

set(CMAKE_CXX_STANDARD 23)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
if(MSVC)
    add_compile_options(/W4 /MP /J) #warning level, multi-process compilation, char as unsigned char
    add_compile_definitions(_CRT_SECURE_NO_WARNINGS NOMINMAX) #;NOMINMAX eliminates conflict between windows.h & STL regarding min() & max()
endif()

cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME PROJECT_NAME)
string(REPLACE " " "_" PROJECT_NAME ${PROJECT_NAME})
project(${PROJECT_NAME})

add_subdirectory(../bin Prokas_CEF_ImportLib)

add_executable(${PROJECT_NAME} src/tst.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE Prokas_libcef Prokas_libcef_dll_wrapper)

install(TARGETS ${PROJECT_NAME} #CONFIGURATIONS Debug
    ARCHIVE         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}"
    LIBRARY         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}"
    RUNTIME         DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}"
)
