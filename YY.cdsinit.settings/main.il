;;================================
;; YY.cdsinit Settings and Keybindings
;;================================
;; This file contains configuration for Virtuoso editors:
;; - Viva waveform viewer (graphs and legends)
;; - Schematics editor (keybindings and display settings)
;; - Symbol editor (keybindings)
;; - Layout editor (keybindings and snap spacing)
;; - Technology-specific component annotations
;;

printf("\n\nLoading YY.cdsinit.....\n")

;;================================
;; Load Technology-Specific Settings
;;================================
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/tech_settings.il"))

;;================================
;; Viva (Waveform Viewer) Configuration
;;================================
;; Configure fonts for waveform viewing
envSetVal("viva.axis" "font" 'string "Arial,12,-1,5,50,0,0,0,0,0")
envSetVal("viva.traceLegend" "font" 'string "Arial,12,-1,5,50,0,0,0,0,0")
envSetVal("viva.graph" "titleFont" 'string "Arial,14,-1,5,55,0,0,0,0,0")
;; Set trace colors for better visibility
envSetVal("viva.graph" "colorBank" 'string "cyan; lime; violet; orange; yellow; silver; orangeRed; white; skyBlue; springGreen; pink")
;; Increase line thickness for trace visibility
envSetVal("viva.trace" "lineThickness" 'string "thick")

printf("\tYY.cdsinit: \t Viva settings ok!\n")

;;================================
;; Schematics Editor Configuration
;;================================
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
;; Annotation keybindings
;; Ctrl+1: Show DC operating points and voltages
hiSetBindKey("Schematics" "Ctrl<Key>1" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'dcOpPoints) sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'dcNodeVoltages)")
;; Ctrl+2: Show transient operating points and voltages
hiSetBindKey("Schematics" "Ctrl<Key>2" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'tranOpPoints) sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'tranNodeVoltages)")
;; Ctrl+0: Reset to default annotations
hiSetBindKey("Schematics" "Ctrl<Key>0" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'defaults)")

printf("\tYY.cdsinit: \t Schematics settings ok!\n")

;;================================
;; Symbol Editor Configuration
;;================================
;; Mouse wheel zoom bindings for symbol editor
hiSetBindKey("Symbol" "None<Btn4Down>" "hiZoomInAtMouse()")
hiSetBindKey("Symbol" "None<Btn5Down>" "hiZoomOutAtMouse()")

printf("\tYY.cdsinit: \t Symbol settings ok!\n")

;;================================
;; Layout Editor Configuration
;;================================
;; Layout keybindings
hiSetBindKey("Layout" "<key>A" "leHiQuickAlign()")          ;; A: Quick align
hiSetBindKey("Layout" "<key>H" "leHiRepeatCopy()")          ;; H: Repeat copy
hiSetBindKey("Layout" "<key>p" "leHiCreateWire()")          ;; p: Create wire
hiSetBindKey("Layout" "Shift<key>C" "leHiDescend()")        ;; Shift+C: Descend into block
hiSetBindKey("Layout" "Shift<key>X" "geSave()")             ;; Shift+X: Save
;; Set snap spacing to 5nm for precise placement
envSetVal("layout" "xSnapSpacing" 'float 0.005)
envSetVal("layout" "ySnapSpacing" 'float 0.005)

printf("\tYY.cdsinit: \t Layout settings ok!\n")

;;================================
;; analogLib Technology Settings
;;================================
;; Define annotation preferences for passive components
res_anno_preference = "res v i pwr"    ;; Resistor: display resistance, voltage, current, power
cap_anno_preference = "cap v"          ;; Capacitor: display capacitance, voltage
techname = "analogLib"
res_list = list("res")
cap_list = list("cap")

;; Apply annotations if analogLib technology is available
if( ddGetObj(techname) then
    printf("\n\tYY.cdsinit: \t %s detected!\n" techname)
    ;; Apply resistor annotations
    foreach(res_type res_list
        let( (cdfId)
            cdfId = cdfGetBaseCellCDF(ddGetObj(techname res_type))
            when( cdfId
                cdfId->opPointLabelSet = res_anno_preference
            )
        )
        printf("\t  Set annotation %s: %s \n", res_type, res_anno_preference)
    )
    ;; Apply capacitor annotations
    foreach(cap_type cap_list
        let( (cdfId)
            cdfId = cdfGetBaseCellCDF(ddGetObj(techname cap_type))
            when( cdfId
                cdfId->opPointLabelSet = cap_anno_preference
            )
        )
        printf("\t  Set annotation %s: %s \n", cap_type, cap_anno_preference)
    )
    printf("\tYY.cdsinit: \t %s settings ok!\n", techname)
)

;;================================
;; Process-Specific MOSFET Annotations
;;================================
;; Define annotation preferences for MOS transistors
;; These display key device parameters during simulation results annotation
anno_preference = "id gm rout vgs vds vdsat vth region"

;; Apply technology-specific MOS settings if tech_list is defined in tech_settings.il
if(boundp('tech_list) then
    for(tech_num 0 (length(tech_list)-1)
        techname = nth(tech_num tech_list)
        ;; Check if technology library is available
        if( ddGetObj(techname) then
            printf("\n\tYY.cdsinit: \t %s detected!\n" techname)
            ;; Get the MOS device list for this technology
            mos_list = nth(tech_num mos_list_all)
            ;; Apply annotations to each MOS device type
            foreach(mos_type mos_list
                let( (cdfId)
                    cdfId = cdfGetBaseCellCDF(ddGetObj(techname mos_type))
                    when( cdfId
                        cdfId->opPointLabelSet = anno_preference
                    )
                )
                printf("\t  Set annotation %s: %s \n", mos_type, anno_preference)
            )
            printf("\tYY.cdsinit: \t %s settings ok!\n", techname)
        )
    )
)