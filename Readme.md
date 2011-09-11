Part 0  -- Intro
  Running Heroku on Heroku
  Noah Zoschke
  noah@heroku.com
  herokuapp.herokuapp.com

  http://pot.home.xs4all.nl/scifi/byhisbootstraps.pdf

Part I  -- Bootstrapping
  Bootstrap
    http://en.wikipedia.org/wiki/Bootstrapping

    "a self-sustaining process that proceeds without external help"

    http://twitter.github.com/bootstrap/
    Business: to build a profitable company without receiving funding
    Statistics: resampling, sampling with replacement
    Biology: "Different cells receive different combinations of chemicals, which switch on different combinations of genes, and some genes work to switch other genes on or off. And so the bootstrapping continues, until we have the full repertoire of different kinds of cells." - Dawkins
    Computing: a simple computer program activates a more complicated system of programs (BIOS -> OS)
    Socio-economics: Toe improve one's social class with hard work. The American Dream

  Bootstrap
    metaphysical philosophy: "The attempt of the mind to analyze itself [is] an effort analogous to one who would lift himself by his own bootstraps."

    http://www.boston.com/bostonglobe/ideas/articles/2009/01/25/the_unkindliest_cut/?page=2

    http://books.google.com/books?id=yUIUAAAAYAAJ&pg=PA709&lpg=PA709&dq=%22The+attempt+of+the+mind+to+analyze+itself+an+effort+analogous+to+one+who+would+lift+himself+by+his+own+bootstraps.%22&source=bl&ots=fiZz8HPF6y&sig=u8pQCj3H3YdITFQeDgr5jva3F4g&hl=en&ei=tNNrTtSmAZHSiAKhqc3MDg&sa=X&oi=book_result&ct=result&resnum=1&ved=0CBYQ6AEwAA#v=onepage&q=%22The%20attempt%20of%20the%20mind%20to%20analyze%20itself%20an%20effort%20analogous%20to%20one%20who%20would%20lift%20himself%20by%20his%20own%20bootstraps.%22&f=false

    We have for some time shared Mr. Carlyle's prejudice against metaphysics, seeing in the attempt of the mind to analyze itself an effort analogous to one who would lift himself by his own bootstraps, or a repitition of the story of St. Patric, who when swimming a stream to escape his enemies, and finding their arrows whizzing about his head, did, as is well known, take off his head and hold it in his teeth until he was out of danger. Metaphysics is holding the mind in the mental teeth.

    Lectures on Logic
    Sir William Hamilton
    Professor of Logic and Metaphysics in the University of Edingburgh 1860


    "to raise or better oneself by one's own unaided efforts"
    ludicrously far-fetched or quixotic manner

    http://listserv.linguistlist.org/cgi-bin/wa?A2=ind0508B&L=ADS-L&P=R7109

    About a perpetual motion machine:
      1834 - It is conjectured that Mr. Murphee will now be enabled to hand himself over the Cumberland river or a barn yard fence by the straps of his boots. [APS]

    1862 _Chicago Tribune_ 12 Aug. 2/2 The hopeful individual who expects to
    raise a weight vastly beyond his strength, belongs to the same class of
    fools with great expectations, as he who promises to lift himself by his
    boot straps. [PQ]

    Not until the early 20th century that "boot strap" referred to possible tasks
      American belief in self-improvement

  http://www.lhup.edu/~dsimanek/museum/themes/BaronMunch.jpg
  http://gcc.gnu.org/install/build.html
  http://tap3x.net/EMBTI/j5bootstraps.html#limino
  http://en.wikipedia.org/wiki/Bootstrapping

  http://en.wikipedia.org/wiki/Backdoor_%28computing%29#Reflections_on_Trusting_Trust

