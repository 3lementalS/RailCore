G91
G1 H2 Z5 F500      	; Move Z down 5mm @500mm/min
 
G1 H1 X-999 F3000   ; Move X to the left 999mm @3000/min, stop when enstop is triggered
G1 X5 F500         	; Back off X by 5mm @500mm/min
G1 H1 X-999 F500    ; Move slowly to X axis endstop

G1 H1 Y-999 F3000   ; Move X to the left 999mm @3000/min, stop when enstop is triggered
G1 Y5 F500         	; Back off X by 5mm @500mm/min
G1 H1 Y-999 F500    ; Move slowly to X axis endstop

G90                 		; Set to Absolute Positioning
G1 X149.50 Y114.00 F2400  	; Move to the center of the bed @2400mm/min
G30                 		; Single Z-Probe
M558 F250					; Set probe speed