;;================================
;; Filename: YY.cdsinit.settings/fn_cdf.il
;; Version: 4.0.0
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
    if( boundp('YY_initialized) then
        YY_initialized = 1
        ddsOpenLibManager()
    )
)
