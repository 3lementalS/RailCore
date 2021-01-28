; Y axis homing file for dc42 Duet firmware

G91                 ; Set to Relative Positioning
G1 Z4 F200 H2       ; Move Z down 4mm @200mm/min 
G1 Y-325 F3000 H1   ; Move Y to the left 325mm @3000/min, stop when enstop is triggered
G1 Y4 F600          ; Back off Y by 4mm @400mm/min
G1 Y-10 H1          ; Move Y to the left 10mm, stop when enstop is triggered
G1 Z-4 F200 H2      ; Move Z up 4mm @200mm/min
G90                 ; Set to Absolute Positioning