#!/bin/bash
NDK=/mnt/extend/android-ndk-r13b
export SYSROOT=$NDK/platforms/android-21/arch-arm
# export SYSROOT=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot
TOOLCHAIN=`echo $NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/*-x86_64`
# TOOLCHAIN=`echo $NDK/toolchains/llvm/prebuilt/*-x86_64`
export PATH=$TOOLCHAIN/bin:$PATH
export ARM_LIB=$SYSROOT/usr/lib
export PREFIX=`pwd`/out-android/arm
{
./configure \
--host-os=linux \
--target-os=android \
--cross-prefix=arm-linux-androideabi- \
--arch=arm \
--cpu=cortex-a9 \
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
--enable-neon \
--enable-cross-compile \
--prefix=$PREFIX \
--extra-cflags="-fPIC -DANDROID -march=armv7-a -mfloat-abi=softfp -mfpu=neon" \
--extra-ldflags="-Wl,--fix-cortex-a8"
make clean
make
make install
rm -f compat/strtod.o
rm -f compat/strtod.d
}


# --cc=armv7a-linux-androideabi21-clang \
# --cxx=armv7a-linux-androideabi21-clang++ \
# --as=arm-linux-androideabi-as \
# --nm=llvm-nm \

# --disable-everything \
# --disable-swresample \
# --disable-filters \
# --disable-avfilter \
#--disable-swscale \