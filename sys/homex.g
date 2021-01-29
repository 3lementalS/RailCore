; X axis homing file for dc42 Duet firmware

G91                 ; Set to Relative Positioning
G1 H2 Z5 F6000      ; Move Z down 5mm @200mm/min 
G1 H1 X-325 F3000   ; Move X to the left 325mm @3000/min, stop when enstop is triggered
G1 X4 F6000         ; Back off X by 4mm @6000mm/min
G1 H1 X-325 F360    ; Move slowly to X axis endstop
G1 H2 Z-5 F6000     ; Move Z up 4mm @200mm/min
G90                 ; Set to Absolute Positioning