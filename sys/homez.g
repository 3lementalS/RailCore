
G91                 ; Set to Relative Positioning
G1 H2 Z5 F6000       ; Move Z down 5mm @3000mm/min (50mm/sec)
G90                 ; Set to Absolute Positioning
G1 X150 Y150 F6000  ; Move to the center of the bed @6000mm/min (100mm/sec)
; M558  Fxxx sets the probing speed.
; Probe rapidly to get us in the right ballpark.
; This brings the bed up quickly but may be less accurate.
M558 F500
G30                 ; Single Z-Probe
M558 F50
G30                 ; Single Z-Probe