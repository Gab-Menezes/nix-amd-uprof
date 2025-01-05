{ 
    stdenv,
    requireFile,
    lib,
    pkgs
}: stdenv.mkDerivation rec {
    pname = "amd-uprof";
    version = "5.0.1479";

    src = let packageName = "AMDuProf_Linux_x64_${version}.tar.bz2"; in requireFile {
        name = packageName;
        sha256 = "065d24d9b84d2ef94ae8a360bf55c74a0f3fe9250b01cc7fb2642495028130d5";
        message = ''
            The download for this file is behind a EULA acceptance screen you need to accept first,
            Visit https://developer.amd.com/amd-uprof/ and download the tarball, then run the following:
            $ nix-store --add-fixed sha256 ${packageName}
            $ nix-hash --base32 --type sha256 --flat ${packageName}
        '';
    };

    buildInputs = with pkgs; [
        autoPatchelfHook

        gcc
        glib
        freetype
        fontconfig
        numactl
        dbus
        coreutils
        ncurses5
        kmod
        libGLU
        elfutils
        libxkbcommon
        libarchive
        libglvnd
        rocmPackages.rocprofiler

        xorg.libX11
        xorg.libXi
        xorg.libxcb
        xorg.xcbutilwm
        xorg.xcbutilimage
        xorg.xcbutilrenderutil
        xorg.xcbutilkeysyms
        xorg.libICE
        xorg.libXmu
        xorg.libSM
    ];

    postUnpack = ''
    patchelf --replace-needed libroctracer64.so.1 libroctracer64.so AMDuProf_Linux_x64_${version}/bin/ProfileAgents/x64/libAMDGpuAgent.so
    '';

    installPhase = ''
    patchShebangs ./bin
    mkdir -p $out/bin
    cp -r ./bin $out/
    cp ./Legal/AMDuProfEndUserLicenseAgreement.htm $out/
    '';

    meta = with lib; {
        description = "AMD uProf is a performance analysis tool for applications running on Windows and Linux operating systems. It allows developers to better understand the runtime performance of their application and to identify ways to improve its performance.";
        license = licenses.amd;
        maintainers = [];
        platforms = platforms.linux;
    };
}