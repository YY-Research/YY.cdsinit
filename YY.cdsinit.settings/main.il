;;================================
;; Filename: YY.cdsinit.settings/main.il
;; Version: 5.0.0
;; Date: Nov. 17, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Settings and Keybindings
;;================================
;; This file contains configuration for Virtuoso editors:
;; - Viva waveform viewer (graphs and legends)
;; - Schematics editor (keybindings and display settings)
;; - Symbol editor (keybindings)
;; - Layout editor (keybindings and snap spacing)
;; - Technology-specific component annotations

;; Load supporting functions and settings
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/fn_cdf.il"))
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/fn_help.il"))
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/fn_tech.il"))
YY_print("Loading YY.cdsinit.....")

;; Load editor-specific settings
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/st_ciw.il"))
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/st_symbol.il"))
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/st_schematic.il"))
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/st_layout.il"))
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/st_viva.il"))

;; Setting Parameters
YY_layout_snap_spacing = 0.005  ;; Layout snap spacing in microns (5nm) (default)

YY_print("[Usage] Type YY() to activate YY.cdsinit settings and keybindings.")
YY_print("        Type YY_help() to see a list of bindkeys.")

procedure( YY()  ;; Use command YY() to activate YY.cdsinit settings and keybindings
    ;; Initialize YY.cdsinit
    YY_init()

    ;; Define library-specific settings
    YY_analogLib_settings()
    YY_load_tech_settings()

    ;; Define bindkeys
    YY_ciw_settings()
    YY_schematic_settings()
    YY_symbol_settings()
    YY_layout_settings(YY_layout_snap_spacing)
    YY_viva_settings()
)