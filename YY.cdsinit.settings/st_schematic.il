;;================================
;; Filename: YY.cdsinit.settings/st_schematic.il
;; Version: 4.0.0
;; Date: Aug. 26, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Schematic Settings and Keybindings
;;================================

procedure( YY_schematic_settings()
    ;; Mouse wheel zoom bindings
    hiSetBindKey("Schematics" "None<Btn4Down>" "hiZoomInAtMouse()")
    hiSetBindKey("Schematics" "None<Btn5Down>" "hiZoomOutAtMouse()")

    ;; Ctrl + Mouse wheel for panning
    hiSetBindKey("Schematics" "Ctrl<Btn4Down>" "geScroll(nil \"n\" nil)")
    hiSetBindKey("Schematics" "Ctrl<Btn5Down>" "geScroll(nil \"s\" nil)")

    ;; Enable dynamic highlighting of symbols and nets
    envSetVal("schematic" "symDynamicHilightOn" 'boolean t)
    envSetVal("schematic" "schDynamicNetHilightOn" 'boolean t)
    envSetVal("schematic" "schDynamicNetHilightNoIslands" 'boolean nil)

    ;; Annotation keybindings for ADE Explorer Results
    ;; Ctrl+1: Show DC operating points and voltages
    hiSetBindKey("Schematics" "Ctrl<Key>1" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'dcOpPoints) sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'dcNodeVoltages)")
    ;; Ctrl+2: Show transient operating points and voltages
    hiSetBindKey("Schematics" "Ctrl<Key>2" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'tranOpPoints) sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'tranNodeVoltages)")
    ;; Ctrl+0: Reset to default annotations
    hiSetBindKey("Schematics" "Ctrl<Key>0" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'defaults)")

    YY_print("Schematics settings ok!")
)