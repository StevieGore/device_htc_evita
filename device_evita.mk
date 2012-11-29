#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# common msm8960 configs
$(call inherit-product, device/htc/msm8960-common/msm8960.mk)

DEVICE_PACKAGE_OVERLAYS += device/htc/evita/overlay

# Boot ramdisk setup
PRODUCT_COPY_FILES += \
    device/htc/evita/ramdisk/fstab.elite:root/fstab.elite \
    device/htc/evita/ramdisk/init.elite.rc:root/init.elite.rc \
    device/htc/evita/ramdisk/init.elite.usb.rc:root/init.elite.usb.rc \
    device/htc/evita/ramdisk/ueventd.elite.rc:root/ueventd.elite.rc

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := device/htc/evita/configs/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := device/htc/evita/configs/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# HTC BT audio config
PRODUCT_COPY_FILES += device/htc/evita/configs/AudioBTID.csv:system/etc/AudioBTID.csv

# QC thermald config
PRODUCT_COPY_FILES += device/htc/msm8960-common/configs/thermald.conf:system/etc/thermald.conf

# vold config
PRODUCT_COPY_FILES += \
    device/htc/evita/configs/vold.fstab:system/etc/vold.fstab

# wifi config
PRODUCT_COPY_FILES += \
    device/htc/evita/configs/wpa_supplicant.conf:/system/etc/wifi/wpa_supplicant.conf

# Sound configs
PRODUCT_COPY_FILES += \
    device/htc/evita/dsp/soundimage/srs_bypass.cfg:system/etc/soundimage/srs_bypass.cfg \
    device/htc/evita/dsp/soundimage/srsfx_trumedia_51.cfg:system/etc/soundimage/srsfx_trumedia_51.cfg \
    device/htc/evita/dsp/soundimage/srsfx_trumedia_movie.cfg:system/etc/soundimage/srsfx_trumedia_movie.cfg \
    device/htc/evita/dsp/soundimage/srsfx_trumedia_music.cfg:system/etc/soundimage/srsfx_trumedia_music.cfg \
    device/htc/evita/dsp/soundimage/srsfx_trumedia_voice.cfg:system/etc/soundimage/srsfx_trumedia_voice.cfg \
    device/htc/evita/dsp/soundimage/srs_geq10.cfg:system/etc/soundimage/srs_geq10.cfg \
    device/htc/evita/dsp/soundimage/srs_global.cfg:system/etc/soundimage/srs_global.cfg

PRODUCT_COPY_FILES += \
    device/htc/evita/dsp/snd_soc_msm/snd_soc_msm_2x:/system/etc/snd_soc_msm/snd_soc_msm_2x

# Keylayouts and Keychars
PRODUCT_COPY_FILES += \
    device/htc/evita/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/htc/evita/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/evita/keylayout/keypad_8960.kl:system/usr/keylayout/keypad_8960.kl \
    device/htc/evita/keylayout/msm8960-snd-card_Button_Jack.kl:system/usr/keylayout/msm8960-snd-card_Button_Jack.kl \
    device/htc/evita/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/htc/evita/keylayout/synaptics-rmi-touchscreen.kl:system/usr/keylayout/synaptics-rmi-touchscreen.kl

# Input device config
PRODUCT_COPY_FILES += \
    device/htc/evita/idc/projector_input.idc:system/usr/idc/projector_input.idc \
    device/htc/evita/idc/qwerty2.idc:system/usr/idc/qwerty2.idc \
    device/htc/evita/idc/qwerty.idc:system/usr/idc/qwerty.idc \
    device/htc/evita/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc

# GPS
#PRODUCT_PACKAGES += \
#    gps.evita \

# NFC
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_ndef \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

# Torch
PRODUCT_PACKAGES += \
    Torch

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/nfc-extras/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# Extra properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    ro.com.google.locationfeatures=1 \
    dalvik.vm.dexopt-flags=m=y

# We have enough space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Set build date
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_LOCALES += en_US xhdpi

# call the proprietary setup
$(call inherit-product-if-exists, vendor/htc/evita/evita-vendor.mk)

