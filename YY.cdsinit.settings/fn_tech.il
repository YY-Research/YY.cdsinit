;;================================
;; Filename: YY.cdsinit.settings/fn_tech.il
;; Version: 4.0.0
;; Date: Aug. 27, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Technology Settings 
;;================================

;;================================
;; analogLib Technology Settings
;;================================
procedure( YY_analogLib_settings()
    let( (techname res_list cap_list res_anno_preference cap_anno_preference)
        techname = "analogLib"
        res_list = list("res")
        cap_list = list("cap")
        res_anno_preference = "res v i pwr"    ;; Resistor: display resistance, voltage, current, power
        cap_anno_preference = "cap v"          ;; Capacitor: display capacitance, voltage

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
    )
)


;;================================
;; Load Technology-Specific Settings
;;================================
procedure( YY_load_tech_settings()
    let( (YY_tech_settings_file anno_preference techname mos_list)
        if( !boundp('YY_cdsinit_filepath) then
            warn("YY.cdsinit: YY_cdsinit_filepath not defined, using current directory.\n")
            YY_cdsinit_filepath = "./"
        )
        YY_tech_settings_file = strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/tech_settings.il")
        if( isFile(YY_tech_settings_file) then
            load(YY_tech_settings_file)
        else
            warn("YY.cdsinit:\n\tMissing file %s, skipping technology-specific settings.\n" YY_tech_settings_file)
        )
        ;;================================
        ;; Process-Specific MOSFET Annotations
        ;;================================
        ;; Define annotation preferences for MOS transistors
        ;; These display key device parameters during simulation results annotation
        anno_preference = "id gm rout vgs vds vdsat vth region"

        ;; Apply technology-specific MOS settings if tech_list is defined in tech_settings.il
        if(!boundp('tech_list) then
            warn("YY.cdsinit:\n\ttech_list not defined, skipping MOSFET annotations.\n")
        else
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
    )
)