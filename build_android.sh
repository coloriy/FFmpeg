#!/bin/bash
#===========================
#James set
if [ -z "$ANDROID_NDK_ROOT" -o -z "$ANDROID_NDK_ROOT" ]; then
    echo "You must define ANDROID_NDK_ROOT before starting."
    echo "which is recommended using ndk-build in sdk folder based on android studio:"
    echo "like this: /home/lijian/Android/Sdk/ndk-bundle"
    exit 1
fi

#ANDROID_NDK_ROOT=/home/lijian/Android/Sdk/ndk-bundle
#32 or 64, you can modify it based on your requirement 32 or 64.
archbit=32

#===========================
if [ $archbit -eq 32 ]; then
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

SYSROOT=$ANDROID_NDK_ROOT/platforms/android-24/arch-$arch/
TOOLCHAIN=$ANDROID_NDK_ROOT/toolchains/$cpu-linux-$android-4.9/prebuilt/linux-x86_64


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
    --disable-ffplay \
    --disable-ffprobe \
    --disable-ffmpeg \
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