# call dalvik heap config
$(call inherit-product-if-exists, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# Discard inherited values and use our own instead.
PRODUCT_DEVICE := evita
PRODUCT_NAME := evita
PRODUCT_BRAND := htc
PRODUCT_MODEL := One X
PRODUCT_MANUFACTURER := HTC

# Bring in init.d hacks
PRODUCT_COPY_FILES +=  \
    device/htc/evita/init.d/lightsoff:system/etc/init.d/lightsoff

# Build.Prop Tweaks
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=300 \
    net.bt.name=Android \
    dalvik.vm.stack-trace-file=/tmp/stack-trace.txt \
    dalvik.vm.heapstartsize=48m \
    dalvik.vm.heapgrowthlimit=128m \
    dalvik.vm.heapsize=384m \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.dexopt-flags=v=n,o=v,u=n,m=y \
    dalvik.vm.lockprof.threshold=850 \
    dalvik.vm.verify-bytecode=false \
    ro.kernel.android.checkjni=0 \
    ro.media.enc.jpeg.quality=100 \
    debug.sf.hw=1 \
    debug.performance.tuning=1 \
    video.accelerate.hw=1 \
    persist.sys.purgeable_assets=1 \
    windowsmgr.max_events_per_sec=320 \
    pm.sleep_mode=1 \
    ro.HOME_APP_ADJ=1 \
    persist.sys.use_dithering=0 \
    ro.media.dec.jpeg.memcap=8000000 \
    ro.media.enc.hprof.vid.bps=8000000 \
    ro.media.enc.hprof.vid.fps=65 \
    ro.config.nocheckin=1 \
    ro.config.vc_call_vol_steps=12 \
    ring.delay=0 \
    ro.telephony.call_ring.delay=50 \
    ro.lge.proximity.delay=20 \
    mot.proximity.delay=20 \
    ro.config.hwfeature_wakeupkey=0 \
    ro.ext4fs=1 \
    debug.composition.type=gpu \
    ro.mot.eri.losalert.delay=900 \
    ro.ril.fast.dormancy.rule=0 \
    ro.HOME_APP_MEM=8192 \
    ro.FOREGROUND_APP_MEM=8192 \
    ro.VISIBLE_APP_MEM=8192 \
    ro.max.fling_velocity=15000 \
    ro.min.fling_velocity=10000 \
    movfilter=40 \
    movehyst=0 \
    per_sec=300 \
    TCHTHR=28 \
    ro.semc.xloud.supported=true \
    persist.service.xloud.enable=1 \
    ro.semc.sound_effects_enabled=true \
    ro.service.swiqi.supported=true \
    persist.service.swiqi.enable=1

# Bring in audio effetcs
PRODUCT_COPY_FILES +=  \
    device/htc/evita/audio/app/AudioEffectService.apk:system/app/AudioEffectService.apk \
    device/htc/evita/audio/app/Audiofxwidget.apk:system/app/Audiofxwidget.apk \
    device/htc/evita/audio/app/BeatsTweaks.apk:system/app/BeatsTweaks.apk \
    device/htc/evita/audio/app/DolbyMobile.apk:system/app/DolbyMobile.apk \
    device/htc/evita/audio/bins/alsa_amixer:system/bin/alsa_amixer \
    device/htc/evita/audio/bins/alsa_aplay:system/bin/alsa_aplay \
    device/htc/evita/audio/bins/alsa_ctl:system/bin/alsa_ctl \
    device/htc/evita/audio/bins/snd:system/bin/snd \
    device/htc/evita/audio/bins/snd3254:system/bin/snd3254 \
    device/htc/evita/audio/bins/sound:system/bin/sound \
    device/htc/evita/audio/bins/sound8x60:system/bin/sound8x60 \
    device/htc/evita/audio/bins/sound8960:system/bin/sound8960 \
    device/htc/evita/audio/etc/audio:system/etc/audio \
    device/htc/evita/audio/etc/audio/aeqcoe.txt:system/etc/audio/aeqcoe.txt \
    device/htc/evita/audio/etc/audio/eqfilter.txt:system/etc/audio/eqfilter.txt \
    device/htc/evita/audio/etc/audio/lmfilter.txt:system/etc/audio/lmfilter.txt \
    device/htc/evita/audio/etc/audio/situation.txt:system/etc/audio/situation.txt \
    device/htc/evita/audio/etc/audio/soundbooster.txt:system/etc/audio/soundbooster.txt \
    device/htc/evita/audio/etc/audio/stream_earpiece.txt:system/etc/audio/stream_earpiece.txt \
    device/htc/evita/audio/etc/audio/stream_headset.txt:system/etc/audio/stream_headset.txt \
    device/htc/evita/audio/etc/audio/stream_speaker.txt:system/etc/audio/stream_speaker.txt \
    device/htc/evita/audio/etc/firmware/dsps_fluid.b00:system/etc/firmware/dsps_fluid.b00 \
    device/htc/evita/audio/etc/firmware/dsps_fluid.b01:system/etc/firmware/dsps_fluid.b01 \
    device/htc/evita/audio/etc/firmware/dsps_fluid.b02:system/etc/firmware/dsps_fluid.b02 \
    device/htc/evita/audio/etc/firmware/dsps_fluid.b03:system/etc/firmware/dsps_fluid.b03 \
    device/htc/evita/audio/etc/firmware/dsps_fluid.mdt:system/etc/firmware/dsps_fluid.mdt \
    device/htc/evita/audio/etc/permissions/b1.xml:system/etc/permissions/b1.xml \
    device/htc/evita/audio/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
    device/htc/evita/audio/etc/permissions/com.sonyericsson.audioeffectif.xml:system/etc/permissions/com.sonyericsson.audioeffectif.xml \
    device/htc/evita/audio/etc/permissions/com.srs.fusion.fx.xml:system/etc/permissions/com.srs.fusion.fx.xml \
    device/htc/evita/audio/etc/permissions/com.sonyericsson.android.SwIqiBmp.xml:system/etc/permissions/com.sonyericsson.android.SwIqiBmp.xml \
    device/htc/evita/audio/etc/soundimage/Sound_Beats.txt:system/etc/soundimage/Sound_Beats.txt \
    device/htc/evita/audio/etc/A1026_CFG.csv:system/etc/A1026_CFG.csv \
    device/htc/evita/audio/etc/AdieHWCodec.csv:system/etc/AdieHWCodec.csv \
    device/htc/evita/audio/etc/AIC3254_REG.csv:system/etc/AIC3254_REG.csv \
    device/htc/evita/audio/etc/AIC3254_REG_DualMic.csv:system/etc/AIC3254_REG_DualMic.csv \
    device/htc/evita/audio/etc/asound.conf:system/etc/asound.conf \
    device/htc/evita/audio/etc/audio_effects.conf:system/etc/audio_effects.conf \
    device/htc/evita/audio/etc/AudioFilterPlatform.csv:system/etc/AudioFilterPlatform.csv \
    device/htc/evita/audio/etc/AudioFilterProduct.csv:system/etc/AudioFilterProduct.csv \
    device/htc/evita/audio/etc/AudioPreProcess.csv:system/etc/AudioPreProcess.csv \
    device/htc/evita/audio/etc/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    device/htc/evita/audio/etc/basimage_gec.bin:system/etc/basimage_gec.bin \
    device/htc/evita/audio/etc/basimage_gec_bt.bin:system/etc/basimage_gec_bt.bin \
    device/htc/evita/audio/etc/basimage_gec_x.bin:system/etc/basimage_gec_x.bin \
    device/htc/evita/audio/etc/basimage_ibeats.bin:system/etc/basimage_ibeats.bin \
    device/htc/evita/audio/etc/basimage_ibeats_pro.bin:system/etc/basimage_ibeats_pro.bin \
    device/htc/evita/audio/etc/basimage_ibeats_solo.bin:system/etc/basimage_ibeats_solo.bin \
    device/htc/evita/audio/etc/basimage_ibeats_solo_x.bin:system/etc/basimage_ibeats_solo_x.bin \
    device/htc/evita/audio/etc/basimage_ibeats_studio.bin:system/etc/basimage_ibeats_studio.bin \
    device/htc/evita/audio/etc/basimage_ibeats_x.bin:system/etc/basimage_ibeats_x.bin \
    device/htc/evita/audio/etc/CodecDSPID.txt:system/etc/CodecDSPID.txt \
    device/htc/evita/audio/etc/CodecDSPID_NEL.txt:system/etc/CodecDSPID_NEL.txt \
    device/htc/evita/audio/etc/CodecDSPID_WB.txt:system/etc/CodecDSPID_WB.txt \
    device/htc/evita/audio/etc/dynimage_gec.bin:system/etc/dynimage_gec.bin \
    device/htc/evita/audio/etc/dynimage_gec_bt.bin:system/etc/dynimage_gec_bt.bin \
    device/htc/evita/audio/etc/dynimage_gec_x.bin:system/etc/dynimage_gec_x.bin \
    device/htc/evita/audio/etc/dynimage_ibeats.bin:system/etc/dynimage_ibeats.bin \
    device/htc/evita/audio/etc/dynimage_ibeats_pro.bin:system/etc/dynimage_ibeats_pro.bin \
    device/htc/evita/audio/etc/dynimage_ibeats_solo.bin:system/etc/dynimage_ibeats_solo.bin \
    device/htc/evita/audio/etc/dynimage_ibeats_solo_x.bin:system/etc/dynimage_ibeats_solo_x.bin \
    device/htc/evita/audio/etc/dynimage_ibeats_studio.bin:system/etc/dynimage_ibeats_studio.bin \
    device/htc/evita/audio/etc/dynimage_ibeats_x.bin:system/etc/dynimage_ibeats_x.bin \
    device/htc/evita/audio/etc/HP_Audio.csv:system/etc/HP_Audio.csv \
    device/htc/evita/audio/etc/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/htc/evita/audio/etc/peqimage_gec.bin:system/etc/peqimage_gec.bin \
    device/htc/evita/audio/etc/peqimage_gec_bt.bin:system/etc/peqimage_gec_bt.bin \
    device/htc/evita/audio/etc/peqimage_gec_x.bin:system/etc/peqimage_gec_x.bin \
    device/htc/evita/audio/etc/peqimage_ibeats.bin:system/etc/peqimage_ibeats.bin \
    device/htc/evita/audio/etc/peqimage_ibeats_pro.bin:system/etc/peqimage_ibeats_pro.bin \
    device/htc/evita/audio/etc/peqimage_ibeats_solo.bin:system/etc/peqimage_ibeats_solo.bin \
    device/htc/evita/audio/etc/peqimage_ibeats_solo_x.bin:system/etc/peqimage_ibeats_solo_x.bin \
    device/htc/evita/audio/etc/peqimage_ibeats_studio.bin:system/etc/peqimage_ibeats_studio.bin \
    device/htc/evita/audio/etc/peqimage_ibeats_x.bin:system/etc/peqimage_ibeats_x.bin \
    device/htc/evita/audio/etc/soundbooster.txt:system/etc/soundbooster.txt \
    device/htc/evita/audio/etc/SRSAudioFilter.csv:system/etc/SRSAudioFilter.csv \
    device/htc/evita/audio/etc/TPA2051_CFG.csv:system/etc/TPA2051_CFG.csv \
    device/htc/evita/audio/etc/TPA2051_CFG_BEATS_HW.csv:system/etc/TPA2051_CFG_BEATS_HW.csv \
    device/htc/evita/audio/etc/TPA2051_CFG_XC.csv:system/etc/TPA2051_CFG_XC.csv \
    device/htc/evita/audio/etc/be_movie:system/etc/be_movie \
    device/htc/evita/audio/etc/be_photo:system/etc/be_photo \
    device/htc/evita/audio/framework/b1.jar:system/framework/b1.jar \
    device/htc/evita/audio/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar \
    device/htc/evita/audio/framework/com.sonyericsson.android.SwIqiBmp.jar:system/framework/com.sonyericsson.android.SwIqiBmp.jar \
    device/htc/evita/audio/framework/com.srs.fusion.fx.jar:system/framework/com.srs.fusion.fx.jar \
    device/htc/evita/audio/framework/semc_audioeffectif.jar:system/framework/semc_audioeffectif.jar \
    device/htc/evita/audio/lib/soundfx/libaudiopreprocessing.so:system/lib/soundfx/libaudiopreprocessing.so \
    device/htc/evita/audio/lib/soundfx/libbeatsbass.so:system/lib/soundfx/libbeatsbass.so \
    device/htc/evita/audio/lib/soundfx/libbundlewrapper.so:system/lib/soundfx/libbundlewrapper.so \
    device/htc/evita/audio/lib/soundfx/libclearaudiowrapper.so:system/lib/soundfx/libclearaudiowrapper.so \
    device/htc/evita/audio/lib/soundfx/libcyanogen-dsp.so:system/lib/soundfx/libcyanogen-dsp.so \
    device/htc/evita/audio/lib/soundfx/libdownmix.so:system/lib/soundfx/libdownmix.so \
    device/htc/evita/audio/lib/soundfx/libhearingprotection.so:system/lib/soundfx/libhearingprotection.so \
    device/htc/evita/audio/lib/soundfx/libreverbwrapper.so:system/lib/soundfx/libreverbwrapper.so \
    device/htc/evita/audio/lib/soundfx/libsoundaurawrapper.so:system/lib/soundfx/libsoundaurawrapper.so \
    device/htc/evita/audio/lib/soundfx/libsrsfx.so:system/lib/soundfx/libsrsfx.so \
    device/htc/evita/audio/lib/soundfx/libsrstb.so:system/lib/soundfx/libsrstb.so \
    device/htc/evita/audio/lib/soundfx/libvisualizer.so:system/lib/soundfx/libvisualizer.so \
    device/htc/evita/audio/lib/soundfx/libvptwrapper.so:system/lib/soundfx/libvptwrapper.so \
    device/htc/evita/audio/lib/soundfx/libxloudwrapper.so:system/lib/soundfx/libxloudwrapper.so \
    device/htc/evita/audio/lib/libacdbmapper.so:system/lib/libacdbmapper.so \
    device/htc/evita/audio/lib/libasound.so:system/lib/libacdbmapper.so \
    device/htc/evita/audio/lib/libaudioeq.so:system/lib/libaudioeq.so \
    device/htc/evita/audio/lib/libAudioTrimmer.so:system/lib/libAudioTrimmer.so \
    device/htc/evita/audio/lib/libbeatsbass.so:system/lib/libbeatsbass.so \
    device/htc/evita/audio/lib/libbeatscorehtc.so:system/lib/libbeatscorehtc.so \
    device/htc/evita/audio/lib/libDolby-dsp.so:system/lib/libDolby-dsp.so \
    device/htc/evita/audio/lib/libhtc_acoustic.so:system/lib/libhtc_acoustic.so \
    device/htc/evita/audio/lib/libsoundhoundaudio.so:system/lib/libsoundhoundaudio.so \
    device/htc/evita/audio/lib/libsrscorehtc.so:system/lib/libsrscorehtc.so \
    device/htc/evita/audio/lib/libsrsfx.so:system/lib/libsrsfx.so \
    device/htc/evita/audio/lib/libsrsprocessing.so:system/lib/libsrsprocessing.so \
    device/htc/evita/audio/lib/libvoAudioFR.so:system/lib/libvoAudioFR.so \
    device/htc/evita/audio/lib/libvptwrapper.so:system/lib/libvptwrapper.so \
    device/htc/evita/audio/lib/libxloudwrapper.so:system/lib/libxloudwrapper.so \
    device/htc/evita/audio/lib/libswiqibmpcnv.so:system/lib/libswiqibmpcnv.so \
    device/htc/evita/audio/usr/share/alsa/cards/aliases.conf:system/usr/share/alsa/cards/aliases.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/surround71.conf:system/usr/share/alsa/pcm/surround71.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/surround51.conf:system/usr/share/alsa/pcm/surround51.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/surround50.conf:system/usr/share/alsa/pcm/surround50.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/surround41.conf:system/usr/share/alsa/pcm/surround41.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/surround40.conf:system/usr/share/alsa/pcm/surround40.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/side.conf:system/usr/share/alsa/pcm/side.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/rear.conf:system/usr/share/alsa/pcm/rear.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/modem.conf:system/usr/share/alsa/pcm/modem.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/iec958.conf:system/usr/share/alsa/pcm/iec958.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/front.conf:system/usr/share/alsa/pcm/front.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/dsnoop.conf:system/usr/share/alsa/pcm/dsnoop.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/dpl.conf:system/usr/share/alsa/pcm/dpl.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/dmix.conf:system/usr/share/alsa/pcm/dmix.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/default.conf:system/usr/share/alsa/pcm/default.conf \
    device/htc/evita/audio/usr/share/alsa/pcm/center_lfe.conf:system/usr/share/alsa/pcm/center_lfe.conf \
    device/htc/evita/audio/usr/share/alsa/alsa.conf:system/usr/share/alsa/alsa.conf \
    device/htc/evita/audio/vendor/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/htc/evita/audio/xbin/alsa_amixer:system/xbin/alsa_amixer \
    device/htc/evita/audio/xbin/alsa_aplay:system/xbin/alsa_aplay \
    device/htc/evita/audio/xbin/alsa_ctl:system/xbin/alsa_ctl