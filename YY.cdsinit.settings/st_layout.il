;;================================
;; Filename: YY.cdsinit.settings/st_symbol.il
;; Version: 4.0.0
;; Date: Aug. 27, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Layout Settings and Keybindings
;;================================

procedure( YY_layout_settings()
    hiSetBindKey("Layout" "<key>A" "leHiQuickAlign()")          ;; A: Quick align
    hiSetBindKey("Layout" "<key>H" "leHiRepeatCopy()")          ;; H: Repeat copy
    hiSetBindKey("Layout" "<key>p" "leHiCreateWire()")          ;; p: Create wire
    hiSetBindKey("Layout" "Shift<key>C" "leHiDescend()")        ;; Shift+C: Descend into block
    hiSetBindKey("Layout" "Shift<key>X" "geSave()")             ;; Shift+X: Save
    ;; Set snap spacing to 5nm for precise placement
    envSetVal("layout" "xSnapSpacing" 'float 0.005)
    envSetVal("layout" "ySnapSpacing" 'float 0.005)

    printf("\tYY.cdsinit: \t Layout settings ok!\n")
)

