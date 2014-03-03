# Copyright (C) 2010 The Android Open Source Project
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

# Inherit products
$(call inherit-product, device/samsung/bcm21553-common/common.mk)
$(call inherit-product, vendor/samsung/cooperve/vendor.mk)
# Using our vendor (Superuser, hosts file and APNS)
$(call inherit-product, vendor/mmb/vendor_blobs.mk)
# Including GApps
$(call inherit-product, vendor/google/tiny.mk)

# Add device package overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/cooperve/overlay

# Kernel modules
#PRODUCT_COPY_FILES += \
#    device/samsung/cooperve/prebuilt/root/fsr.ko:root/fsr.ko \
#    device/samsung/cooperve/prebuilt/root/fsr_stl.ko:root/fsr_stl.ko \
#    device/samsung/cooperve/prebuilt/root/rfs_fat.ko:root/rfs_fat.ko \
#    device/samsung/cooperve/prebuilt/root/rfs_glue.ko:root/rfs_glue.ko \
#    device/samsung/cooperve/prebuilt/root/j4fs.ko:root/j4fs.ko \
#    device/samsung/cooperve/prebuilt/root/sec_param.ko:root/sec_param.ko

# Add LDPI assets, in addition to MDPI
PRODUCT_AAPT_PREF_CONFIG := ldpi mdpi

# Torch
PRODUCT_PACKAGES += \
    Torch

## MDPI assets
PRODUCT_AAPT_PREF_CONFIG := mdpi

## New BRCM Sources Config
PRODUCT_PROPERTY_OVERRIDES := \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10

## New BRCM Sources Config
PRODUCT_COPY_FILES := \
    development/data/etc/apns-conf.xml:system/etc/apns-conf.xml \
    development/data/etc/vold.conf:system/etc/vold.conf \
    development/tools/emulator/system/camera/media_profiles.xml:system/etc/media_profiles.xml \
	brcm_usrlib/dag/vmcsx/egl.cfg:system/lib/egl/egl.cfg \

## New BRCM Sources Config
PRODUCT_PACKAGES := \
    audio.primary.goldfish \
	libGLES_hgl

# Arabic languages
$(call inherit-product, build/target/product/locales_full.mk)

# Rom Manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=spacecaker \
    ro.modversion=aosp-ics_spacecaker_$(shell date +"%d.%m.%y-%s")

# Prebuilt Kernel - DELETE from the package
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/samsung/cooperve/prebuilt/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel
