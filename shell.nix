{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk21

    # Font support (required for Meteor to load TTF fonts)
    fontconfig
    freetype

    # OpenGL / GLX
    mesa
    libGL
    libGLU

    # Windowing / X11
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXi

    # GLFW runtime deps
    glfw
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
      pkgs.mesa
      pkgs.libGL
      pkgs.glfw
      pkgs.xorg.libX11
      pkgs.xorg.libXcursor
      pkgs.xorg.libXrandr
      pkgs.xorg.libXinerama
      pkgs.xorg.libXi
      pkgs.fontconfig
      pkgs.freetype
    ]}:$LD_LIBRARY_PATH
  '';
}
