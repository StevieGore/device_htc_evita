# Specify phone tech before including full_phone
$(call inherit-product, vendor/liquid/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := evita

# Inherit some common Liquid stuff.
$(call inherit-product, vendor/liquid/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/htc/evita/device_evita.mk)

# Device naming
PRODUCT_DEVICE := evita
PRODUCT_NAME := liquid_evita
PRODUCT_BRAND := htc
PRODUCT_MODEL := One X
PRODUCT_MANUFACTURER := HTC

# Set build fingerprint / ID / Product Name etc.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_evita BUILD_FINGERPRINT=cingular_us/evita/evita:4.1.2/JZO54K/79936.7:user/release-keys PRIVATE_BUILD_DESC="2.20.502.7 CL79936 release-keys" BUILD_NUMBER=79936
