setlocal
set BRANCH=release-3.0.1
set CWD=%~dp0
cd ..\toolkit
call activate.cmd
cd %CWD%
if not exist physfs hg clone https://hg.icculus.org/icculus/physfs
cd physfs
hg up -C %BRANCH%
cmake^
    -G "MinGW Makefiles"^
    -DCMAKE_BUILD_TYPE=Release^
    -DPHYSFS_BUILD_STATIC:BOOL=ON^
    -DPHYSFS_BUILD_SHARED:BOOL=OFF^
    -DPHYSFS_ARCHIVE_ZIP:BOOL=ON^
    -DPHYSFS_ARCHIVE_7Z:BOOL=OFF^
    -DPHYSFS_ARCHIVE_GRP:BOOL=OFF^
    -DPHYSFS_ARCHIVE_HOG:BOOL=OFF^
    -DPHYSFS_ARCHIVE_MVL:BOOL=OFF^
    -DPHYSFS_ARCHIVE_QPAK:BOOL=OFF^
    -DPHYSFS_ARCHIVE_WAD:BOOL=OFF^
    -DPHYSFS_ARCHIVE_SLB:BOOL=OFF^
    -DPHYSFS_ARCHIVE_VDF:BOOL=OFF^
    -DPHYSFS_ARCHIVE_ISO9660:BOOL=OFF
mingw32-make
cd %CWD%
endlocal
