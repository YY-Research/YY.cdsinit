;;================================
;; Filename: YY.cdsinit.settings/fn_cdf.il
;; Version: 4.1.0
;; Date: Aug. 26, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit CDF Settings
;;================================

procedure( YY_print(print_str)
    printf("\tYY.cdsinit: \t %s\n", print_str)
)

procedure( YY_warn(print_str)
    warn("\tYY.cdsinit: \t %s\n", print_str)
)

procedure( YY_error(print_str)
    error("\tYY.cdsinit: \t %s\n", print_str)
)

procedure( YY_init()
    if( !boundp('YY_initialized) then
        YY_initialized = 1
        ddsOpenLibManager()
    )
)

procedure( _YY_update_CDF(libName cellName pParName defaultVal)
    let( (cellObj cdfId cdf_param)
        cellObj = ddGetObj(libName cellName)
        cdfId = cdfGetBaseCellCDF(cellObj)
         
        ;; Create Base CDF if it does not exist
        if( null(cdfId) then
            cdfId = cdfCreateBaseCellCDF(cellObj)
        )
        
        cdf_param = cdfFindParamByName(cdfId pParName)
        if( cdf_param then
            printf("\tYY.cdsinit: \t Parameter %s exists in %s/%s\n" pParName libName cellName)
            when( defaultVal != "" 
	        cdf_param~>defValue = defaultVal
                printf("\t            \t Default value of Parameter %s updated to %s\n" pParName defaultVal)
            )
        else
            cdfCreateParam( cdfId
                ?name       pParName
                ?prompt     pParName
                ?type       "string"
                ?defValue   defaultVal
                ?display    "t"
                ?parseAsCEL "yes"
            )
            printf("\tYY.cdsinit: \t Parameter %s added to %s/%s\n" pParName libName cellName)
        )
        cdfSaveCDF(cdfId)
        ;; printf("\tYY.cdsinit: \t CDF saved.\n")
    )
)

procedure( YY_autosync_CDF(libName cellName)
    let((cv cdfId pParList propValue paramName)
        ;; Go through Schematic
        cv = dbOpenCellViewByType(libName cellName "schematic")
        if(null(cv) then
            warn("\tYY.cdsinit: \t Cannot open schematic: %s/%s\n" libName cellName)
            return(nil)
        )

        pParList = nil

        ;; Set regular expression
        rexCompile("pPar(\"\\([^\"]+\\)\")")

        foreach(inst cv~>instances
            foreach(prop inst~>prop
                if(prop~>valueType == "string" then
                    propValue = prop~>value
                    ;; Check if it is pPar
                    if(rexExecute(propValue) then
                        paramName = rexSubstitute("\\1") ;; 
                        unless(member(paramName pParList)
                            pParList = cons(paramName pParList)
                        )
                    )
                )
            )
        )
        dbClose(cv)

        ;; Update to Base CDF
        if(pParList then
            cdfId = cdfGetBaseCellCDF(ddGetObj(libName cellName))
            if(null(cdfId) then
                cdfId = cdfCreateBaseCellCDF(ddGetObj(libName cellName))
            )

            foreach(p pParList
                YY_update_CDF(libName cellName p "")
            )
            printf("\tYY.cdsinit: \t Successfully sync %d pPar from schematic to CDF\n" length(pParList))
        else
            warn("\tYY.cdsinit: \t No pPar found in schematic\n\n")
        )
    )
)

procedure( YY_sortpar_CDF(libName cellName)
    let((cdfId paramDataList)
        cdfId = cdfGetBaseCellCDF(ddGetObj(libName cellName))
        if(cdfId then
            paramDataList = nil

            ;; Backup all parameters
            foreach(p cdfId~>parameters
                paramDataList = cons(
                    list(p~>name p~>prompt p~>defValue p~>type p~>display p~>parseAsCEL)
                    paramDataList
                )
            )
            ;; Sort all parameters
            paramDataList = sortcar(paramDataList 'alphalessp)

            ;; Delete all parameters
            foreach(p cdfId~>parameters
                cdfDeleteParam(p)
            )
            printf("\tYY.cdsinit: \t \n")
            foreach(pData paramDataList
                printf("\t            \t %s\n" nth(0 pData))
                cdfCreateParam( cdfId
                    ?name        nth(0 pData)
                    ?prompt      nth(1 pData)
                    ?defValue    nth(2 pData)
                    ?type        "string"
                    ?display     "t"
                    ?parseAsCEL  "yes"
                )
            )
            cdfSaveCDF(cdfId)
            printf("\tYY.cdsinit: \t Parameters (%s/%s) sorted alphabetically\n" libName cellName)
        else
            error("\tYY.cdsinit: \t Missing Base CDF for %s/%s" libName cellName)
        )
    )
)

procedure( YY_set_pPar(libName cellName)
    let((cv pParList propValue paramName val cdfId cdfParamNames orderedParList)
        
        ;; Step 1: Open schematic to fetch all pPars
        cv = dbOpenCellViewByType(libName cellName "schematic")
        if(null(cv) then
            warn("\tYY.cdsinit: \t Cannot open schematic: %s/%s\n" libName cellName)
            return(nil)
        )
 
    pParList = nil

    ;; Compile regular expression to find pPar("...")
        rexCompile("pPar(\"\\([^\"]+\\)\")")

        ;; Loop through all instances and their properties to find pPars
        foreach(inst cv~>instances
            foreach(prop inst~>prop
                if(prop~>valueType == "string" then
                    propValue = prop~>value
                    ;; Check if it matches pPar format
                    if(rexExecute(propValue) then
                        paramName = rexSubstitute("\\1") 
                        unless(member(paramName pParList)
                            pParList = cons(paramName pParList)
                        )
                    )
                )
            )
        )
        dbClose(cv)

    ;; Step 1.5: Reorder pParList to match existing CDF order
        cdfId = cdfGetBaseCellCDF(ddGetObj(libName cellName))
        if(cdfId then
            cdfParamNames = cdfId~>parameters~>name
            orderedParList = nil
            
            ;; Match with existing CDF parameters
            foreach(cName cdfParamNames
                if(member(cName pParList) then
                    orderedParList = cons(cName orderedParList)
                    ;; Remove from pParList so we know what's left (new pPars)
                    pParList = remove(cName pParList) 
                )
            )
            ;; Reverse to restore the correct CDF top-to-bottom order
            orderedParList = reverse(orderedParList)
            
            ;; Any remaining in pParList are new. Sort them alphabetically and append to the end.
            if(pParList then
                pParList = sort(pParList 'alphalessp)
                pParList = append(orderedParList pParList)
            else
                pParList = orderedParList
            )
        else
            ;; If no CDF exists at all, just sort everything alphabetically
            pParList = sort(pParList 'alphalessp)
        )

    ;; Step 2: Prompt user in CIW for each found pPar
        if(pParList then
            printf("\n\tYY.cdsinit: \t Found %d pPar(s) in %s/%s.\n" length(pParList) libName cellName)
            printf("\tYY.cdsinit: \t Please enter default values below.\n")
            printf("\tYY.cdsinit: \t (Type a dot '.' and press Enter to skip!)\n\n")
            
            foreach(p pParList
                printf("\tEnter default value for '%s' [type '.' to skip]: \n" p)
                
                gets(val piport) 
                
                if(stringp(val) then
                    ;; Remove newline and carriage return characters
                    val = buildString(parseString(val "\n\r") "")
                    
                    ;; If user types a dot "." or a space " ", treat it as skip
                    if(val == "." || val == " " then
                        val = ""
                    )
                else
                    val = ""
                )
                
                ;; Call your existing function to update/create the parameter
                YY_update_CDF(libName cellName p val)
            )
            
            printf("\n\tYY.cdsinit: \t Finished updating pPar default values for %s/%s.\n" libName cellName)
        else
            printf("\tYY.cdsinit: \t No pPar found in schematic for %s/%s.\n" libName cellName)
        )
        
        t ; Return true upon completion
    )
)