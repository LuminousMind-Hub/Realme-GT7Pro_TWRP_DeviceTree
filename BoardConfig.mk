#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/rmx5010

# Building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := oryon

# Power
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
PRODUCT_PLATFORM := sun
TARGET_BOOTLOADER_BOARD_NAME := qssi
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := sun
TARGET_BOARD_PLATFORM_GPU := qcom-adreno830
QCOM_BOARD_PLATFORMS += sun

# Kernel
TARGET_KERNEL_ARCH            := arm64
TARGET_KERNEL_HEADER_ARCH     := arm64
BOARD_KERNEL_IMAGE_NAME       := Image
BOARD_BOOT_HEADER_VERSION     := 4
BOARD_KERNEL_PAGESIZE         := 4096
TARGET_KERNEL_CLANG_COMPILE   := true
TARGET_PREBUILT_KERNEL        := $(DEVICE_PATH)/prebuilt/kernel
BOARD_MKBOOTIMG_ARGS          += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS          += --pagesize $(BOARD_KERNEL_PAGESIZE)

# Ramdisk use lz4
BOARD_RAMDISK_USE_LZ4 := true

# A/B
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_dlkm

AB_OTA_PARTITIONS += \
    my_bigball \
    my_carrier \
    my_company \
    my_engineering \
    my_heytap \
    my_manifest \
    my_preload \
	my_product \
    my_region \
    my_stock

# Verified Boot
BOARD_AVB_ENABLE := true

# Partitions
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Partitions
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 15569256448
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 15565062144
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab

# Prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
TW_USE_FSCRYPT_POLICY := 2
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Tool
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_LPTOOLS := true

# F2FS
TW_ENABLE_FS_COMPRESSION := true

# Debug
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace

# Fastbootd
TW_INCLUDE_FASTBOOTD := true

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true

