#!/bin/bash
NDK=/mnt/extend/android-ndk-r13b
export SYSROOT=$NDK/platforms/android-21/arch-arm64
TOOLCHAIN=`echo $NDK/toolchains/aarch64-linux-android-4.9/prebuilt/*-x86_64`
export PATH=$TOOLCHAIN/bin:$PATH
export ARM_LIB=$SYSROOT/usr/lib
export PREFIX=`pwd`/out-android/arm64
{
./configure \
--host-os=linux \
--target-os=android \
--cross-prefix=aarch64-linux-android- \
--arch=arm64 \
--sysroot=$SYSROOT \
--disable-static \
--enable-shared \
--enable-small \
--disable-symver \
--disable-debug \
--disable-programs \
--disable-doc \
--disable-avdevice \
--disable-postproc \
--disable-network \
--disable-encoders \
--disable-decoders \
--disable-hwaccels \
--disable-muxers \
--disable-demuxers \
--disable-parsers \
--disable-bsfs \
--disable-protocols \
--disable-devices \
--enable-decoder=h264,png \
--enable-demuxer=image_png_pipe \
--enable-parser=h264,png \
--enable-protocol=file \
--enable-pic \
--enable-asm \
--enable-cross-compile \
--prefix=$PREFIX \
--extra-cflags="-fPIC -DANDROID"
make clean
make
make install
rm -f compat/strtod.o
rm -f compat/strtod.d
}
