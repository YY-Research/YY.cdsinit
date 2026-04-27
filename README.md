# YY.cdsinit
cdsinit file for my bindkey and settings

## Setup Instructions

### Installation
1. Place the `YY.il` file in your working directory where you launch Cadence Virtuoso.
2. Modify the `YY_cdsinit_filepath` variable in `YY.il` to point to the correct location where this file is installed (e.g., `"/path/to/cdsinit/"`).
3. When launching Virtuoso, type the following command in the CIW (Command Interpreter Window):
   ```
   load("./YY.il")
   ```

### File Structure
- `YY.il` - Main initialization file to be loaded in Virtuoso
- `YY.cdsinit.settings/main.il` - Settings and configuration
- `YY.cdsinit.settings/tech_settings.il` - Technology-specific settings

## Bindkeys
### Schematic
- `ctrl` `1`: Show DC operating point and DC voltage annotations.
- `ctrl` `2`: Show Transient operating point and Transient voltage annotations.
- `ctrl` `0`: Show default annotations.

### Layout
- `shift` `C`: Descend into block.
- `Shift` `X`: Save.
