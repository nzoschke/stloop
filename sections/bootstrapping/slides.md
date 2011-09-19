!SLIDE title-slide bullets
# Bootstrapping, 19th Cent. #

* To raise or better oneself by one's own unaided efforts, in a ludicrously far-fetched or quixotic manner

!SLIDE center
![Baron Munchausen](BaronMunch.jpg "Baron Munchausen")

!SLIDE bullets
# Bootstrapping, 20th Cent. #
* A self-sustaining process that proceeds without external help

!SLIDE bullets incremental
# Bootstrapping Applications #
* Socio-economics
* Business
* Statistics
* Linguistics

!SLIDE smbullets
# Biology #
<blockquote>
Different cells receive different combinations of chemicals, which switch on different combinations of genes, and some genes work to switch other genes on or off. And so the bootstrapping continues, until we have the full repertoire of different kinds of cells.
</blockquote>

Richard Dawkins, <i>River Out of Eden</i>

!SLIDE
# Computers #

* Part of "booting" a computer (1953)
* Main memory starts in a blank slate
* Small program (BIOS) inits hardware
* Loads a program from hard drive
* Passes control to bigger program (OS)

!SLIDE
# Compilers #
* Writing a compiler in the language it compiles

!SLIDE
# Advantages #
* Non-trivial test of the language being compiled
* Development can occur in a higher-level language
* Comprehensive consistency check

!SLIDE
# Demo: LLVM / clang #
* LLVM compiler infrastructure
* clang C / C++, Objective C / C++ frontend
* Written in C++
* Sponsored/used by Apple
* BSD license

!SLIDE code smaller
    @@@ sh
    #!/usr/bin/env bash
    # http://llvm.org/docs/GettingStarted.html

    cd /tmp
    git clone http://llvm.org/git/llvm.git
    git clone http://llvm.org/git/clang.git llvm/tools/clang

    envs[1]="CC=gcc CXX=g++"
    envs[2]="PATH=/tmp/stage1/Release/bin:$PATH CC=clang CXX=clang++"
    envs[3]="PATH=/tmp/stage2/Release/bin:$PATH CC=clang CXX=clang++"

    for i in ${!envs[*]}; do
      (
        mkdir -p /tmp/stage$i && cd /tmp/stage$i
        export ${envs[$i]}
        which $CC $CXX
        ../llvm/configure             \
          --enable-optimized          \
          --disable-assertions        \
          --enable-targets=host-only
        time make
        time make -C tools/clang test
      )
    done

    # Diff binaries
    diff <(strings /tmp/stage1/Release/bin/clang) <(strings /tmp/stage2/Release/bin/clang) | wc
    diff <(strings /tmp/stage2/Release/bin/clang) <(strings /tmp/stage3/Release/bin/clang) | wc

!SLIDE commandline smaller
    $ heroku run bin/llvm.sh
    Running bin/llvm.sh attached to terminal... up, run.4

    + export CC=gcc CXX=g++
    + ../llvm/configure --enable-optimized --disable-assertions --enable-targets=host-only
    checking whether the C compiler works... yes
    checking whether we are using the GNU C compiler... yes
    checking how to run the C preprocessor... gcc -E
    ...

    + make
    + make -C tools/clang test
    --- Running clang tests for x86_64-unknown-linux-gnu ---
    Testing Time: 67.71s
      Expected Passes    : 3814
      Expected Failures  : 26
      Unsupported Tests  : 1
    real  1m8.980s

    + export PATH=/tmp/stage1/Release/bin:/usr/local/bin:/usr/bin:/bin CC=clang CXX=clang++
    + ../llvm/configure --enable-optimized --disable-assertions --enable-targets=host-only
    checking whether the C compiler works... yes
    checking whether we are using the GNU C compiler... yes
    checking how to run the C preprocessor... clang -E
    ...

    + make
    + make -C tools/clang test
    --- Running clang tests for x86_64-unknown-linux-gnu ---
    Testing Time: 56.57s
      Expected Passes    : 3814
      Expected Failures  : 26
      Unsupported Tests  : 1
    real  0m57.331s

!SLIDE commandline
    $ heroku run bin/llvm.sh
    + wc
    ++ strings /tmp/stage1/Release/bin/clang
    + diff /dev/fd/63 /dev/fd/62
    ++ strings /tmp/stage2/Release/bin/clang
     423609  941646 4701258

    + wc
    ++ strings /tmp/stage2/Release/bin/clang
    + diff /dev/fd/63 /dev/fd/62
    ++ strings /tmp/stage3/Release/bin/clang
         12      18     178

!SLIDE
# Self-hosting #
* Bootstrap clang with GCC
* Compile clang with clang
* Clang is <b>self-hosting</b>!

!SLIDE center
![Drawing Hands](handrawb.jpg "Drawing Hands")
(bootstrap hands not pictured)