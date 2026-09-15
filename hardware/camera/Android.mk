
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_SHARED_LIBRARIES:= \
    libbinder \
    libutils \
    libcutils \
    libcamera_client \
    libui \
    libjpeg \
    libjhead \
	
LOCAL_C_INCLUDES += 								\
	frameworks/base/core/jni/android/graphics 		\
	frameworks/native/include/media/openmax			\
	hardware/libhardware/include/hardware			\
	frameworks/native/include						\
	system/media/camera/include     			\
	$(TARGET_HARDWARE_INCLUDE) \
	external/jpeg \
	external/jhead

LOCAL_SRC_FILES := \
	HALCameraFactory.cpp \
	PreviewWindow.cpp \
	CallbackNotifier.cpp \
	CCameraConfig.cpp \
	BufferListManager.cpp \
	OSAL_Mutex.c \
	OSAL_Queue.c \
	scaler.c \
	jdatadst.cpp \
	jpegConvert.cpp \
	exifwriter.c

# choose hal for new driver or old
SUPPORT_NEW_DRIVER := Y

ifeq ($(SUPPORT_NEW_DRIVER),Y)
LOCAL_CFLAGS += -DSUPPORT_NEW_DRIVER
LOCAL_SRC_FILES += \
	CameraHardware2.cpp \
	V4L2CameraDevice2.cpp
else
LOCAL_SRC_FILES += \
	CameraHardware.cpp \
	V4L2CameraDevice.cpp
endif

ifneq ($(filter nuclear%,$(TARGET_DEVICE)),)
LOCAL_CFLAGS += -D__SUN5I__
endif

ifneq ($(filter crane%,$(TARGET_DEVICE)),)
LOCAL_CFLAGS += -D__SUN4I__
endif

ifneq ($(filter t72ms,$(TARGET_DEVICE)),)
LOCAL_CFLAGS += -D__SUN6I__
endif

ifneq ($(filter t72ms,$(TARGET_DEVICE)),)
LOCAL_CFLAGS += -D__SUNXI__
endif


LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)

LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)
