## Specify phone tech before including full_phone

# Release name
PRODUCT_RELEASE_NAME := Polaris

# Inherit device configuration
$(call inherit-product, device/oysters/t72ms/device.mk)
$(call inherit-product, device/oysters/t72ms/lineage_t72ms-blobs.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)
$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 480
TARGET_SCREEN_WIDTH := 800

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := t72ms
PRODUCT_NAME := lineage_t72ms
PRODUCT_BRAND := Oysters
PRODUCT_MODEL := Oysters T72 MS
PRODUCT_MANUFACTURER := Oysters