# Other TWRP Configurations
TW_THEME := portrait_hdpi
TW_FRAMERATE := 120
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_NO_EXFAT_FUSE := true
TW_USE_TOOLBOX := true
TARGET_USES_MKE2FS := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := zh_CN
TW_DEFAULT_BRIGHTNESS := 1229
TW_EXCLUDE_APEX := true
TW_HAS_EDL_MODE := false
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_LOAD_VENDOR_MODULES := "oplus_bsp_tp_tcm_S3908.ko oplus_bsp_tp_tcm_S3910.ko oplus_bsp_tp_novatek_common.ko oplus_bsp_tp_nt36672c_noflash.ko oplus_bsp_tp_goodix_comnon.ko q6_pdr_dlkm.ko q6_notifier_dlkm.ko snd_event_dlkm.ko gpr_dlkm.ko spf_core_dlkm.ko adsp_loader_dlkm.ko oplus_chg_v2.ko"
#TW_LOAD_VENDOR_MODULES := "oplus_bsp_waker_identify.ko msm_sysstats.ko msm_show_resume_irq.ko mhi.ko mhi_dev_uci.ko mhi_dev_satellite.ko pinctrl-spmi-gpio.ko pinctrl-spmi-mpp.ko pci-msm-drv.ko clk-scmi.ko evacc-tuna.ko gpucc-tuna.ko cambistmclkcc-tuna.ko camcc-tuna.ko debugcc-sun.ko videocc-tuna.ko bam_dma.ko msm_gpi.ko qcom_cpuss_sleep_stats_v4.ko pcie-pdc.ko pdr_interface.ko qmi_helpers.ko heap_mem_ext_v01.ko msm_memshare.ko smp2p.ko smp2p_sleepstate.ko qsee_ipc_irq_bridge.ko glink_probe.ko qcom_stats.ko eud.ko llcc_perfmon.ko llcc_heuristics.ko boot_stats.ko tmecom-intf.ko qcom_va_minidump.ko qcom_dynamic_ramoops.ko hung_task_enh.ko memlat.ko bwmon.ko cpufreq_stats_scmi_v3.ko mpam.ko cpu_mpam.ko platform_mpam.ko slc_mpam.ko mpam_msc.ko mpam_msc_slc.ko cpucp_log.ko sys_pm_vx.ko mem-hooks.ko mem-offline.ko sps_drv.ko qcom_ramdump.ko sysmon_subsystem_stats.ko cdsprm.ko adsp_sleepmon.ko panel_event_notifier.ko qti_pmic_glink.ko altmode-glink.ko qti_battery_debug.ko charger-ulog-glink.ko pmic-glink-debug.ko wcd_usbss_i2c.ko dmesg_dumper.ko gh_tlmm_vm_mem_access.ko msm_performance.ko msm_show_epoch.ko qti_dmof_scmi.ko oplus_mm_kevent.ko oplus_mm_kevent_fb.ko oplus_trackpoint_report.ko oplus_bsp_fpga_notify.ko qti-fixed-regulator.ko qcom-amoled-regulator.ko qti-ocp-notifier.ko hvc_gunyah.ko msm_geni_serial.ko rdbg.ko qcom_iommu_debug.ko drm_dp_aux_bus.ko drm_display_helper.ko lt9611uxc.ko oplus_bsp_fw_update.ko oplus_bsp_tp_notify.ko oplus_magcvr_notify.ko qseecom_proxy.ko haptic_feedback.ko qcom-i2c-pmic.ko spi-msm-geni.ko q2spi-geni.ko spmi-pmic-arb-debug.ko msm_sharedmem.ko phy-generic.ko phy-qcom-emu.ko phy-msm-ssusb-qmp.ko phy-msm-m31-eusb2.ko dwc3-msm.ko xhci-sideband.ko f_fs_ipc_log.ko usb_f_cdev.ko usb_f_ccid.ko usb_f_qdss.ko usb_f_gsi.ko ucsi_qti_glink.ko repeater.ko repeater-qti-pmic-eusb2.ko redriver.ko nb7vpq904m.ko pm8941-pwrkey.ko qpnp-power-on.ko qcom-hv-haptics.ko i2c-msm-geni.ko i3c-master-msm-geni.ko qcom-pon.ko reboot-mode.ko oplus_chg_v2.ko test-kit.ko qcom-spmi-temp-alarm.ko qti_qmi_sensor_v2.ko qti_qmi_cdev.ko bcl_soc.ko qti_userspace_cdev.ko ddr_cdev.ko qti_cpufreq_cdev.ko thermal_config.ko qti_devfreq_cdev.ko max31760_fan.ko gpu_dump_skip_cdev.ko qcom_edac.ko qcom_lpm.ko leds-qcom-flash.ko leds-qcom-lpg.ko leds-qti-flash.ko si_core_module.ko mem_object.ko qcom-rng.ko qcom_pil_info.ko rproc_qcom_common.ko qcom_q6v5.ko qcom_q6v5_pas.ko qcom_sysmon.ko qcom_spss.ko qcom_glink.ko qcom_glink_smem.ko qcom_glink_spss.ko qcom_smd.ko glink_pkt.ko gh_ctrl.ko gh_irq_lend.ko gh_rm_booster.ko gh_mem_notifier.ko gh_panic_notifier.ko governor_msm_adreno_tz.ko governor_gpubw_mon.ko qcom-spmi-adc5-gen3.ko qcom-vadc-common.ko qti-glink-adc.ko nvmem_qfprom.ko qnoc-tuna.ko slimbus.ko slim-qcom-ngd-ctrl.ko hwmon.ko qti_amoled_ecm.ko coresight.ko coresight-tmc.ko coresight-funnel.ko coresight-replicator.ko coresight-stm.ko coresight-cti.ko coresight-tpdm.ko coresight-tpda.ko coresight-trace-noc.ko coresight-tgu.ko coresight-csr.ko coresight-dummy.ko coresight-remote-etm.ko coresight-tmc-sec.ko coresight-qmi.ko coresight-uetm.ko stm_core.ko stm_p_ost.ko stm_console.ko stm_heartbeat.ko stm_ftrace.ko snd-usb-audio-qmi.ko snd-soc-hdmi-codec.ko cfg80211.ko mac80211.ko qrtr-smd.ko qrtr-tun.ko qrtr-mhi.ko camera_extension.ko horae_shell_temp.ko mtk_wdt.ko oplus_ak09970.ko oplus_binder_strategy.ko oplus_bsp_cs_press_f71.ko oplus_bsp_dfr_combkey_monitor.ko oplus_bsp_dfr_dump_device_info.ko oplus_bsp_dfr_dump_reason.ko oplus_bsp_dfr_fdleak_check.ko oplus_bsp_dfr_force_shutdown.ko oplus_bsp_dfr_hung_task_enhance.ko oplus_bsp_dfr_init_watchdog.ko oplus_bsp_dfr_keyevent_handler.ko oplus_bsp_dfr_kmsg_wb.ko oplus_bsp_dfr_last_boot_reason.ko oplus_bsp_dfr_ordump.ko oplus_bsp_dfr_phoenix.ko oplus_bsp_dfr_pmic_monitor.ko oplus_bsp_dfr_pmic_watchdog.ko oplus_bsp_dfr_shutdown_detect.ko oplus_bsp_dfr_shutdown_speed.ko oplus_bsp_dfr_theia.ko oplus_bsp_dfr_ubt.ko oplus_bsp_dynamic_readahead.ko oplus_bsp_fpga_monitor.ko oplus_bsp_game_opt.ko oplus_bsp_hybridswap_zram.ko oplus_bsp_ist_down.ko oplus_bsp_ist_up.ko oplus_bsp_kshrink_slabd.ko oplus_bsp_kswapd_opt.ko oplus_bsp_memleak_detect.ko oplus_bsp_midas.ko oplus_bsp_mxm_down.ko oplus_bsp_mxm_up.ko oplus_bsp_pcppages_opt.ko oplus_bsp_proactive_compact.ko oplus_bsp_sched_ext.ko oplus_bsp_sigkill_diagnosis.ko oplus_bsp_synaptics_tcm2.ko oplus_bsp_tp_common.ko oplus_bsp_tp_custom.ko oplus_bsp_tp_focal_common.ko oplus_bsp_tp_ft3518.ko oplus_bsp_tp_ft3658u_spi.ko oplus_bsp_tp_ft3681.ko oplus_bsp_tp_ft3683g.ko oplus_bsp_tp_goodix_comnon.ko oplus_bsp_tp_gt9916.ko oplus_bsp_tp_gt9966.ko oplus_bsp_tp_ilitek7807s.ko oplus_bsp_tp_ilitek_common.ko oplus_bsp_tp_novatek_common.ko oplus_bsp_tp_nt36528_noflash.ko oplus_bsp_tp_nt36532_noflash.ko oplus_bsp_tp_nt36672c_noflash.ko oplus_bsp_tp_syna_common.ko oplus_bsp_tp_tcm_S3908.ko oplus_bsp_tp_tcm_S3910.ko oplus_bsp_tp_td4377_noflash.ko oplus_bsp_tri_key.ko oplus_bsp_uff_fp_driver.ko oplus_bsp_uxmem_opt.ko oplus_bsp_zram_opt.ko oplus_bsp_zsmalloc.ko oplus_connectivity_routerboost.ko oplus_connectivity_sla.ko oplus_freqqos_monitor.ko oplus_locking_strategy.ko oplus_lock_torture.ko oplus_magcvr_ak09973.ko oplus_magcvr_mxm1120.ko oplus_magnetic_cover.ko oplus_network_app_monitor.ko oplus_network_data_module.ko oplus_network_dns_hook.ko oplus_network_esim.ko oplus_network_game_first.ko oplus_network_kernel_state_monitor.ko oplus_network_linkpower_module.ko oplus_network_oem_qmi.ko oplus_network_qr_scan.ko oplus_network_rf_cable_monitor.ko oplus_network_satellite.ko oplus_network_satellite_rpc.ko oplus_network_satellite_rsmc.ko oplus_network_sched.ko oplus_network_score.ko oplus_network_sim_detect.ko oplus_network_snapshot.ko oplus_network_stats_calc.ko oplus_network_tuning.ko oplus_network_vnet.ko oplus_power_hook.ko oplus_secure_common.ko oplus_secure_guard_new.ko oplus_sensor_deviceinfo.ko oplus_sensor_feedback.ko oplus_sensor_interact.ko oplus_sensor_ir_core.ko oplus_sensor_kookong_ir_spi.ko oplus_sync_fence.ko oplus_sys_hans.ko oplus_sys_stability_helper.ko oplus_wificapcenter.ko oplus_wifi_wsa.ko thermal_pa_adc.ko qca_cld3_peach.ko qca_cld3_peach_v2.ko cnss2.ko cnss_plat_ipc_qmi_svc.ko wlan_firmware_service.ko cnss_nl.ko cnss_prealloc.ko cnss_utils.ko q6_notifier_dlkm.ko spf_core_dlkm.ko audpkt_ion_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko q6_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko q6_pdr_dlkm.ko pinctrl_lpi_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko snd_event_dlkm.ko wcd_core_dlkm.ko mbhc_dlkm.ko wcd9xxx_dlkm.ko stub_dlkm.ko machine_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko hdmi_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_dlkm.ko wsa884x_dlkm.ko wsa883x_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd939x_dlkm.ko wcd939x_slave_dlkm.ko lpass_bt_swr_dlkm.ko qmp_dlkm.ko oplus_audio_extend.ko oplus_audio_aw882xx.ko oplus_audio_tfa98xx_v6.ko oplus_audio_sipa.ko oplus_audio_sipa_tuning.ko q6_notifier_dlkm.ko spf_core_dlkm.ko audpkt_ion_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko q6_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko q6_pdr_dlkm.ko pinctrl_lpi_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko snd_event_dlkm.ko wcd_core_dlkm.ko mbhc_dlkm.ko wcd9xxx_dlkm.ko stub_dlkm.ko machine_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko hdmi_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_dlkm.ko wsa884x_dlkm.ko wsa883x_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd939x_dlkm.ko wcd939x_slave_dlkm.ko lpass_bt_swr_dlkm.ko qmp_dlkm.ko oplus_audio_extend.ko oplus_audio_aw882xx.ko oplus_audio_tfa98xx_v6.ko oplus_audio_sipa.ko oplus_audio_sipa_tuning.ko smem-mailbox.ko qcedev-mod_dlkm.ko qcrypto-msm_dlkm.ko qce50_dlkm.ko qrng_dlkm.ko hdcp_qseecom_dlkm.ko smmu_proxy_dlkm.ko smcinvoke_dlkm.ko tz_log_dlkm.ko btpower.ko radio-i2c-rtc6226-qca.ko btfmcodec.ko btfm_slim_codec.ko bt_fm_swr.ko qca_cld3_peach.ko qca_cld3_peach_v2.ko cnss2.ko cnss_plat_ipc_qmi_svc.ko wlan_firmware_service.ko cnss_nl.ko cnss_prealloc.ko cnss_utils.ko q6_notifier_dlkm.ko spf_core_dlkm.ko audpkt_ion_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko q6_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko q6_pdr_dlkm.ko pinctrl_lpi_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko snd_event_dlkm.ko wcd_core_dlkm.ko mbhc_dlkm.ko wcd9xxx_dlkm.ko stub_dlkm.ko machine_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko hdmi_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_dlkm.ko wsa884x_dlkm.ko wsa883x_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd939x_dlkm.ko wcd939x_slave_dlkm.ko lpass_bt_swr_dlkm.ko qmp_dlkm.ko oplus_audio_extend.ko oplus_audio_aw882xx.ko oplus_audio_tfa98xx_v6.ko oplus_audio_sipa.ko oplus_audio_sipa_tuning.ko q6_notifier_dlkm.ko spf_core_dlkm.ko audpkt_ion_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko q6_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko q6_pdr_dlkm.ko pinctrl_lpi_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko snd_event_dlkm.ko wcd_core_dlkm.ko mbhc_dlkm.ko wcd9xxx_dlkm.ko stub_dlkm.ko machine_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko hdmi_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_dlkm.ko wsa884x_dlkm.ko wsa883x_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd939x_dlkm.ko wcd939x_slave_dlkm.ko lpass_bt_swr_dlkm.ko qmp_dlkm.ko oplus_audio_extend.ko oplus_audio_aw882xx.ko oplus_audio_tfa98xx_v6.ko oplus_audio_sipa.ko oplus_audio_sipa_tuning.ko btpower.ko radio-i2c-rtc6226-qca.ko btfmcodec.ko btfm_slim_codec.ko bt_fm_swr.ko camera.ko smem-mailbox.ko gsim.ko ipam.ko ipanetm.ko rmnet_core.ko rmnet_ctl.ko rmnet_offload.ko rmnet_perf_tether.ko rmnet_perf.ko rmnet_wlan.ko rmnet_mem.ko rmnet_shs.ko rmnet_aps.ko rmnet_sch.ko rmnet_wlan.ko msm_drm.ko frpc-adsprpc.ko stm_st54se_gpio.ko msm-eva.ko qbt_handler.ko msm_ext_display.ko sync_fence.ko msm_hw_fence.ko msm-mmrm.ko stm_nfc_i2c.ko nxp-nci.ko qcedev-mod_dlkm.ko qcrypto-msm_dlkm.ko qce50_dlkm.ko qrng_dlkm.ko hdcp_qseecom_dlkm.ko smmu_proxy_dlkm.ko smcinvoke_dlkm.ko tz_log_dlkm.ko spcom.ko spss_utils.ko synx-driver.ko ipclite.ko ipclite_test.ko goodix_ts.ko atmel_mxt_ts.ko st_fts.ko qts.ko msm_video.ko msm_kgsl.ko "
# TW_LOAD_VENDOR_MODULES := "q6_pdr_dlkm.ko q6_notifier_dlkm.ko snd_event_dlkm.ko gpr_dlkm.ko spf_core_dlkm.ko adsp_loader_dlkm.ko"
# TW_LOAD_VENDOR_MODULES := "q6_pdr_dlkm.ko q6_notifier_dlkm.ko snd_event_dlkm.ko gpr_dlkm.ko spf_core_dlkm.ko adsp_loader_dlkm.ko"
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone45/temp" # CPU-0-0-0
TW_BACKUP_EXCLUSIONS := /data/fonts
TW_DEVICE_VERSION := Realme_GT7Pro-A15
