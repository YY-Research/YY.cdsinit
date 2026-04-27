printf("\n\nLoading YY.cdsinit.....\n")
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/tech_settings.il"))

;;# Viva
envSetVal("viva.axis" "font" 'string "Arial,12,-1,5,50,0,0,0,0,0")
envSetVal("viva.traceLegend" "font" 'string "Arial,12,-1,5,50,0,0,0,0,0")
envSetVal("viva.graph" "titleFont" 'string "Arial,14,-1,5,55,0,0,0,0,0")
envSetVal("viva.graph" "colorBank" 'string "cyan; lime; violet; orange; yellow; silver; orangeRed; white; skyBlue; springGreen; pink")
envSetVal("viva.trace" "lineThickness" 'string "thick")

printf("\tYY.cdsinit: \t Viva settings ok!\n")

;;# Schematics
hiSetBindKey("Schematics" "None<Btn4Down>" "hiZoomInAtMouse()")
hiSetBindKey("Schematics" "None<Btn5Down>" "hiZoomOutAtMouse()")
hiSetBindKey("Schematics" "Ctrl<Btn4Down>" "geScroll(nil \"n\" nil)")
hiSetBindKey("Schematics" "Ctrl<Btn5Down>" "geScroll(nil \"s\" nil)")
envSetVal("schematic" "symDynamicHilightOn" 'boolean t)
envSetVal("schematic" "schDynamicNetHilightOn" 'boolean t)
envSetVal("schematic" "schDynamicNetHilightNoIslands" 'boolean nil)
hiSetBindKey("Schematics" "Ctrl<Key>1" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'dcOpPoints) sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'dcNodeVoltages)")
hiSetBindKey("Schematics" "Ctrl<Key>2" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'tranOpPoints) sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'tranNodeVoltages)")
hiSetBindKey("Schematics" "Ctrl<Key>0" "sevAnnotateResults(sevSession(hiGetCurrentWindow()) 'defaults)")

printf("\tYY.cdsinit: \t Schematics settings ok!\n")

;;# Symbol
hiSetBindKey("Symbol" "None<Btn4Down>" "hiZoomInAtMouse()")
hiSetBindKey("Symbol" "None<Btn5Down>" "hiZoomOutAtMouse()")

printf("\tYY.cdsinit: \t Symbol settings ok!\n")

;;# Layout
hiSetBindKey("Layout" "<key>A" "leHiQuickAlign()")
hiSetBindKey("Layout" "<key>H" "leHiRepeatCopy()")
hiSetBindKey("Layout" "<key>p" "leHiCreateWire()")
hiSetBindKey("Layout" "Shift<key>C" "leHiDescend()")
hiSetBindKey("Layout" "Shift<key>X" "geSave()")
envSetVal("layout" "xSnapSpacing" 'float 0.005)
envSetVal("layout" "ySnapSpacing" 'float 0.005)

printf("\tYY.cdsinit: \t Layout settings ok!\n")


;;# analogLib Settings
res_anno_preference = "res v i pwr"
cap_anno_preference = "cap v"
techname = "analogLib"
res_list = list("res")
cap_list = list("cap")
if( ddGetObj(techname) then
    printf("\n\tYY.cdsinit: \t %s detected!\n" techname)
    foreach(res_type res_list
        let( (cdfId)
            cdfId = cdfGetBaseCellCDF(ddGetObj(techname res_type))
            when( cdfId
                cdfId->opPointLabelSet = res_anno_preference
            )
        )
        printf("\t  Set annotation %s: %s \n", res_type, res_anno_preference)
    )
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


;;# Load Settings According to the tech
anno_preference = "id gm rout vgs vds vdsat vth region"

if(boundp('tech_list) then
    for(tech_num 0 (length(tech_list)-1)
        techname = nth(tech_num tech_list)
        if( ddGetObj(techname) then
            printf("\n\tYY.cdsinit: \t %s detected!\n" techname)
            mos_list = nth(tech_num mos_list_all)
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