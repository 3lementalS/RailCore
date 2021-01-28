
G91                 ; Set to Relative Positioning
G1 Z5 F900 H2       ; Move Z down mm @900mm/min (15mm/sec)
G90                 ; Set to Absolute Positioning
G1 X150 Y150 F6000  ; Move to the center of the bed @6000mm/min (100mm/sec)
; M558  Fxxx sets the probing speed.
; Probe rapidly to get us in the right ballpark.
; This brings the bed up quickly but may be less accurate.
M558 F500
G30                 ; Single Z-Probe
M558 F50
G30                 ; Single Z-Probe