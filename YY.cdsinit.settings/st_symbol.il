;;================================
;; Filename: YY.cdsinit.settings/st_symbol.il
;; Version: 4.0.0
;; Date: Aug. 27, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Symbol Settings and Keybindings
;;================================

procedure( YY_symbol_settings()
    ;; Mouse wheel zoom bindings
    hiSetBindKey("Symbol" "None<Btn4Down>" "hiZoomInAtMouse()")
    hiSetBindKey("Symbol" "None<Btn5Down>" "hiZoomOutAtMouse()")

    YY_print("Symbol settings ok!")
)