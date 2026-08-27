;;================================
;; Filename: YY.cdsinit.settings/st_symbol.il
;; Version: 4.1.0
;; Date: Aug. 27, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Layout Settings and Keybindings
;;================================

procedure( YY_layout_settings(layout_spacing)
    hiSetBindKey("Layout" "<key>A" "leHiQuickAlign()")          ;; a: Quick align
    hiSetBindKey("Layout" "<key>C" "leHiCopy()")                ;; c: Copy
    hiSetBindKey("Layout" "<key>E" "leHiEditDisplayOptions()")  ;; e: Edit display options
    hiSetBindKey("Layout" "<key>H" "leHiRepeatCopy()")          ;; h: Repeat copy
    hiSetBindKey("Layout" "<key>O" "leHiCreateVia()")           ;; o: Create via
    hiSetBindKey("Layout" "<key>P" "leHiCreateWire()")          ;; p: Create wire
    hiSetBindKey("Layout" "Shift<key>C" "leHiDescend()")        ;; Shift + c: Descend into block
    hiSetBindKey("Layout" "Shift<key>X" "geSave()")             ;; Shift + x: Save
    ;; Set snap spacing to 5nm for precise placement
    envSetVal("layout" "xSnapSpacing" 'float layout_spacing)
    envSetVal("layout" "ySnapSpacing" 'float layout_spacing)

    printf("\tYY.cdsinit: \t Layout settings ok!\n")
)