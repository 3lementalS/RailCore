G91                 ; Set to Relative Positioning
G1 H2 Z5 F6000      ; Move Z down 5mm @6000mm/min 
G1 H1 Y-325 F3000   ; Move Y to the left 325mm @3000/min, stop when enstop is triggered
G1 X5 F6000         ; Back off Y by 5mm @6000mm/min
G1 H1 Y-325 F360    ; Move Y to the left 325mm @360/min, stop when enstop is triggered
G1 H2 Z-5 F6000     ; Move Z up 5mm @6000mm/min
G90                 ; Set to Absolute Positioning