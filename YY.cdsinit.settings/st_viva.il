;;================================
;; Filename: YY.cdsinit.settings/st_viva.il
;; Version: 4.0.0
;; Date: Aug. 26, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit Viva Settings and Keybindings
;;================================

procedure( YY_viva_settings()
    ;; Configure fonts for waveform viewing
    envSetVal("viva.axis" "font" 'string "Arial,14,-1,5,50,0,0,0,0,0")
    envSetVal("viva.traceLegend" "font" 'string "Arial,12,-1,5,50,0,0,0,0,0")
    envSetVal("viva.graph" "titleFont" 'string "Arial,14,-1,5,55,0,0,0,0,0")

    ;; Set trace colors for better visibility
    envSetVal("viva.rectGraph" "background" 'string "white")
    envSetVal("viva.graphFrame" "background" 'string "white")
    envSetVal("viva.graph" "colorBank" 'string "#EA5252; #C38720; #4CAF50; #4B9CD3; #AB69C6; #FF9BFF; #FFDF9F; #B4FF7D; #74ffff; #668CFF; #953434; #b06000; #357a38; #0050B0; #8d3e7f; #FF0000; #FF00FF; #0000FF; #3F3F3F; #A3A3A3")
    
    ;; Increase line thickness for trace visibility
    envSetVal("viva.trace" "lineThickness" 'string "thick")

    YY_print("Viva settings ok!")
)
