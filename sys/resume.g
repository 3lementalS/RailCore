G1 R1 X0 Y0 Z2 F5000	; Move to 2mm above resume point
G1 R1 X0 Y0			    ; lower nozzle to resume point
M83				        ; Set extruder to relative mode
G1 E2 F2500		        ; Undo the retraction