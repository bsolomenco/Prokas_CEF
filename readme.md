# Clone
- `git clone https://github.com/bsolomenco/Prokas_CEF.git .`
- folder structure:
```
    bin\            - CMake SHARED IMPORTED library project
    tst\            - test project using the CMake SHARED IMPORTED library project from bin (NOTE: Debug configuration will fail when using a minimal package because it doesn't contain necessary files!)
    CMakeLists.txt  - CMake project for libcef_dll_wrapper
    MT2MD.diff      - patch to use /MD instead /MT
    run.cmd         - batch script to unpack, remove tests, patch & build for Win32
```

# Prepare & Build
- download a CEF binary package from `https://github.com/chromiumembedded/cef` ... `https://cef-builds.spotifycdn.com/index.html#windows32:90`
    - `cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32.tar.bz2`
    - `cef_binary_120.1.10+g3ce3184+chromium-120.0.6099.129_windows32.tar.bz2`
- execute `run.cmd`

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