Part II - Self Hosting & Bootstrapping
  [Image] Baron Munchaused - Bull up by hair ?

  Definition
    http://en.wikipedia.org/wiki/Self-hosting
    The term has its origins in compilers -- a self-hosting program is 
    A compiler that can compile its own source code

  Motivation
    eating your own dogfood
    Fly your own airplane
    FUN.

  History
    First example: Lisp by Hart and Levin at MIT in 1962
      Wrote a Lisp compiler in Lisp, testing it inside an existing Lisp interpreter

    Requires an existing intrepreter for the language that is to be compiled.
    This can be a cross-compiler, or in advanced cases a bootstrap toolchain.

  Example
    LLVM / Clang
      Compiler infrastructure written in C++
      Pluggable frontends for Objective-C, Fortran, Ada, Haskell, Java, Python, Ruby, ActionScript, Clang
      550k lines of C++ code
  
      Build LLVM/Clang with GCC (stage 1)
        Bootstrap the compiler with another compiler
        Result: GCC Flavored Clang. Possibly has bugs or differences?
          diff gcc clang => binary files differ

      Build LLVM/Clang with Stage1 Clang (stage2)
        Not yet adequate -- perhaps the GCC flavored clang isn't clang yet
          diff clang clang => binary files differ

      Build LLVM/Clang with Stage2 Clang
          diff clang clang => same!

    svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
    cd llvm/tools
    svn co http://llvm.org/svn/llvm-project/cfe/trunk clang
    cd ../..
    mkdir build
    cd build
    ../llvm/configure
    make

    $ cd tools/clang/
    $ make test
    Making Clang 'lit.site.cfg' file...Making Clang 'Unit/lit.site.cfg' file...
    --- Running clang tests for x86_64-apple-darwin11.1.0 ---
    lit.py: lit.cfg:143: note: using clang: '/Users/noah/dev/stloop/llvm-example/build/Debug+Asserts/bin/clang'
    Testing Time: 470.94s
      Expected Passes    : 3793
      Expected Failures  : 26
      Unsupported Tests  : 1


    $ ./Debug+Asserts/bin/clang -v
    clang version 3.0 (trunk 139473)
    Target: x86_64-apple-darwin11.1.0
    Thread model: posix

    CC=/Users/noah/dev/stloop/llvm-example/build/Debug+Asserts/bin/clang CXX=/Users/noah/dev/stloop/llvm-example/build/Debug+Asserts/bin/clang++ ../llvm-stage2/configure

  Originally applied to compilers, 

  I am experimenting building llvm/clang with clang, and I'm setting CC=clang CXX=clang. During ./configure it says: "checking whether we are using the GNU C compiler... yes". Is this the expected behavior?

  Why?!
    Good test
    consistency
    


Part II - Self Hosting
  Compilers
    http://blog.llvm.org/2010/02/clang-successfully-self-hosts.html
    "The resulting binaries passed all of Clang and LLVM's regression test suites, and the Clang-built Clang could then build all of LLVM and Clang again. The third-stage Clang was also fully-functional, completing the bootstrap."

  VCS
    Trivia: When did git self-host?
    http://marc.info/?l=git&m=117254154130732

  Platforms


Part III -- Heroku
  Naive Infrastructure
    Servers
      Runtime-Aspen (debian 4.0 Etch)
      Runtime-Bamboo (debian 5.0 Lenny)
      Runtime-Cedar  (Ubuntu 10.04 Lucid Lynx)
      Codex-Aspen
      Codex-Bamboo
      Codex-Cedar
      Face
        nginx
      Shen
        postgres
      RabbitMQ

    AWS (API calls)

  Unified Infrastructure
    Runtime
      All Ubuntu 10.04 LTS
      aspen/bamboo/cedar chroots ("stacks")
      App => LXC + chroot + code + process to run

  Discovery of Process Model
    Primative

  Self-Hosted Infrastructure
    Moving a system onto its own primatives

  Exercise
    Q: AWS Primatives?
    A: S3

  Uh oh...

  Bootstrap
    debootstrap

  Demo - HTTP Git
    Grack
    Heroku Client
    Releases API
    Cedar

    Heroku rollback

  ----

  