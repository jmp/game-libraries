setlocal
set BRANCH=release-2.0.8
set CWD=%~dp0
cd ..\toolkit
call activate.cmd
cd %CWD%
if not exist SDL2 hg clone http://hg.libsdl.org/SDL SDL2
cd SDL2
hg up -C %BRANCH%
copy CMakeLists.txt CMakeLists.txt.bak
python -c "print(open('CMakeLists.txt').read().replace('if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})','if(FALSE)'))" > CMakeLists.txt.new
move CMakeLists.txt.new CMakeLists.txt
cmake^
    -G "MinGW Makefiles"^
    -DCMAKE_BUILD_TYPE=Release^
    -DSDL_STATIC:BOOL=ON^
    -DSDL_SHARED:BOOL=OFF^
    -DSSE:BOOL=ON^
    -DMMX:BOOL=ON^
    -DSSE2:BOOL=ON^
    -DSSE3:BOOL=ON^
    -DSSEMATH:BOOL=ON
move CMakeLists.txt.bak CMakeLists.txt
mingw32-make
cd %CWD%
endlocal
