
LOCAL_PATH := device/oysters/t72ms

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

OPTOUT_FOSS := true

#Root in lineageOS
WITH_SU := true

# wifi features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.r_submix.default

PRODUCT_PACKAGES += \
	audio.primary.polaris \
	libcodec_audio \
	libril_audio \
	libtinyalsa

include frameworks/av/media/libcedarc/libcdclist.mk
include frameworks/av/media/libcedarx/libcdxlist.mk

# Media profile
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:system/etc/media_codecs_google_video_le.xml

# Camera
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
	config.disable_bluetooth=true

# Busybox
PRODUCT_PACKAGES += \
	busybox

# FakeGPS location/settings
PRODUCT_PROPERTY_OVERRIDES += \
	persist.fakegps.latitude=55.085754 \
	persist.fakegps.longitude=38.770379 \
	persist.fakegps.altitude=310.0

PRODUCT_PACKAGES += oysters_settings

# Email
PRODUCT_PACKAGES += \
    Email

# Weather
PRODUCT_PACKAGES += \
    OmniStyle \
    OmniJaws

# HAL
PRODUCT_PACKAGES += \
   camera.polaris \
   gps.polaris \
   hwcomposer.polaris

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.sun8i:root/fstab.sun8i \
    $(LOCAL_PATH)/rootdir/init.recovery.sun8i.rc:root/init.recovery.sun8i.rc \
    $(LOCAL_PATH)/rootdir/init.sun8i.rc:root/init.sun8i.rc \
    $(LOCAL_PATH)/rootdir/init.sun8i.usb.rc:root/init.sun8i.usb.rc \
    $(LOCAL_PATH)/rootdir/ueventd.sun8i.rc:root/ueventd.sun8i.rc

#    $(LOCAL_PATH)/rootdir/nand.ko:root/nand.ko \

# Storage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.sdcardfs=true

# System Configuration
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=140 \
	ro.sf.rotation=270 \
	ro.sf.hwrotation=270 \
	ro.input.hwrotation=270 \
	lockscreen.rot_override=true \
	ro.property.fontScale=1.4 \
	ro.navbar.flip=false \
	persist.sys.timezone=Europe/Moscow \
	persist.sys.language=ru \
	persist.sys.country=RU

# Navigation bar
PRODUCT_PROPERTY_OVERRIDES += \
	qemu.hw.mainkeys=0

# Mark as low ram device
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.low_ram=true

# Disable atlas services on low-ram targets
PRODUCT_PROPERTY_OVERRIDES += \
    config.disable_atlas=true

# ART
#PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.dex2oat-flags=--no-watch-dog \
	dalvik.vm.dex2oat-filter=interpret-only \
	dalvik.vm.image-dex2oat-filter=speed \
	dalvik.vm.profiler=1

PRODUCT_DEX_PREOPT_DEFAULT_FLAGS := \
	--compiler-filter=interpret-only

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version = 131072 \
	ro.egl.destroy_after_detach=true \
	drm.service.enabled=false

PRODUCT_PROPERTY_OVERRIDES += \
	ro.kernel.android.checkjni=0

# Fix Graphics Issues
PRODUCT_PROPERTY_OVERRIDES += \
	ro.zygote.disable_gl_preload=true \
	ro.bq.gpu_to_cpu_unsupported=1

# Disable dirty region for Mali
PRODUCT_PROPERTY_OVERRIDES += \
debug.hwui.render_dirty_regions=false

# Debug
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.allow.mock.location=0 \
    ro.debuggable=1 \
    ro.hardware=sun8i

# USB
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    wpa_supplicant

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15 \
	ro.inet.wlan.type=8189es \
	keyguard.no_require_sim=true

 # NO ril device
PRODUCT_PROPERTY_OVERRIDES += \
	ro.radio.noril=true

# APP CONFIGS
PRODUCT_CHARACTERISTICS := tablet

# Set the physical display size with PRODUCT_AAPT_CONFIG
# Options are small(~2"-3"), normal(~3"-4"), large(~4"-7"), xlarge(~7" and larger)
PRODUCT_AAPT_CONFIG := large
# Set the preferred asset density with PRODUCT_AAPT_PREF_CONFIG
# See android CCD for valid options
PRODUCT_AAPT_PREF_CONFIG := mdpi
# A list of dpis to select prebuilt apk, in precedence order.
# See android CCD for valid options
PRODUCT_AAPT_PREBUILT_DPI := mdpi hdpi tvdpi ldpi

