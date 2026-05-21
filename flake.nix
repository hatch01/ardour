{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          pkgs,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            packages =
              with pkgs;
              [

                harvid
                xjadeo
                doxygen
                graphviz # for dot
                itstool
                makeWrapper
                perl
                pkg-config
                python3
                git
                wafHook
                alsa-lib
                aubio
                boost
                cairomm
                cppunit
                curl
                dbus
                ffmpeg
                fftw
                fftwSinglePrec
                flac
                fluidsynth
                glibmm
                hidapi
                itstool
                kissfft
                libarchive
                libjack2
                liblo
                libltc
                libogg
                libpulseaudio
                librdf_rasqal
                libsamplerate
                libsigcxx
                libsndfile
                libusb1
                libuv
                libwebsockets
                libxi
                libxml2
                libxslt
                lilv
                lrdf
                lv2
                pango
                pangomm
                perl
                python3
                qm-dsp
                readline
                rubberband
                serd
                sord
                soundtouch
                sratom
                suil
                taglib
                vamp-plugin-sdk
                libxinerama
                libjpeg
                libxrandr
              ];

              NIX_CFLAGS_COMPILE = with pkgs; toString [
                # 'ioprio_set' syscall support:
                "-D_GNU_SOURCE"
                # compiler doesn't find headers without these:
                "-I${lib.getDev serd}/include/serd-0"
                "-I${lib.getDev sratom}/include/sratom-0"
                "-I${lib.getDev sord}/include/sord-0"
              ];
              LINKFLAGS = "-lpthread";
              # LD_LIBRARY_PATH= "";

          };
        };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
