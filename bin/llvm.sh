#!/usr/bin/env bash
set -ex

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
    ../llvm/configure --enable-optimized --disable-assertions --enable-targets=host-only
    time make
    time make -C tools/clang test
  )
done

# Diff binaries
diff <(strings /tmp/stage1/Release/bin/clang) <(strings /tmp/stage2/Release/bin/clang) | wc
# 422166  939811 4695061

diff <(strings /tmp/stage2/Release/bin/clang) <(strings /tmp/stage3/Release/bin/clang) | wc
#   3246    5233   27606