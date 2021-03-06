define KernelPackage/ata-ahci-mtk
  TITLE:=Mediatek AHCI Serial ATA support
  KCONFIG:=CONFIG_AHCI_MTK
  FILES:= \
	$(LINUX_DIR)/drivers/ata/ahci_mtk.ko \
	$(LINUX_DIR)/drivers/ata/libahci_platform.ko
  AUTOLOAD:=$(call AutoLoad,40,libahci libahci_platform ahci_mtk,1)
  $(call AddDepends/ata)
  DEPENDS+=@TARGET_mediatek_mt7622
endef

define KernelPackage/ata-ahci-mtk/description
 Mediatek AHCI Serial ATA host controllers
endef

$(eval $(call KernelPackage,ata-ahci-mtk))

define KernelPackage/sdhci-mtk
  SUBMENU:=Other modules
  TITLE:=Mediatek SDHCI driver
  DEPENDS:=@TARGET_mediatek_mt7622 +kmod-sdhci
  KCONFIG:=CONFIG_MMC_MTK 
  FILES:= \
	$(LINUX_DIR)/drivers/mmc/host/mtk-sd.ko
  AUTOLOAD:=$(call AutoProbe,mtk-sd,1)
endef

$(eval $(call KernelPackage,sdhci-mtk))

define KernelPackage/crypto-hw-mtk
  TITLE:= MediaTek's Crypto Engine module
  DEPENDS:=@TARGET_mediatek
  KCONFIG:= \
	CONFIG_CRYPTO_HW=y \
	CONFIG_CRYPTO_AES=y \
	CONFIG_CRYPTO_AEAD=y \
	CONFIG_CRYPTO_SHA1=y \
	CONFIG_CRYPTO_SHA256=y \
	CONFIG_CRYPTO_SHA512=y \
	CONFIG_CRYPTO_HMAC=y \
	CONFIG_CRYPTO_DEV_MEDIATEK
  FILES:=$(LINUX_DIR)/drivers/crypto/mediatek/mtk-crypto.ko
  AUTOLOAD:=$(call AutoLoad,90,mtk-crypto)
  $(call AddDepends/crypto)
endef

define KernelPackage/crypto-hw-mtk/description
  MediaTek's EIP97 Cryptographic Engine driver.
endef

$(eval $(call KernelPackage,crypto-hw-mtk))

define KernelPackage/nat-hw-mtk
  TITLE:= MediaTek's hardware NAT module
  DEPENDS:=@TARGET_mediatek @!LINUX_4_19
  KCONFIG:= \
	CONFIG_NET_MEDIATEK_HNAT=y
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/mediatek/mtk_hnat/mtkhnat.ko
  AUTOLOAD:=$(call AutoLoad,90,mtkhnat)
endef

define KernelPackage/nat-hw-mtk/description
  MediaTek's hardware NAT driver.
endef

$(eval $(call KernelPackage,nat-hw-mtk))

define KernelPackage/mt6625l-wlan-gen2
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=Mediatek mt66xx wlan_gen2 driver
  DEPENDS:=@TARGET_mediatek +kmod-mac80211 +@DRIVER_11N_SUPPORT
  KCONFIG:= \
    CONFIG_MTK_WAPI_SUPPORT=y \
    CONFIG_MTK_PASSPOINT_R1_SUPPORT=y \
    CONFIG_MTK_PASSPOINT_R2_SUPPORT=y \
    CONFIG_MTK_WIFI_MCC_SUPPORT=y \
    CONFIG_MTK_COMBO_WIFI
  FILES:=$(LINUX_DIR)/drivers/misc/mediatek/connectivity/wlan/gen2/wlan_gen2.ko
  AUTOLOAD:=$(call AutoProbe,wlan_gen2)
endef

define KernelPackage/wlan-gen2/description
 This package contains the Mediatek mt66xx wlan_gen2 kernel module
endef

$(eval $(call KernelPackage,mt6625l-wlan-gen2))