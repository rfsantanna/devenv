pacman --needed --noconfirm -Sy bash pacman pacman-mirrors msys2-runtime
pacman --needed --noconfirm -Su
pacman --needed --noconfirm -Sy base-devel msys2-devel
pacman --needed --noconfirm -Sy mingw-w64-x86_64-python3 mingw-w64-x86_64-python3-pip mingw-w64-x86_64-python3-numpy mingw-w64-x86_64-python3-scipy mingw-w64-x86_64-python3-matplotlib mingw-w64-x86_64-python3-pandas mingw-w64-x86_64-python3-Pillow
