#include "include/cef_version.h"
#include <cstdio>
#include <print>

int main(){
    auto cefMajVer = cef_version_info(CEF_VERSION_MAJOR);
    auto cefMinVer = cef_version_info(CEF_VERSION_MINOR);
    std::println("CEF version: {}.{}", cefMajVer, cefMinVer);
    return 0;
}