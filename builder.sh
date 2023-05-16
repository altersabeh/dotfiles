#!/usr/bin/sh
buildx() {
    echo nt
    # https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-15.0.6.tar.gz #LLVM
    # https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tgz #PYTHON
    # https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.3.tar.xz #RUBY
    # https://www.cpan.org/src/5.0/perl-5.36.0.tar.xz #PERL
    # https://nodejs.org/dist/v19.2.0/node-v19.2.0.tar.gz #NODE
    # https://ftp.gnu.org/gnu/octave/octave-7.3.0.tar.lz #OCTAVE
    # https://cloud.r-project.org/src/base/R-4/R-4.2.2.tar.gz #R
    # https://downloads.haskell.org/~ghc/9.4.3/ghc-9.4.3-src.tar.lz #HASKELL
    # https://static.rust-lang.org/dist/rustc-1.65.0-src.tar.gz #RUST
    # https://github.com/JuliaLang/julia/releases/download/v1.8.3/julia-1.8.3.tar.gz #JULIA
    # https://github.com/erlang/otp/releases/download/OTP-25.1.2/otp_src_25.1.2.tar.gz #ERLANG
    # https://github.com/elixir-lang/elixir/archive/v1.14.1.zip #ELIXIR
    # https://go.dev/dl/go1.19.4.src.tar.gz #GO
    # https://github.com/HaxeFoundation/haxe/archive/refs/tags/4.2.5.tar.gz #HAXE
    # https://github.com/ponylang/ponyc/archive/refs/tags/0.52.2.tar.gz #PONY
    # https://github.com/lampepfl/dotty/archive/refs/tags/3.2.1.tar.gz #SCALA
    # https://dlcdn.apache.org/groovy/4.0.6/sources/apache-groovy-src-4.0.6.zip #GROOVY
    # https://github.com/JetBrains/kotlin/archive/refs/tags/v1.7.21.tar.gz #KOTLIN
    # http://dl.mercurylang.org/release/mercury-srcdist-22.01.4.tar.xz #MERCURY
    # https://github.com/openjdk/jdk/archive/refs/tags/jdk-19+35.tar.gz #JAVA
    # https://rakudo.org/dl/rakudo/rakudo-2022.12.tar.gz #RAKU
    # https://download.racket-lang.org/installers/8.7/racket-8.7-src-builtpkgs.tgz #RACKET
    # https://github.com/chapel-lang/chapel/releases/download/1.28.0/chapel-1.28.0.tar.gz #CHAPEL
    # https://nim-lang.org/download/nim-1.6.10.tar.xz #NIM
    # https://ftp.gnu.org/gnu/cim/cim-5.1.tar.gz #SIMULA
    # https://ftp.gnu.org/gnu/gcc/gcc-12.2.0/gcc-12.2.0.tar.xz #GCC
    # https://ftp.gnu.org/gnu/gnucobol/gnucobol-3.1.tar.gz #COBOL
    # https://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.tar.xz #SMALLTALK
    # https://www.php.net/distributions/php-8.1.13.tar.bz2 #PHP
    # https://www.lua.org/ftp/lua-5.4.4.tar.gz #LUA
    cd ..
    # tar xf archive.tar -C /target/directory --strip-components=1 #EXTRACTING TAR
}
