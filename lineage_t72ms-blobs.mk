
LOCAL_PATH := device/oysters/t72ms

# Bootanimation
PRODUCT_COPY_FILES +=  \
    $(LOCAL_PATH)/_prebuilt/system/media/bootanimation.zip:system/media/bootanimation.zip

#egl
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,$(LOCAL_PATH)/_prebuilt/system/lib/egl,system/lib/egl) \
    $(LOCAL_PATH)/_prebuilt/system/lib/hw/gralloc.sun8i.so:system/lib/hw/gralloc.sun8i.so \
    $(LOCAL_PATH)/_prebuilt/system/lib/libMali.so:system/lib/libMali.so \
    $(LOCAL_PATH)/_prebuilt/system/lib/libion.so:system/lib/libion.so

# Modules
# PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,$(LOCAL_PATH)/_prebuilt/system/vendor/modules,system/vendor/modules)

# Touchscreens
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,$(LOCAL_PATH)/_prebuilt/system/usr/idc,system/usr/idc)

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/_prebuilt/system/lib/hw/sensors.polaris.so:system/lib/hw/sensors.polaris.so \
	$(LOCAL_PATH)/_prebuilt/system/usr/gsensor.cfg:system/usr/gsensor.cfg \
	$(LOCAL_PATH)/_prebuilt/system/bin/sensors.sh:system/bin/sensors.sh

# Media files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/_prebuilt/system/etc/audio_effects.conf:system/etc/audio_effects.conf \
    $(LOCAL_PATH)/_prebuilt/system/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/_prebuilt/system/etc/phone_volume.conf:system/etc/phone_volume.conf \
    $(LOCAL_PATH)/_prebuilt/system/etc/media_codecs.xml:system/etc/media_codecs.xml \

# WiFi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/_prebuilt/system/vendor/modules/wifi_efuse.map:system/vendor/modules/wifi_efuse.map \
    $(LOCAL_PATH)/_prebuilt/system/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Tablet core hardware permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/_prebuilt/system/etc/permissions/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/_prebuilt/system/etc/camera.cfg:system/etc/camera.cfg \
    $(LOCAL_PATH)/_prebuilt/system/etc/media_profiles.xml:system/etc/media_profiles.xml

# Lights
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/_prebuilt/system/lib/hw/lights.polaris.so:system/lib/hw/lights.polaris.so \

