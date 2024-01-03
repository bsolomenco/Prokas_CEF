# Clone
- `git clone -b 90.6.7_windows32 https://github.com/bsolomenco/Prokas_CEF.git .`
- folder structure:
```
    bin\            - CMake SHARED IMPORTED library project
    tst\            - test project using the CMake SHARED IMPORTED library project from bin (NOTE: Debug configuration will fail because the minimal package doesn't contain necessary files! use full package)
    CMakeLists.txt  - CMake project for libcef_dll_wrapper
    MT2MD.diff      - patch to use /MD instead /MT
    run.cmd         - batch script to unpack, patch & build
```

# Prepare & Build
- download `cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32_minimal.tar.bz2` from `https://github.com/chromiumembedded/cef` ... `https://cef-builds.spotifycdn.com/index.html#windows32:90`
- execute `run.cmd`

# Patch creation
- in a tmp dir: download & unpack `cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32_minimal.tar.bz2` from `https://github.com/chromiumembedded/cef` ... `https://cef-builds.spotifycdn.com/index.html#windows32:90`
- `git init`
- `git add _original`
- `git commit -m "_original"`
- manually do necessary changes (like `\MT` -> `\MD`)
- `git diff > patch.diff`
- take `patch.diff` and apply it in your repo: `git apply patch.diff`