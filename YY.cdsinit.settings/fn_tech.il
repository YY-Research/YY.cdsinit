;;================================
;; Filename: YY.cdsinit.settings/fn_tech.il
;; Version: 5.0.0
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
           YY_print("%s detected!\n" techname)
            ;; Apply resistor annotations
            foreach(res_type res_list
                let( (cdfId)
                    cdfId = cdfGetBaseCellCDF(ddGetObj(techname res_type))
                    when( cdfId
                        cdfId->opPointLabelSet = res_anno_preference
                    )
                )
                YY_print("\t  Set annotation %s: %s", res_type, res_anno_preference)
            )
            ;; Apply capacitor annotations
            foreach(cap_type cap_list
                let( (cdfId)
                    cdfId = cdfGetBaseCellCDF(ddGetObj(techname cap_type))
                    when( cdfId
                        cdfId->opPointLabelSet = cap_anno_preference
                    )
                )
                YY_print("\t  Set annotation %s: %s", cap_type, cap_anno_preference)
            )
            YY_print("\tYY.cdsinit: \t %s settings ok!\n", techname)
        )
    )
)


procedure( YY_updateMosAnnotationsByCategory(techName catName anno_preference)
    let( (libObj catObj catMembers cellName cellObj cdfId)        
        ; 2. Get the library object
        libObj = ddGetObj(techName)
        unless(libObj
            YY_error("Cannot find the specified library: %s\n" techName)
        )

        ; 3. Open the specified category in read-only mode ("r")
        catObj = ddCatOpen(libObj catName "r")
        unless(catObj
            YY_error("Cannot find category '%s' in library '%s' (check case sensitivity)\n" catName techName)
        )

        YY_print("\tScanning category: %s in library: %s ..." catName techName)

        ; 4. Get all members within the category
        catMembers = ddCatGetCatMembers(catObj)
        
        ; 5. Iterate through the category members and update the cells
        foreach( member catMembers
            ; 'member' is a list like ("nch" "cell") or ("SubCat" "category")
            if( cadr(member) == "cell" then
                cellName = car(member)
                
                ; Get the cell object and its Base CDF
                cellObj = ddGetObj(techName cellName)
                when( cellObj
                    cdfId = cdfGetBaseCellCDF(cellObj)
                    when( cdfId
                        YY_print("\t\t-> Found and updated cell: %s" cellName)
                        cdfId->opPointLabelSet = anno_preference
                    )
                )
            )
        )
        
        ; Close the category object to release resources
        ddCatClose(catObj)
        YY_print("\tAnnotation update completed successfully!")
    )
)

;;================================
;; Load Technology-Specific Settings
;;================================
procedure( YY_load_tech_settings()
    let( (YY_tech_settings_file anno_preference techname mos_list)
        if( !boundp('YY_cdsinit_filepath) then
            YY_warn("YY_cdsinit_filepath not defined, using current directory.")
            YY_cdsinit_filepath = "./"
        )
        YY_tech_settings_file = strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/tech_settings.il")
        if( isFile(YY_tech_settings_file) then
            load(YY_tech_settings_file)
        else
            YY_warn("Missing file %s, skipping technology-specific settings." YY_tech_settings_file)
        )
        ;;================================
        ;; Process-Specific MOSFET Annotations
        ;;================================
        ;; Define annotation preferences for MOS transistors
        ;; These display key device parameters during simulation results annotation
        anno_preference = "id gm rout vgs vds vdsat vth region"

        ;; Apply technology-specific MOS settings if tech_list is defined in tech_settings.il
        if(!boundp('tech_list) then
            YY_warn("tech_list not defined, skipping MOSFET annotations.")
        else
            for(tech_num 0 (length(tech_list)-1)
                techname = nth(tech_num tech_list)
                ;; Check if technology library is available
                if( ddGetObj(techname) then
                    YY_print("\n\tYY.cdsinit: \t %s detected!" techname)
                    YY_updateMosAnnotationsByCategory(techname "Mosfet_4T" anno_preference)
                    YY_print("%s settings ok!\n", techname)
                )
            )
        )
    )
)