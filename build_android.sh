#!/bin/bash
#modify those veriable based on your env
#===========================
NDK=/home/lijian/Android/Sdk/ndk-bundle
#32 or 64
archbit=64

#===========================
if [ $archbit -eq 32 ];then
echo "build for 32bit"
#32bit
abi='armeabi'
cpu='arm'
arch='arm'
android='androideabi'
else
#64bit
echo "build for 64bit"
abi='arm64-v8a'
cpu='aarch64'
arch='arm64'
android='android'
fi

SYSROOT=$NDK/platforms/android-24/arch-$arch/
TOOLCHAIN=$NDK/toolchains/$cpu-linux-$android-4.9/prebuilt/linux-x86_64


PREFIX=$(pwd)/android/$cpu
#ADDI_CFLAGS="-marm"

function build_one
{
    ./configure \
    --prefix=$PREFIX \
    --enable-shared \
    --disable-static \
    --disable-doc \
    --disable-ffserver \
    --enable-yasm \
    --enable-cross-compile \
    --cross-prefix=$TOOLCHAIN/bin/$cpu-linux-$android- \
    --target-os=linux \
    --arch=$cpu \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic -DANDROID" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG
    make clean
    make
    make install
}

build_one
