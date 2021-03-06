G91                 ; Set to Relative Positioning

G1 H2 Z5 F500      	; Move Z down 5mm @500mm/min 
G1 H1 X-999 F3000   ; Move X to the left 999mm @3000/min, stop when enstop is triggered
G1 X5 F500         	; Back off X by 5mm @500mm/min
G1 H1 X-999 F500    ; Move slowly to X axis endstop

G1 H2 Z-5 F6000     ; Move Z up 5mm @6000mm/min
G90                 ; Set to Absolute Positioning