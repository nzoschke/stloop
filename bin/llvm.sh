# http://llvm.org/docs/GettingStarted.html

ROOT=/tmp/exercise
mkdir $ROOT && cd $ROOT

git clone http://llvm.org/git/llvm.git
git clone http://llvm.org/git/clang.git llvm/tools/clang

envs[1]="CC=gcc CXX=g++"
envs[2]="PATH=$ROOT/stage1/Release+asserts/bin:$PATH CC=clang CXX=clang++"
envs[3]="PATH=$ROOT/stage2/Release/bin:$PATH CC=clang CXX=clang++"

for i in ${!envs[*]}; do
  (
    mkdir -p $ROOT/stage$i && cd $ROOT/stage$i
    export ${envs[$i]}
    which $CC $CXX
    ../llvm/configure --enable-optimized --disable-assertions --enable-targets=host-only
    time make
    time make -C tools/clang test
  )
done

# Diff binaries
diff $ROOT/stage1/Debug+Asserts/bin/clang diff $ROOT/stage2/Debug+Asserts/bin/clang
diff $ROOT/stage2/Debug+Asserts/bin/clang diff $ROOT/stage3/Debug+Asserts/bin/clang

llvm[0]: ***** Completed Release Build

real  33m14.575s
user  30m19.000s
sys 3m21.540s