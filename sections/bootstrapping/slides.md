!SLIDE title-slide
# Bootstrapping, 19th Cent. #
## To raise or better oneself by one's own unaided efforts, in a ludicrously far-fetched or quixotic manner ##

<p class="notes">
Talk is about "bootstrap" and "self-hosting" metaphors. Originally meant something impossible like perpetual motion machines.
</p>

!SLIDE center
![Baron Münchhausen](BaronMunch.jpg "Baron Münchhausen")
Baron Münchhausen

!SLIDE bullets
# Bootstrapping, 20th Cent. #
## A self-sustaining process that proceeds without external help ##

<p class="notes">
In early 1900s America, morphed into something possible
</p>

!SLIDE bullets incremental
# Bootstrapping Applications #
* Socio-Economics
* Business
* Statistics
* Linguistics

<p class="notes">
The American dream; company without VC; sampling with replacement; acquiring language
</p>

!SLIDE smbullets
# Biology #
<blockquote>
Different cells receive different combinations of chemicals, which switch on different combinations of genes, and some genes work to switch other genes on or off. And so the bootstrapping continues, until we have the full repertoire of different kinds of cells.
</blockquote>

Richard Dawkins, <i>River Out of Eden</i>

!SLIDE bullets
# Computers #

* "Booting" a computer is a derivation
* Main memory starts in a blank slate
* Small program (BIOS) inits hardware
* Loads a program from hard drive
* Passes control to bigger program (OS)

<p class="notes">
Booting circa 1953. Some computers had a "bootstrap" button
</p>

!SLIDE
# Compilers #
## Writing a compiler in the language it compiles ##

!SLIDE bullets
# Advantages #
* Non-trivial test of the language being compiled
* Development can occur in a higher-level language
* Comprehensive consistency check

!SLIDE bullets
# Demo: LLVM / clang #
* LLVM compiler infrastructure
* clang C / C++, Objective C / C++ frontend
* Written in C++
* BSD license

<p class="notes">
Sponsored/used by Apple
</p>

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

<p class="notes">
Try live demo: `heroku run bin/llvm.sh --app stloop`
</p>

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

<p class="notes">
Stage 2 is sufficient, but building stage 3 is a consistency test
</p>

!SLIDE bullets
# Bootstrap → Self-Hosting #
* Bootstrap LLVM/clang with GCC
* Compile clang with clang
* Clang is <b>self-hosting</b>!

<p class="notes">
Need to trust GCC. Ken Thompson - Reflections on Trusting Trust, 1984
</p>

!SLIDE center
![Drawing Hands](handrawb.jpg "Drawing Hands")
(bootstrap hands not pictured)