INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 192.168.100.146
THEOS_DEVICE_PORT = 22
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ad_nga

ad_nga_FILES = Tweak.x
//ad_nga_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
