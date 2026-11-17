;;================================
;; Filename: YY.cdsinit.settings/fn_help.il
;; Version: 4.0.0
;; Date: Aug. 26, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Help Function
;;================================

procedure( YY_help()
    YY_help_schematic()
    YY_help_layout()
    YY_help_ciw()
    YY_help_symbol()
    YY_help_viva()
    YY_help_cdf()
    YY_print("\n")
    YY_print("YY.cdsinit command reference")
    YY_print("")
    YY_print("Use the following commands to get help on specific topics:")
    YY_print("  - YY_help_ciw()")
    YY_print("  - YY_help_schematic()")
    YY_print("  - YY_help_symbol()")
    YY_print("  - YY_help_layout()")
    YY_print("  - YY_help_viva()")
    YY_print("  - YY_help_cdf()")
    YY_print("")
)

procedure( YY_help_ciw()
    YY_print("[CIW]")
    YY_print("  YY_ciw_settings() - Set CIW and label fonts to 16 point.")
)

procedure( YY_help_schematic()
    YY_print("[Schematic]")
    YY_print("  Mouse wheel - Zoom in or out at the cursor.")
    YY_print("  Ctrl + mouse wheel - Pan up or down.")
    YY_print("  Ctrl + 1 - Show DC operating points and node voltages (ADE Explorer).")
    YY_print("  Ctrl + 2 - Show transient operating points and node voltages (ADE Explorer).")
    YY_print("  Ctrl + 0 - Restore default annotations (ADE Explorer).")
)

procedure( YY_help_symbol()
    YY_print("[Symbol]")
    YY_print("  Mouse wheel - Zoom in or out at the cursor.")
)

procedure( YY_help_layout()
    YY_print("[Layout]")
    YY_print("  A - Quick align.")
    YY_print(" F4 - Toggle partial selection.")
    YY_print("  C - Copy.")
    YY_print("  E - Edit display options.")
    YY_print("  H - Repeat copy.")
    YY_print("  O - Create via.")
    YY_print("  P - Create wire.")
    YY_print("  Shift + C - Descend into block.")
    YY_print("  Shift + X - Save.")
)

procedure( YY_help_viva()
    YY_print("[Viva]")
    YY_print("  Sets Arial fonts, a white graph background, a custom color bank, and thick trace lines.")
)

procedure( YY_help_cdf()
    YY_print("[CDF and pPar]")
    YY_print("  YY_autosync_CDF(lib cell) - Add schematic pPars to the base CDF.")
    YY_print("  YY_set_pPar(lib cell) - Prompt for pPar default values.")
    YY_print("  YY_sortpar_CDF(lib cell) - Sort base CDF parameters alphabetically.")
)

