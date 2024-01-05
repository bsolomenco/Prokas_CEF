# Purpose
- ... is to have custom CEF binaries (mainly `libcef_dll_wrapper`) as a CMake target (as import library) usable in a CMake build system
- ... in a minimalistic separate repository
- ... with CMake build system ... installing necessary files in Prokas sourcetree

# Dependencies

```
- CEF binary package
    --> src [patched]
        --> libcef_dll_wrapper.lib  |
            CMakeLists.txt          | ==> Prokas_libcef_dll_wrapper (CMake STATIC IMPORTED library)
    --> binaries
        --> libcef.dll&lib          |
            CMakeLists.txt          | ==> Prokas_libcef (CMake SHARED IMPORTED library)
```
```
- CefControl (dll+lib)                              --> target_link_libraries(... Prokas_libcef Prokas_libcef_dll_wrapper ...)
    - libcef_dll_wrapper.lib (static library)
    - libcef.lib (+dll)
        - chrome_elf.dll
    - C-runtime DLLs                                dynamically linked (/MD)
```

# Clone
- `git clone https://github.com/bsolomenco/Prokas_CEF.git .`
- folder structure:
```
    bin\            - CMake project with IMPORTED libraries
    tst\            - test project using the CMake SHARED IMPORTED library project from bin (NOTE: Debug configuration will fail when using a minimal package because it doesn't contain necessary files!)
    CMakeLists.txt  - CMake project for libcef_dll_wrapper
    MT2MD.diff      - patch to use /MD instead /MT
    run.cmd         - batch script to unpack, remove tests, patch & build for Win32
```

# Prepare & Build
- download a CEF binary package from `https://github.com/chromiumembedded/cef` ... `https://cef-builds.spotifycdn.com/index.html#windows32:90`
    - `cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32.tar.bz2`
    - `cef_binary_120.1.10+g3ce3184+chromium-120.0.6099.129_windows32.tar.bz2`
    - ... or keep the package also in this repo
- read the comments from CMakeLists.txt

# Patch creation
- in a tmp dir:
- download a CEF binary package from `https://github.com/chromiumembedded/cef` ... `https://cef-builds.spotifycdn.com/index.html#windows32:90`
    - e.g. `cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32.tar.bz2`
- unpack the CEF binary package in `src` folder
    - `7z x -so "cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32.tar.bz2" | 7z x -si -ttar`
    - `move /Y "cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32" src`
- `git init`
- `git add src`
- `git commit -m "src"`
- manually do necessary changes (like `\MT` -> `\MD`)
- `git diff > patch.diff`
- take `patch.diff` and apply it in your repo: `git apply patch.diff`