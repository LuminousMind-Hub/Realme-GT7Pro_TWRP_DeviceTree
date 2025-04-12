#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/rmx5010

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Release name
PRODUCT_RELEASE_NAME := rmx5010

## Device identifier
PRODUCT_DEVICE := rmx5010
PRODUCT_NAME := twrp_rmx5010
PRODUCT_BRAND := realme
PRODUCT_MODEL := realme GT7 Pro
PRODUCT_MANUFACTURER := realme

# Assert
TARGET_OTA_ASSERT_DEVICE := RMX5010,RE6018L1

# Theme
TW_STATUS_ICONS_ALIGN := center
TW_Y_OFFSET := 111
TW_H_OFFSET := -111
