;;================================
;; Filename: YY.cdsinit.il
;; Version: 3.0
;; Date: April 27, 2026
;; Last Edited By: YY
;;================================
;; YY.cdsinit - Virtuoso Initialization File
;;================================
;; This file is the main entry point for custom Virtuoso settings and keybindings.
;; Load this file in Virtuoso CIW using: load("./YY.il")
;;

;; Define the base path for this cdsinit installation
;; Modify this path according to where YY.cdsinit is installed on your system
;; Examples: "./", "/usr/local/cadence/YY.cdsinit/", "C:/path/to/YY.cdsinit/"
YY_cdsinit_filepath = "./"

;; Load the main configuration file containing all settings and keybindings
;; This includes Viva, Schematics, Layout, Symbol editor settings, and technology annotations
load(strcat(YY_cdsinit_filepath, "YY.cdsinit.settings/main.il"))